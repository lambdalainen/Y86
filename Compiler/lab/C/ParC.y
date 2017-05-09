-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParC where
import AbsC
import LexC
import ErrM

}

%name pProgram Program
%name pStm Stm
%name pExp Exp
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '!' { PT _ (TS _ 1) }
  '!=' { PT _ (TS _ 2) }
  '%' { PT _ (TS _ 3) }
  '%=' { PT _ (TS _ 4) }
  '&' { PT _ (TS _ 5) }
  '&&' { PT _ (TS _ 6) }
  '&=' { PT _ (TS _ 7) }
  '(' { PT _ (TS _ 8) }
  ')' { PT _ (TS _ 9) }
  '*' { PT _ (TS _ 10) }
  '*=' { PT _ (TS _ 11) }
  '+' { PT _ (TS _ 12) }
  '++' { PT _ (TS _ 13) }
  '+=' { PT _ (TS _ 14) }
  ',' { PT _ (TS _ 15) }
  '-' { PT _ (TS _ 16) }
  '--' { PT _ (TS _ 17) }
  '-=' { PT _ (TS _ 18) }
  '->' { PT _ (TS _ 19) }
  '.' { PT _ (TS _ 20) }
  '...' { PT _ (TS _ 21) }
  '/' { PT _ (TS _ 22) }
  '/=' { PT _ (TS _ 23) }
  ':' { PT _ (TS _ 24) }
  ';' { PT _ (TS _ 25) }
  '<' { PT _ (TS _ 26) }
  '<<' { PT _ (TS _ 27) }
  '<<=' { PT _ (TS _ 28) }
  '<=' { PT _ (TS _ 29) }
  '=' { PT _ (TS _ 30) }
  '==' { PT _ (TS _ 31) }
  '>' { PT _ (TS _ 32) }
  '>=' { PT _ (TS _ 33) }
  '>>' { PT _ (TS _ 34) }
  '>>=' { PT _ (TS _ 35) }
  '?' { PT _ (TS _ 36) }
  'Typedef_name' { PT _ (TS _ 37) }
  '[' { PT _ (TS _ 38) }
  ']' { PT _ (TS _ 39) }
  '^' { PT _ (TS _ 40) }
  '^=' { PT _ (TS _ 41) }
  'auto' { PT _ (TS _ 42) }
  'break' { PT _ (TS _ 43) }
  'case' { PT _ (TS _ 44) }
  'char' { PT _ (TS _ 45) }
  'const' { PT _ (TS _ 46) }
  'continue' { PT _ (TS _ 47) }
  'default' { PT _ (TS _ 48) }
  'do' { PT _ (TS _ 49) }
  'double' { PT _ (TS _ 50) }
  'else' { PT _ (TS _ 51) }
  'enum' { PT _ (TS _ 52) }
  'extern' { PT _ (TS _ 53) }
  'float' { PT _ (TS _ 54) }
  'for' { PT _ (TS _ 55) }
  'goto' { PT _ (TS _ 56) }
  'if' { PT _ (TS _ 57) }
  'int' { PT _ (TS _ 58) }
  'long' { PT _ (TS _ 59) }
  'register' { PT _ (TS _ 60) }
  'return' { PT _ (TS _ 61) }
  'short' { PT _ (TS _ 62) }
  'signed' { PT _ (TS _ 63) }
  'sizeof' { PT _ (TS _ 64) }
  'static' { PT _ (TS _ 65) }
  'struct' { PT _ (TS _ 66) }
  'switch' { PT _ (TS _ 67) }
  'typedef' { PT _ (TS _ 68) }
  'union' { PT _ (TS _ 69) }
  'unsigned' { PT _ (TS _ 70) }
  'void' { PT _ (TS _ 71) }
  'volatile' { PT _ (TS _ 72) }
  'while' { PT _ (TS _ 73) }
  '{' { PT _ (TS _ 74) }
  '|' { PT _ (TS _ 75) }
  '|=' { PT _ (TS _ 76) }
  '||' { PT _ (TS _ 77) }
  '}' { PT _ (TS _ 78) }
  '~' { PT _ (TS _ 79) }

