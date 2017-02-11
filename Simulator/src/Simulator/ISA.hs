module Simulator.ISA where

import Control.Lens
import Control.Monad.State
import Data.Bits
import Data.Int
import Data.Word
import Simulator.RAM
import Simulator.Types
import Simulator.Util

data Op = ADD | SUB | AND | XOR

exec s i a = return (flip execState s a, i)

halt s@(CpuState {..}) = exec s Halt $ do
  stat .= HLT
  pc += 1

nop s@(CpuState {..}) = exec s Nop $ pc += 1

rrmovl ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Rrmovl ra rb) $ do
    regSetter rb .= readReg ra s
    pc += 2

irmovl ram s@(CpuState {..}) = do
  (_, rb, v) <- readRRL ram _pc
  exec s (Irmovl rb v) $ do
    regSetter rb .= v
    pc += 6

rmmovl ram s@(CpuState {..}) = do
  (ra, rb, d) <- readRRL ram _pc
  let addr = readReg rb s + d
  writeWord32 ram addr (readReg ra s)
  exec s (Rmmovl ra rb d) $ pc += 6

mrmovl ram s@(CpuState {..}) = do
  (ra, rb, d) <- readRRL ram _pc
  let addr = readReg rb s + d
  v <- readWord32 ram addr
  exec s (Mrmovl ra rb d) $ do
    regSetter ra .= v
    pc += 6

setFlags :: Word32 -> Word32 -> Word32 -> Op -> State CpuState ()
setFlags a b v o = do
  -- ZF
  if v == 0
    then zF .= True
    else zF .= False
  -- SF
  sF .= testBit v 31
  -- OF
  let a' = w2i a
      b' = w2i b
      v' = w2i v
  oF .= case o of
          ADD -> ((a' < 0) == (b' < 0)) && ((v' < 0) /= (a' < 0))
          SUB -> ((a' > 0) == (b' < 0)) && ((v' < 0) /= (b' < 0))
          AND -> False
          XOR -> False
  where
  w2i x = fromIntegral x :: Int32

doOp rb a b v o = do
  regSetter rb .= v
  setFlags a b v o
  pc += 2

addl ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Addl ra rb) $ do
    let a = readReg ra s
        b = readReg rb s
        v = a + b
    doOp rb a b v AND

subl ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Subl ra rb) $ do
    let a = readReg ra s
        b = readReg rb s
        v = b - a
    doOp rb a b v SUB

andl ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Andl ra rb) $ do
    let a = readReg ra s
        b = readReg rb s
        v = a .&. b
    doOp rb a b v AND

xorl ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Xorl ra rb) $ do
    let a = readReg ra s
        b = readReg rb s
        v = a `xor` b
    doOp rb a b v XOR

jmp ram s@(CpuState {..}) = do
  dst <- readWord32 ram (_pc + 1)
  exec s (Jmp dst) $ pc .= dst

jmpWhen :: Word32 -> Bool -> State CpuState ()
jmpWhen dst b = if b then pc .= dst else pc += 5

jle ram s@(CpuState {..}) = do
  dst <- readWord32 ram (_pc + 1)
  exec s (Jle dst) $ jmpWhen dst $ (_sF  `xor` _oF ) || _zF

jl ram s@(CpuState {..}) = do
  dst <- readWord32 ram (_pc + 1)
  exec s (Jl dst) $ jmpWhen dst $ _sF  `xor` _oF

je ram s@(CpuState {..}) = do
  dst <- readWord32 ram (_pc + 1)
  exec s (Je dst) $ jmpWhen dst _zF

jne ram s@(CpuState {..}) = do
  dst <- readWord32 ram (_pc + 1)
  exec s (Jne dst) $ jmpWhen dst $ not _zF

jge ram s@(CpuState {..}) = do
  dst <- readWord32 ram (_pc + 1)
  exec s (Jge dst) $ jmpWhen dst $ not (_sF  `xor` _oF )

jg ram s@(CpuState {..}) = do
  dst <- readWord32 ram (_pc + 1)
  exec s (Jg dst) $ jmpWhen dst $ not (_sF  `xor` _oF ) && not _zF

movWhen :: RegId -> RegId -> CpuState -> Bool -> State CpuState ()
movWhen ra rb s b = do
  if b
    then regSetter rb .= readReg ra s
    else return ()
  pc += 2

cmovle ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Cmovle ra rb) $ movWhen ra rb s $ (_sF  `xor` _oF ) || _zF

cmovl ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Cmovl ra rb) $ movWhen ra rb s $ _sF  `xor` _oF

cmove ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Cmove ra rb) $ movWhen ra rb s _zF

cmovne ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Cmovne ra rb) $ movWhen ra rb s $ not _zF

cmovge ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Cmovge ra rb) $ movWhen ra rb s $ not (_sF  `xor` _oF )

cmovg  ram s@(CpuState {..}) = do
  (ra, rb) <- readRR ram _pc
  exec s (Cmovge ra rb) $ movWhen ra rb s $ not (_sF  `xor` _oF ) && not _zF

readEsp s = readReg 4 s
espSetter = regSetter 4

call ram s@(CpuState {..}) = do
  dst <- readWord32 ram (_pc + 1)
  let esp' = readEsp s
  writeWord32 ram (esp' - 4) (_pc + 5)
  exec s (Call dst) $ do
    espSetter .= esp' - 4
    pc .= dst

ret ram s@(CpuState {..}) = do
  let esp' = readEsp s
  addr <- readWord32 ram esp'
  exec s Ret $ do
    espSetter .= esp' + 4
    pc .= addr

pushl ram s@(CpuState {..}) = do
  (ra, _) <- readRR ram _pc
  let esp' = readEsp s
  writeWord32 ram (esp' - 4) (readReg ra s)
  exec s (Pushl ra) $ do
    espSetter .= esp' - 4
    pc += 2

popl ram s@(CpuState {..}) = do
  (ra, _) <- readRR ram _pc
  let esp' = readEsp s
  a <- readWord32 ram esp'
  exec s (Popl ra) $ do
    regSetter ra .= a
    espSetter .= esp' + 4
    pc += 2
