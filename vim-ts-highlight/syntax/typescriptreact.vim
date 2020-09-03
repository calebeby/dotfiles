" runtime! syntax/typescript.vim
"
" quit when a syntax file was already loaded
if !exists('main_syntax')
  if exists('b:current_syntax')
    finish
  endif
  let main_syntax = 'typescriptreact'
endif

let s:cpo_save = &cpo
set cpo&vim

syn sync fromstart

syntax iskeyword @,48-57,_,192-255,$

syn keyword tsConditional if else switch
hi def link tsConditional Conditional

syn keyword tsReturn return skipwhite nextgroup=@tsExpression
hi def link tsReturn Statement

syn keyword tsBoolean true false skipwhite skipempty nextgroup=tsBinaryOperator
hi def link tsBoolean Boolean

syn keyword tsUndefined undefined skipwhite skipempty nextgroup=tsBinaryOperator
hi def link tsUndefined Constant

syn keyword tsNull null skipwhite skipempty nextgroup=tsBinaryOperator
hi def link tsNull Constant

syn keyword tsNumber Infinity skipwhite skipempty nextgroup=tsBinaryOperator
syn keyword tsNumber NaN skipwhite skipempty nextgroup=tsBinaryOperator
syn match tsNumber "\<[0-9.]\+\>" skipwhite skipempty nextgroup=tsBinaryOperator
hi def link tsNumber Number

syn keyword tsThrow throw skipwhite skipempty nextgroup=@tsExpression
hi def link tsThrow Keyword

syn keyword tsTry try skipwhite skipempty nextgroup=tsCatchBlock
hi def link tsTry Keyword

syn region tsCatchBlock start="{" end="}" contained contains=@tsStatement fold skipwhite skipempty nextgroup=tsCatch

syn keyword tsCatch catch contained skipwhite skipempty nextgroup=tsArgsList
hi def link tsCatch Keyword

syn keyword tsNew new skipwhite skipempty nextgroup=@tsExpression
hi def link tsNew Keyword

syn keyword tsVarDeclaration var let skipwhite skipempty nextgroup=tsVarDeclarationId
hi def link tsVarDeclaration StorageClass

" This is needed to disambiguate ternaries else conditions from type
" annotations within CPEAAPL's
" const s = (foo ? bar : baz)
"                ~~~~~~~
syn region tsTernaryTruthy matchgroup=tsTernary start="?" end=":" contains=@tsExpression skipwhite skipempty nextgroup=@tsExpression
hi def link tsTernary Operator

" Used so that ternary does not trigger on optional chain
syn match tsOptionalChain "?\."

" This is needed so that identifiers on following lines get matched:
" const foo = asdf *
"   asdf2
" Regex makes sure that the operator match is the entirety of the operator,
" so things like !=== are not matched
syn match tsBinaryOperator "\_[^+\-*/%=|?&!<>]\@<=\(+\|-\|*\|/\|%\|===\|==\|!==\|!=\|||\|??\|&&\|<\|>\|>=\|<=\||\|&\)\ze\_[^+\-*/%=|?&!<>]" skipwhite skipempty contained nextgroup=@tsExpression
hi def link tsBinaryOperator Operator


syn region tsRegexp start="/" end="/" skip="\\/"
hi def link tsRegexp String

" const foo=bar
" or
" const enum
syn keyword tsVarDeclaration const skipwhite skipempty nextgroup=tsEnum,tsVarDeclarationId
hi def link tsVarDeclaration StorageClass

syn region tsVarDeclarationId contained start="\S" end="=" contains=tsIdentifier,tsDestructuringArray,tsDestructuringObject,tsTypeAnnotation,tsComment skipwhite skipempty nextgroup=@tsExpression

syn match tsAssignment "\<\K\k*\>\s*=\>" skipwhite skipempty contains=tsIdentifier nextgroup=@tsExpression
syn match tsAssignment "\<>=\>" skipwhite skipempty nextgroup=@tsExpression

syn region tsArrayLiteral matchgroup=tsArrayBrackets start=/\[/ end=/\]/ contains=@tsExpression

syn region tsComment start=+//+ end=/$/ extend keepend contains=tsTODO
syn region tsComment start=+/\*+ end=+\*/+ fold contains=tsTODO,tsJSDoc
hi def link tsComment Comment