L_ident  { PT _ (TV $$) }
L_quoted { PT _ (TL $$) }
L_doubl  { PT _ (TD $$) }
L_charac { PT _ (TC $$) }
L_integ  { PT _ (TI $$) }
L_Unsigned { PT _ (T_Unsigned $$) }
L_Long { PT _ (T_Long $$) }
L_UnsignedLong { PT _ (T_UnsignedLong $$) }
L_Hexadecimal { PT _ (T_Hexadecimal $$) }
L_HexUnsigned { PT _ (T_HexUnsigned $$) }
L_HexLong { PT _ (T_HexLong $$) }
L_HexUnsLong { PT _ (T_HexUnsLong $$) }
L_Octal { PT _ (T_Octal $$) }
L_OctalUnsigned { PT _ (T_OctalUnsigned $$) }
L_OctalLong { PT _ (T_OctalLong $$) }
L_OctalUnsLong { PT _ (T_OctalUnsLong $$) }
L_CDouble { PT _ (T_CDouble $$) }
L_CFloat { PT _ (T_CFloat $$) }
L_CLongDouble { PT _ (T_CLongDouble $$) }


%%

Ident   :: { Ident }   : L_ident  { Ident $1 }
String  :: { String }  : L_quoted {  $1 }
Double  :: { Double }  : L_doubl  { (read ( $1)) :: Double }
Char    :: { Char }    : L_charac { (read ( $1)) :: Char }
Integer :: { Integer } : L_integ  { (read ( $1)) :: Integer }
Unsigned    :: { Unsigned} : L_Unsigned { Unsigned ($1)}
Long    :: { Long} : L_Long { Long ($1)}
UnsignedLong    :: { UnsignedLong} : L_UnsignedLong { UnsignedLong ($1)}
Hexadecimal    :: { Hexadecimal} : L_Hexadecimal { Hexadecimal ($1)}
HexUnsigned    :: { HexUnsigned} : L_HexUnsigned { HexUnsigned ($1)}
HexLong    :: { HexLong} : L_HexLong { HexLong ($1)}
HexUnsLong    :: { HexUnsLong} : L_HexUnsLong { HexUnsLong ($1)}
Octal    :: { Octal} : L_Octal { Octal ($1)}
OctalUnsigned    :: { OctalUnsigned} : L_OctalUnsigned { OctalUnsigned ($1)}
OctalLong    :: { OctalLong} : L_OctalLong { OctalLong ($1)}
OctalUnsLong    :: { OctalUnsLong} : L_OctalUnsLong { OctalUnsLong ($1)}
CDouble    :: { CDouble} : L_CDouble { CDouble ($1)}
CFloat    :: { CFloat} : L_CFloat { CFloat ($1)}
CLongDouble    :: { CLongDouble} : L_CLongDouble { CLongDouble ($1)}

Program :: { Program }
Program : ListExternal_declaration { AbsC.Progr $1 }
ListExternal_declaration :: { [External_declaration] }
ListExternal_declaration : External_declaration { (:[]) $1 }
                         | External_declaration ListExternal_declaration { (:) $1 $2 }
External_declaration :: { External_declaration }
External_declaration : Function_def { AbsC.Afunc $1 }
                     | Dec { AbsC.Global $1 }
Function_def :: { Function_def }
Function_def : ListDeclaration_specifier Declarator ListDec Compound_stm { AbsC.OldFunc $1 $2 $3 $4 }
             | ListDeclaration_specifier Declarator Compound_stm { AbsC.NewFunc $1 $2 $3 }
             | Declarator ListDec Compound_stm { AbsC.OldFuncInt $1 $2 $3 }
             | Declarator Compound_stm { AbsC.NewFuncInt $1 $2 }
Dec :: { Dec }
Dec : ListDeclaration_specifier ';' { AbsC.NoDeclarator $1 }
    | ListDeclaration_specifier ListInit_declarator ';' { AbsC.Declarators $1 $2 }
ListDec :: { [Dec] }
ListDec : Dec { (:[]) $1 } | Dec ListDec { (:) $1 $2 }
ListDeclaration_specifier :: { [Declaration_specifier] }
ListDeclaration_specifier : Declaration_specifier { (:[]) $1 }
                          | Declaration_specifier ListDeclaration_specifier { (:) $1 $2 }
Declaration_specifier :: { Declaration_specifier }
Declaration_specifier : Type_specifier { AbsC.Type $1 }
                      | Storage_class_specifier { AbsC.Storage $1 }
                      | Type_qualifier { AbsC.SpecProp $1 }
ListInit_declarator :: { [Init_declarator] }
ListInit_declarator : Init_declarator { (:[]) $1 }
                    | Init_declarator ',' ListInit_declarator { (:) $1 $3 }
Init_declarator :: { Init_declarator }
Init_declarator : Declarator { AbsC.OnlyDecl $1 }
                | Declarator '=' Initializer { AbsC.InitDecl $1 $3 }
Type_specifier :: { Type_specifier }
Type_specifier : 'void' { AbsC.Tvoid }
               | 'char' { AbsC.Tchar }
               | 'short' { AbsC.Tshort }
               | 'int' { AbsC.Tint }
               | 'long' { AbsC.Tlong }
               | 'float' { AbsC.Tfloat }
               | 'double' { AbsC.Tdouble }
               | 'signed' { AbsC.Tsigned }
               | 'unsigned' { AbsC.Tunsigned }
               | Struct_or_union_spec { AbsC.Tstruct $1 }
               | Enum_specifier { AbsC.Tenum $1 }
               | 'Typedef_name' { AbsC.Tname }
Storage_class_specifier :: { Storage_class_specifier }
Storage_class_specifier : 'typedef' { AbsC.MyType }
                        | 'extern' { AbsC.GlobalPrograms }
                        | 'static' { AbsC.LocalProgram }
                        | 'auto' { AbsC.LocalBlock }
                        | 'register' { AbsC.LocalReg }
Type_qualifier :: { Type_qualifier }
Type_qualifier : 'const' { AbsC.Const }
               | 'volatile' { AbsC.NoOptim }
Struct_or_union_spec :: { Struct_or_union_spec }
Struct_or_union_spec : Struct_or_union Ident '{' ListStruct_dec '}' { AbsC.Tag $1 $2 $4 }
                     | Struct_or_union '{' ListStruct_dec '}' { AbsC.Unique $1 $3 }
                     | Struct_or_union Ident { AbsC.TagType $1 $2 }
Struct_or_union :: { Struct_or_union }
Struct_or_union : 'struct' { AbsC.Struct } | 'union' { AbsC.Union }
ListStruct_dec :: { [Struct_dec] }
ListStruct_dec : Struct_dec { (:[]) $1 }
               | Struct_dec ListStruct_dec { (:) $1 $2 }
Struct_dec :: { Struct_dec }
Struct_dec : ListSpec_qual ListStruct_declarator ';' { AbsC.Structen $1 $2 }
ListSpec_qual :: { [Spec_qual] }
ListSpec_qual : Spec_qual { (:[]) $1 }
              | Spec_qual ListSpec_qual { (:) $1 $2 }
Spec_qual :: { Spec_qual }
Spec_qual : Type_specifier { AbsC.TypeSpec $1 }
          | Type_qualifier { AbsC.QualSpec $1 }
ListStruct_declarator :: { [Struct_declarator] }
ListStruct_declarator : Struct_declarator { (:[]) $1 }
                      | Struct_declarator ',' ListStruct_declarator { (:) $1 $3 }
Struct_declarator :: { Struct_declarator }
Struct_declarator : Declarator { AbsC.Decl $1 }
                  | ':' Constant_expression { AbsC.Field $2 }
                  | Declarator ':' Constant_expression { AbsC.DecField $1 $3 }
Enum_specifier :: { Enum_specifier }
Enum_specifier : 'enum' '{' ListEnumerator '}' { AbsC.EnumDec $3 }
               | 'enum' Ident '{' ListEnumerator '}' { AbsC.EnumName $2 $4 }
               | 'enum' Ident { AbsC.EnumVar $2 }
ListEnumerator :: { [Enumerator] }
ListEnumerator : Enumerator { (:[]) $1 }
               | Enumerator ',' ListEnumerator { (:) $1 $3 }
Enumerator :: { Enumerator }
Enumerator : Ident { AbsC.Plain $1 }
           | Ident '=' Constant_expression { AbsC.EnumInit $1 $3 }
Declarator :: { Declarator }
Declarator : Pointer Direct_declarator { AbsC.BeginPointer $1 $2 }
           | Direct_declarator { AbsC.NoPointer $1 }