syn match tsJSDoc '@type\>' skipwhite skipempty nextgroup=tsJSDocTypeCastType
syn match tsJSDoc '@typedef\>' skipwhite skipempty nextgroup=tsJSDocTypedefType

" @param { Foo } asdf
" ~~~~~~
syn match tsJSDoc '@param\>' skipwhite skipempty nextgroup=tsJSDocParamType,tsIdentifier
syn match tsJSDoc '@property\>' skipwhite skipempty nextgroup=tsJSDocPropertyType,tsIdentifier
syn match tsJSDoc '@returns\>' skipwhite skipempty nextgroup=tsJSDocReturnType
syn match tsJSDoc '@template\>' skipwhite skipempty nextgroup=tsTypeName
syn match tsJSDoc '@todo\>' skipwhite skipempty contains=tsJSDocTodo
syn match tsJSDoc '@see\>' skipwhite skipempty
syn match tsJSDoc '@this\>' skipwhite skipempty nextgroup=tsJSDocThisType
hi def link tsJSDoc SpecialComment

syn keyword tsJSDocTodo contained todo
hi def link tsJSDocTodo TODO

" "any" type that is not allowed in normal TS types, just in jsdoc
syn match tsJSDocStar "*"  contained
hi def link tsJSDocStar tsTypeName


" @param { Foo } asdf
"        ~~~~~~~
syn region tsJSDocParamType contained matchgroup=tsComment start="{" end="}" contains=@tsJSDocType skipwhite skipempty nextgroup=tsJSDocParamName
syn region tsJSDocReturnType contained matchgroup=tsComment start="{" end="}" contains=@tsJSDocType skipwhite skipempty
syn region tsJSDocPropertyType contained matchgroup=tsComment start="{" end="}" contains=@tsJSDocType skipwhite skipempty nextgroup=tsJSDocPropertyName
syn region tsJSDocTypeCastType contained matchgroup=tsComment start="{" end="}" contains=@tsJSDocType skipwhite skipempty
syn region tsJSDocTypedefType contained matchgroup=tsComment start="{" end="}" contains=@tsJSDocType skipwhite skipempty nextgroup=tsTypeName
syn region tsJSDocThisType contained matchgroup=tsComment start="{" end="}" contains=@tsJSDocType skipwhite skipempty
syn cluster tsJSDocType contains=@tsType,tsJSDocStar

syn match tsJSDocPropertyName contained "\<\K\k*\>"
syn match tsJSDocParamName contained "\<\K[a-zA-Z0-9._]*\>" contains=tsIdentifier

syn keyword tsTODO contained TODO FIXME XXX NOTE
hi def link tsTODO TODO

syn keyword tsImportExport import export
hi def link tsImportExport Keyword

" TODO: From and As should be contained
syn keyword tsFromKeyword from
hi def link tsFromKeyword Keyword

" TODO: differentiate from type as
" syn keyword tsAsKeyword as
" hi def link tsAsKeyword Keyword