Direct_declarator :: { Direct_declarator }
Direct_declarator : Ident { AbsC.Name $1 }
                  | '(' Declarator ')' { AbsC.ParenDecl $2 }
                  | Direct_declarator '[' Constant_expression ']' { AbsC.InnitArray $1 $3 }
                  | Direct_declarator '[' ']' { AbsC.Incomplete $1 }
                  | Direct_declarator '(' Parameter_type ')' { AbsC.NewFuncDec $1 $3 }
                  | Direct_declarator '(' ListIdent ')' { AbsC.OldFuncDef $1 $3 }
                  | Direct_declarator '(' ')' { AbsC.OldFuncDec $1 }
Pointer :: { Pointer }
Pointer : '*' { AbsC.Point }
        | '*' ListType_qualifier { AbsC.PointQual $2 }
        | '*' Pointer { AbsC.PointPoint $2 }
        | '*' ListType_qualifier Pointer { AbsC.PointQualPoint $2 $3 }
ListType_qualifier :: { [Type_qualifier] }
ListType_qualifier : Type_qualifier { (:[]) $1 }
                   | Type_qualifier ListType_qualifier { (:) $1 $2 }
Parameter_type :: { Parameter_type }
Parameter_type : Parameter_declarations { AbsC.AllSpec $1 }
               | Parameter_declarations ',' '...' { AbsC.More $1 }
Parameter_declarations :: { Parameter_declarations }
Parameter_declarations : Parameter_declaration { AbsC.ParamDec $1 }
                       | Parameter_declarations ',' Parameter_declaration { AbsC.MoreParamDec $1 $3 }
Parameter_declaration :: { Parameter_declaration }
Parameter_declaration : ListDeclaration_specifier { AbsC.OnlyType $1 }
                      | ListDeclaration_specifier Declarator { AbsC.TypeAndParam $1 $2 }
                      | ListDeclaration_specifier Abstract_declarator { AbsC.Abstract $1 $2 }
ListIdent :: { [Ident] }
ListIdent : Ident { (:[]) $1 } | Ident ',' ListIdent { (:) $1 $3 }
Initializer :: { Initializer }
Initializer : Exp2 { AbsC.InitExpr $1 }
            | '{' Initializers '}' { AbsC.InitListOne $2 }
            | '{' Initializers ',' '}' { AbsC.InitListTwo $2 }
Initializers :: { Initializers }
Initializers : Initializer { AbsC.AnInit $1 }
             | Initializers ',' Initializer { AbsC.MoreInit $1 $3 }
Type_name :: { Type_name }
Type_name : ListSpec_qual { AbsC.PlainType $1 }
          | ListSpec_qual Abstract_declarator { AbsC.ExtendedType $1 $2 }
Abstract_declarator :: { Abstract_declarator }
Abstract_declarator : Pointer { AbsC.PointerStart $1 }
                    | Dir_abs_dec { AbsC.Advanced $1 }
                    | Pointer Dir_abs_dec { AbsC.PointAdvanced $1 $2 }
Dir_abs_dec :: { Dir_abs_dec }
Dir_abs_dec : '(' Abstract_declarator ')' { AbsC.WithinParentes $2 }
            | '[' ']' { AbsC.Array }
            | '[' Constant_expression ']' { AbsC.InitiatedArray $2 }
            | Dir_abs_dec '[' ']' { AbsC.UnInitiated $1 }
            | Dir_abs_dec '[' Constant_expression ']' { AbsC.Initiated $1 $3 }
            | '(' ')' { AbsC.OldFunction }
            | '(' Parameter_type ')' { AbsC.NewFunction $2 }
            | Dir_abs_dec '(' ')' { AbsC.OldFuncExpr $1 }
            | Dir_abs_dec '(' Parameter_type ')' { AbsC.NewFuncExpr $1 $3 }
Stm :: { Stm }
Stm : Labeled_stm { AbsC.LabelS $1 }
    | Compound_stm { AbsC.CompS $1 }
    | Expression_stm { AbsC.ExprS $1 }
    | Selection_stm { AbsC.SelS $1 }
    | Iter_stm { AbsC.IterS $1 }
    | Jump_stm { AbsC.JumpS $1 }
Labeled_stm :: { Labeled_stm }
Labeled_stm : Ident ':' Stm { AbsC.SlabelOne $1 $3 }
            | 'case' Constant_expression ':' Stm { AbsC.SlabelTwo $2 $4 }
            | 'default' ':' Stm { AbsC.SlabelThree $3 }
Compound_stm :: { Compound_stm }
Compound_stm : '{' '}' { AbsC.ScompOne }
             | '{' ListStm '}' { AbsC.ScompTwo $2 }
             | '{' ListDec '}' { AbsC.ScompThree $2 }
             | '{' ListDec ListStm '}' { AbsC.ScompFour $2 $3 }
Expression_stm :: { Expression_stm }
Expression_stm : ';' { AbsC.SexprOne }
               | Exp ';' { AbsC.SexprTwo $1 }
Selection_stm :: { Selection_stm }
Selection_stm : 'if' '(' Exp ')' Stm { AbsC.SselOne $3 $5 }
              | 'if' '(' Exp ')' Stm 'else' Stm { AbsC.SselTwo $3 $5 $7 }
              | 'switch' '(' Exp ')' Stm { AbsC.SselThree $3 $5 }
Iter_stm :: { Iter_stm }
Iter_stm : 'while' '(' Exp ')' Stm { AbsC.SiterOne $3 $5 }
         | 'do' Stm 'while' '(' Exp ')' ';' { AbsC.SiterTwo $2 $5 }
         | 'for' '(' Expression_stm Expression_stm ')' Stm { AbsC.SiterThree $3 $4 $6 }
         | 'for' '(' Expression_stm Expression_stm Exp ')' Stm { AbsC.SiterFour $3 $4 $5 $7 }
Jump_stm :: { Jump_stm }
Jump_stm : 'goto' Ident ';' { AbsC.SjumpOne $2 }
         | 'continue' ';' { AbsC.SjumpTwo }
         | 'break' ';' { AbsC.SjumpThree }
         | 'return' ';' { AbsC.SjumpFour }
         | 'return' Exp ';' { AbsC.SjumpFive $2 }
ListStm :: { [Stm] }
ListStm : Stm { (:[]) $1 } | Stm ListStm { (:) $1 $2 }
Exp :: { Exp }
Exp : Exp ',' Exp2 { AbsC.Ecomma $1 $3 } | Exp2 { $1 }
Exp2 :: { Exp }
Exp2 : Exp15 Assignment_op Exp2 { AbsC.Eassign $1 $2 $3 }
     | Exp3 { $1 }
Exp3 :: { Exp }
Exp3 : Exp4 '?' Exp ':' Exp3 { AbsC.Econdition $1 $3 $5 }
     | Exp4 { $1 }
Exp4 :: { Exp }
Exp4 : Exp4 '||' Exp5 { AbsC.Elor $1 $3 } | Exp5 { $1 }
Exp5 :: { Exp }
Exp5 : Exp5 '&&' Exp6 { AbsC.Eland $1 $3 } | Exp6 { $1 }
Exp6 :: { Exp }
Exp6 : Exp6 '|' Exp7 { AbsC.Ebitor $1 $3 } | Exp7 { $1 }
Exp7 :: { Exp }
Exp7 : Exp7 '^' Exp8 { AbsC.Ebitexor $1 $3 } | Exp8 { $1 }
Exp8 :: { Exp }
Exp8 : Exp8 '&' Exp9 { AbsC.Ebitand $1 $3 } | Exp9 { $1 }
Exp9 :: { Exp }
Exp9 : Exp9 '==' Exp10 { AbsC.Eeq $1 $3 }
     | Exp9 '!=' Exp10 { AbsC.Eneq $1 $3 }
     | Exp10 { $1 }
Exp10 :: { Exp }
Exp10 : Exp10 '<' Exp11 { AbsC.Elthen $1 $3 }
      | Exp10 '>' Exp11 { AbsC.Egrthen $1 $3 }
      | Exp10 '<=' Exp11 { AbsC.Ele $1 $3 }
      | Exp10 '>=' Exp11 { AbsC.Ege $1 $3 }
      | Exp11 { $1 }
Exp11 :: { Exp }
Exp11 : Exp11 '<<' Exp12 { AbsC.Eleft $1 $3 }
      | Exp11 '>>' Exp12 { AbsC.Eright $1 $3 }
      | Exp12 { $1 }