syn region tsString start=+\z(["']\)+ skip=+\\\%(\z1\|$\)+ end=+\z1+ end=+$+ contains=tsSpecial extend skipwhite skipempty nextgroup=tsBinaryOperator
hi def link tsString String
syn region tsTemplateString start=+`+ skip=+\\`+ end=+`+ contains=tsTemplateExpression,tsSpecial extend skipwhite skipempty nextgroup=tsBinaryOperator
hi def link tsTemplateString tsString

syn region tsTemplateExpression contained matchgroup=tsTemplateBraces start=+${+ end=+}+ contains=@tsExpression keepend

syn match tsSpecial contained "\v\\%(x\x\x|u%(\x{4}|\{\x{1,6}})|c\u|.)"
hi def link tsSpecial Special

" Lookbehind to not match the second part of foo.bar
syn match tsIdentifier "\(\.\_s*\)\@<!\<\K\k*\>"
" Lookbehind to match ...foo
syn match tsIdentifier "\(\.\.\.\s*\)\@<=\<\K\k*\>"
hi def link tsIdentifier Identifier

syn keyword tsAsyncKeyword async skipwhite skipempty nextgroup=tsArrowParens
hi def link tsAsyncKeyword Keyword

syn keyword tsAwaitKeyword await
hi def link tsAwaitKeyword Keyword

syn match tsFunctionExpressionName contained "\<\K\k*\>" skipwhite skipempty nextgroup=tsArgsList
hi def link tsFuncName Function
hi def link tsFunctionExpressionName tsFuncName

syntax match tsParensError /[)}\]]/
hi link tsParensError Error

syn keyword tsFunctionKeyword function skipwhite skipempty nextgroup=tsFunctionExpressionName,tsArgsList
hi def link tsFunctionKeyword Keyword

syn region tsDestructuringArray contained matchgroup=tsArrayBrackets start="\[" end="\]" contains=tsComment,tsDestructuringArrayElement
syn region tsDestructuringArrayElement contained start=/./ end=/\ze[,\]]/ contains=tsComment,tsRest,tsDefaultValue,tsIdentifier

syn region tsDestructuringObject contained matchgroup=tsObjectBraces start="{" end="}" contains=tsComment,tsDestructuringObjectElement

syn region tsDestructuringObjectElement contained start="." end="," end="\ze}" contains=tsDestructuringObjectComputedKey,tsDestructuringObjectStringKey,tsDestructuringObjectKey,tsDefaultValue,tsIdentifier,tsComment
syn region tsDestructuringObjectComputedKey contained matchgroup=tsObjectKeyBrackets start="\[" end="]" contains=@tsExpression skipwhite skipempty nextgroup=tsDestructuringArray,tsDestructuringObject,tsIdentifier
syn match tsDestructuringObjectKey "\<\K\k*\>\s*\ze:" skipwhite skipempty nextgroup=tsDestructuringArray,tsDestructuringObject,tsIdentifier
syn region tsDestructuringObjectStringKey contained start=+\z(["']\)+ skip=+\\\%(\z1\|$\)+ end=+\z1\ze\s*:\|$+ contains=tsSpecial skipwhite skipempty nextgroup=tsDestructuringArray,tsDestructuringObject,tsIdentifier
hi def link tsDestructuringObjectStringKey tsString

syn region tsDefaultValue contained start="=" end="\ze[\])},]" contains=@tsExpression
syn region tsRest contained start="\.\.\." end="\ze[\]),]" contains=@tsExpression

" foo()
syn match tsFuncCallName /\<\K\k*\ze\_s*(/ skipwhite skipempty nextgroup=tsCPEAAPL
hi def link tsFuncCallName tsFuncName
" foo<asdf>()
" TODO: something better for generic?
syn match tsFuncCallName /\<\K\k*\s*\ze<\_.\{-}>\_s*(/ skipwhite skipempty nextgroup=tsGeneric,tsCPEAAPL
hi def link tsFuncCallName tsFuncName

syn region tsObject contained matchgroup=tsObjectBraces start=/{/ end=/}/ contains=tsObjectKey,tsObjectKeyComputed,tsObjectStringKey,tsObjectMethod,tsObjectShorthandProp,tsComment
syntax match tsObjectShorthandProp contained /\<\k*\ze\s*/ skipwhite skipempty
hi def link tsObjectShorthandProp tsIdentifier
syn region tsObjectValue contained matchgroup=tsObjectColon start=/:/ end=/[,}]\@=/ contains=@tsExpression extend
syn match tsObjectKey contained "\<\K\k*\>\s*\ze:" skipwhite skipempty nextgroup=tsObjectValue
syn region tsObjectKeyComputed contained matchgroup=tsObjectKeyBrackets start="\[" end="]" contains=@tsExpression skipwhite skipempty nextgroup=tsObjectValue,tsArgsList
syn region tsObjectStringKey contained start=+\z(["']\)+ skip=+\\\%(\z1\|$\)+ end=+\z1\|$+ contains=tsSpecial extend skipwhite skipempty nextgroup=tsObjectValue,tsArgsList
hi def link tsObjectStringKey tsString
syn match tsObjectMethod contained /\<\K\k*\ze\_s*(/ skipwhite skipempty nextgroup=tsArgsList
hi def link tsObjectMethod tsFuncName

" Everything that can be in a list of arguments
syn cluster tsArgs contains=tsTypeAnnotation,tsComment,tsDestructuringArray,tsDestructuringObject,tsRest,tsDefaultValue,tsIdentifier

" This shold be the same as tsArrowParens. The difference should only be the
" nextgroup. This one is used in regular functions and in catch clauses, and tsArrowParens is for
" arrow functions only
syn region tsArgsList contained start="(" end=")" contains=@tsArgs extend fold skipwhite skipempty nextgroup=tsBlock

" This is only used when we _know_ it is a arrow function parens
" For example if the async keyword is before it
" or type generics is before it
syn region tsArrowParens contained matchgroup=tsParen start="(" end=")" contains=@tsArgs skipwhite skipempty nextgroup=tsArrow

" Either a parenethesized expression
" or the parameters for an arrow function
" We don't know which since we can't really lookahead to determine if it has =>
" Also it could be a function call parameters cuz im lazy: foo(...)
" (a, b, c())
" ~~~~~~~~~~~
" s(a, b, c)
"  ~~~~~~~~~
" (a, b, c) =>
" ~~~~~~~~~
syn region tsCPEAAPL matchgroup=tsParen start="(" end=")" contains=@tsArgs,@tsExpression skipwhite skipempty nextgroup=tsArrow,tsArrowReturnTypeAnnotation,tsBinaryOperator
" () =>
syn match tsArrowFunc "()\ze\s*=>" skipwhite skipempty nextgroup=tsArrow
" foo =>
syn match tsArrowFunc "\<\K\k*\>\ze\s*=>" contains=tsIdentifier skipwhite skipempty nextgroup=tsArrow

" Farther down is higher precedence, so if the arrow has a { after it make it a block,
" otherwise parse the expression
syn match tsArrow extend contained "=>" skipwhite skipempty nextgroup=@tsExpression
syn match tsArrow extend contained "=>\ze\_s*{" skipwhite skipempty nextgroup=tsBlock
hi def link tsArrow Keyword

syn region tsBlock start="{" end="}" contains=@tsStatement extend fold skipwhite skipempty nextgroup=tsBinaryOperator

" TS Specific below here

syn keyword tsInterfaceKeyword interface nextgroup=tsTypeInterfaceDeclaration
hi def link tsInterfaceKeyword Keyword

syn region tsTypeInterfaceDeclaration contained start="." end="\ze{" contains=tsTypeAliasSignature,tsTypeExtendsKeyword nextgroup=tsInterfaceBody

syn keyword tsTypeKeyword type skipwhite skipempty nextgroup=tsTypeAliasName
hi def link tsTypeKeyword StorageClass

syn region tsTypeAliasName start="\S" end="\ze=" contained skipwhite skipempty nextgroup=tsTypeAliasEq contains=tsTypeAliasSignature
syn match tsTypeAliasEq "=" contained skipwhite skipempty nextgroup=@tsType

" type Foo<bar extends baz> = ...
"      ~~~~~~~~~~~~~~~~~~~~
" interface Foo<bar = asdf> {}
"           ~~~~~~~~~~~~~~~
syn region tsTypeAliasSignature start="\S" end="." contained contains=tsTypeSignatureName

" type Foo<bar extends baz> = ...
"      ~~~
syn match tsTypeSignatureName "\<\K\k*\>" contained skipwhite skipempty nextgroup=tsTypeParameterDeclaration
hi def link tsTypeSignatureName tsTypeName

" type Foo<bar extends baz> = ...
"         ~~~~~~~~~~~~~~~~~
" const Foo = <T extends {}>(params) => {}
"             ~~~~~~~~~~~~~~
syn region tsTypeParameterDeclaration contained start="<" end=">" contains=tsTypeExtendsKeyword,@tsType

syn keyword tsTypeExtendsKeyword contained extends
hi def link tsTypeExtendsKeyword Operator

syn region tsGeneric contained start="<" end=">" contains=@tsType skipwhite skipempty nextgroup=tsTypeDot,tsTypePropertyBrackets,tsGeneric,tsTypeOperator

syn match tsTypeName contained "\<\K\k*\>" skipwhite skipempty nextgroup=tsTypeDot,tsTypePropertyBrackets,tsGeneric,tsTypeOperator
hi def link tsTypeName Type

syn keyword tsTypePrimitive contained undefined null number string boolean skipwhite skipempty nextgroup=tsTypeOperator
hi def link tsTypePrimitive Type

syn match tsTypeOperator "|\|&" contained skipwhite skipempty nextgroup=@tsType
hi def link tsTypeOperator tsBinaryOperator

syn keyword tsTypeNumber Infinity contained skipwhite skipempty nextgroup=tsTypeOperator
syn keyword tsTypeNumber NaN contained skipwhite skipempty nextgroup=tsTypeOperator
syn match tsTypeNumber "\<[0-9.]\+\>" contained skipwhite skipempty nextgroup=tsTypeOperator
hi def link tsTypeNumber tsNumber

" TS backtick strings as types do not support embedded expressions
syn region tsTypeString contained start=+\z(["']\)+ skip=+\\\%(\z1\|$\)+ end=+\z1+ end=+$+ contains=tsSpecial extend skipwhite skipempty nextgroup=tsTypeOperator
syn region tsTypeString contained start=+`+ skip=+\\`+ end=+`+ contains=tsSpecial extend skipwhite skipempty nextgroup=tsTypeOperator
hi def link tsTypeString tsString

syn region tsTypeDynamicImport start="import\ze\s*(" end=")\@<=" contains=tsTypeDynamicImportParens contained skipwhite skipempty nextgroup=tsTypeOperator
hi def link tsTypeDynamicImport tsFuncCallName
syn region tsTypeDynamicImportParens start="(" end=")" contained contains=tsTypeString

" Specialized Comments - Used to maintain/forward nextgroup
syn region tsTypeComment contained start=+//+ end=/$/ extend keepend contains=tsTODO nextgroup=@tsType
syn region tsTypeComment contained start=+/\*+ end=+\*/+ fold contains=tsTODO,tsJSDoc nextgroup=@tsType
hi def link tsTypeComment Comment

" The only difference between tsTypeObject and tsInterfaceBody is the nextgroup
syn region tsInterfaceBody contained start="{" end="}" contains=tsComment,tsTypeKey,tsTypeKeyComputed,tsTypeKeyString
syn region tsTypeObject contained start="{" end="}" contains=tsComment,tsTypeKey,tsTypeKeyComputed,tsTypeKeyString

syn region tsTypeObjectValue contained matchgroup=tsObjectColon start="?:" start=":" end="." nextgroup=@tsType extend
syn match tsTypeKey contained "\<\K\k*\>\s*\ze?\?:" skipwhite skipempty nextgroup=tsTypeObjectValue
syn region tsTypeKeyComputed contained matchgroup=tsObjectKeyBrackets start="\[" end="]" contains=tsIdentifier skipwhite skipempty nextgroup=tsTypeObjectValue
syn region tsTypeKeyString contained start=+\z(["']\)+ skip=+\\\%(\z1\|$\)+ end=+\z1\|$+ contains=tsSpecial extend skipwhite skipempty nextgroup=tsTypeObjectValue
hi def link tsTypeKeyString tsString

" (): number => {}
"   ~~~~~~~~
syn region tsArrowReturnTypeAnnotation start=":" end="\ze\s*=>" contains=@tsType skipwhite skipempty nextgroup=tsArrow

" This is either parens that are part of a parameter list for an arrow
" function type
" or it is parens used for grouping other types
syn region tsTypeParens contained matchgroup=tsParen start="(" end=")" contains=tsTypeAnnotation skipwhite skipempty nextgroup=tsTypeArrow

syn match tsTypeArrow "=>" contained skipwhite skipempty nextgroup=@tsType
hi def link tsTypeArrow Keyword

" foo: Number
"    ~~~~~~~~
syn region tsTypeAnnotation contained start=":" end="\ze." skipwhite skipempty nextgroup=@tsType

syn region tsTypePropertyBrackets contained start="\[" end="]" contains=tsTypeString skipwhite skipempty nextgroup=tsTypeDot,tsTypePropertyBrackets,tsGeneric,tsTypeOperator
syn match tsTypeDot "\." contained skipwhite skipempty nextgroup=tsTypeName

syn keyword tsEnum enum skipwhite skipempty nextgroup=tsEnumName
hi def link tsEnum Keyword

syn match tsEnumName contained "\<\K\k*\>" skipwhite skipempty nextgroup=tsEnumBody
hi def link tsEnumName Type

syn region tsEnumBody contained start="{" end="}" contains=tsComment,tsEnumInitializer

syn match tsEnumInitializer contained "=" skipwhite skipempty nextgroup=@tsExpression

syn keyword tsAsKeyword as contained skipwhite skipempty nextgroup=@tsType

syn cluster tsType contains=tsTypeName,tsTypePrimitive,tsTypeNumber,tsTypeString,tsTypeComment,tsTypeObject,tsTypeParens,tsTypeDynamicImport

" /end 

" JSX Stuff
" This is mostly from https://github.com/peitalin/vim-jsx-typescript/blob/master/after/syntax/tsx.vim

syn region tsxRegion
      \ start=+<\z([^ /!?<>"'=:]\+\)+
      \ start=+<\z(\s\{0}\)>+
      \ end=+</\z1\_s\{-}>+
      \ end=+/>+
      \ fold
      \ contains=tsxRegion,tsxTag,tsxCloseTag,tsxEmbeddedExpression
      \ keepend
      \ extend

" <tag>{content}</tag>
"      s~~~~~~~e
" or
" <tag key={asdf}></tag>
"          s~~~~e
syn region tsxEmbeddedExpression
    \ matchgroup=tsxBraces
    \ start="{"
    \ end="}"
    \ contained
    \ contains=@tsExpression

" <tag id="sample">
" s~~~~~~~~~~~~~~~e
syn region tsxTag
    \ matchgroup=tsxTag
    \ start=+<[^ }/!?<"'=:]\@=+
    \ end=+\/\?>+
    \ contained
    \ contains=tsxTagName,tsxAttrib,tsxEqual,tsComment,tsxEmbeddedExpression
hi def link tsxTag xmlTag

" <tag key={this.props.key}>
"      ~~~
syn match tsxAttrib
    \ +[-'"<]\@<!\<[a-zA-Z:_][-.0-9a-zA-Z0-9:_]*[/]\{0,1}\>\(['"]\@!\|$\)+
    \ contained
    \ keepend
hi def link tsxAttrib xmlAttrib

" <tag key={this.props.key}>
"  ~~~
syn match tsxTagName
    \ +[<]\@<=[^ /!?<>"']\++
    \ contained
    \ display
    \ skipwhite
    \ skipempty
    \ nextgroup=tsGeneric
hi def link tsxTagName xmlTagName

" <tag id="sample">
"        ~
syntax match tsxEqual "=" contained skipwhite skipempty nextgroup=tsxEmbeddedExpression,tsString
hi def link tsxEqual xmlEqual

" </tag>
"   ~~~
syn match tsxCloseTagName
    \ +[</]\@<=[^ /!?<>"']\++
    \ containedin=tsxCloseTag
    \ display

" </tag>
" ~~~~~~
syntax region tsxCloseTag
      \ start=+</[^ /!?<"'=:]\@=+
      \ end=+>+

highlight def link tsxCloseTagName xmlTagName

" /end

" This has to be below the tsxRegion definition because it needs higher priority
" const Foo = <T extends {}>(params) => {}
"             ~~~~~~~~~~~~~~~
" const Foo = <T, S>(params) => {}
"             ~~~~~~~
syn match tsArrowFunctionGenericDeclaration "<\s*\K\k*.\{-}\(,\|extends\).\{-}>\ze\s*(" contains=tsTypeParameterDeclaration skipwhite skipempty nextgroup=tsArrowParens

" This has everything that is an statement that can also be used as an expression
" You probably shouldn't use this directly
syn cluster tsStatementExpression contains=tsArrowFunc,tsCPEAAPL,tsString,tsTemplateString,tsNumber,tsBoolean,tsComment,tsFunctionKeyword,tsFuncCallName,tsAssignment,tsArrayLiteral,tsUndefined,tsNull,tsArrowFunctionGenericDeclaration,tsAsyncKeyword,tsAwaitKeyword,tsxRegion,tsTernaryTruthy,tsOptionalChain,tsNew,tsIdentifier,tsRegexp
syn cluster tsExpression contains=@tsStatementExpression,tsObject,tsAsKeyword
syn cluster tsStatement contains=tsConditional,tsReturn,tsThrow,tsVarDeclaration,tsBlock,tsTry,@tsStatementExpression

let b:current_syntax = 'typescriptreact'
if main_syntax == 'typescriptreact'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save