Exp12 :: { Exp }
Exp12 : Exp12 '+' Exp13 { AbsC.Eplus $1 $3 }
      | Exp12 '-' Exp13 { AbsC.Eminus $1 $3 }
      | Exp13 { $1 }
Exp13 :: { Exp }
Exp13 : Exp13 '*' Exp14 { AbsC.Etimes $1 $3 }
      | Exp13 '/' Exp14 { AbsC.Ediv $1 $3 }
      | Exp13 '%' Exp14 { AbsC.Emod $1 $3 }
      | Exp14 { $1 }
Exp14 :: { Exp }
Exp14 : '(' Type_name ')' Exp14 { AbsC.Etypeconv $2 $4 }
      | Exp15 { $1 }
Exp15 :: { Exp }
Exp15 : '++' Exp15 { AbsC.Epreinc $2 }
      | '--' Exp15 { AbsC.Epredec $2 }
      | Unary_operator Exp14 { AbsC.Epreop $1 $2 }
      | 'sizeof' Exp15 { AbsC.Ebytesexpr $2 }
      | 'sizeof' '(' Type_name ')' { AbsC.Ebytestype $3 }
      | Exp16 { $1 }
Exp16 :: { Exp }
Exp16 : Exp16 '[' Exp ']' { AbsC.Earray $1 $3 }
      | Exp16 '(' ')' { AbsC.Efunk $1 }
      | Exp16 '(' ListExp2 ')' { AbsC.Efunkpar $1 $3 }
      | Exp16 '.' Ident { AbsC.Eselect $1 $3 }
      | Exp16 '->' Ident { AbsC.Epoint $1 $3 }
      | Exp16 '++' { AbsC.Epostinc $1 }
      | Exp16 '--' { AbsC.Epostdec $1 }
      | Exp17 { $1 }
Exp17 :: { Exp }
Exp17 : Ident { AbsC.Evar $1 }
      | Constant { AbsC.Econst $1 }
      | String { AbsC.Estring $1 }
      | '(' Exp ')' { $2 }
Constant :: { Constant }
Constant : Double { AbsC.Efloat $1 }
         | Char { AbsC.Echar $1 }
         | Unsigned { AbsC.Eunsigned $1 }
         | Long { AbsC.Elong $1 }
         | UnsignedLong { AbsC.Eunsignlong $1 }
         | Hexadecimal { AbsC.Ehexadec $1 }
         | HexUnsigned { AbsC.Ehexaunsign $1 }
         | HexLong { AbsC.Ehexalong $1 }
         | HexUnsLong { AbsC.Ehexaunslong $1 }
         | Octal { AbsC.Eoctal $1 }
         | OctalUnsigned { AbsC.Eoctalunsign $1 }
         | OctalLong { AbsC.Eoctallong $1 }
         | OctalUnsLong { AbsC.Eoctalunslong $1 }
         | CDouble { AbsC.Ecdouble $1 }
         | CFloat { AbsC.Ecfloat $1 }
         | CLongDouble { AbsC.Eclongdouble $1 }
         | Integer { AbsC.Eint $1 }
Constant_expression :: { Constant_expression }
Constant_expression : Exp3 { AbsC.Especial $1 }
Unary_operator :: { Unary_operator }
Unary_operator : '&' { AbsC.Address }
               | '*' { AbsC.Indirection }
               | '+' { AbsC.Plus }
               | '-' { AbsC.Negative }
               | '~' { AbsC.Complement }
               | '!' { AbsC.Logicalneg }
ListExp2 :: { [Exp] }
ListExp2 : Exp2 { (:[]) $1 } | Exp2 ',' ListExp2 { (:) $1 $3 }
Assignment_op :: { Assignment_op }
Assignment_op : '=' { AbsC.Assign }
              | '*=' { AbsC.AssignMul }
              | '/=' { AbsC.AssignDiv }
              | '%=' { AbsC.AssignMod }
              | '+=' { AbsC.AssignAdd }
              | '-=' { AbsC.AssignSub }
              | '<<=' { AbsC.AssignLeft }
              | '>>=' { AbsC.AssignRight }
              | '&=' { AbsC.AssignAnd }
              | '^=' { AbsC.AssignXor }
              | '|=' { AbsC.AssignOr }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
}

