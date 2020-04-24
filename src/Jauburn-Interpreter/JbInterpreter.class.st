"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'transcript',
		'uimanager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #'as yet unclassified' }
JbInterpreter >> absBinding [
^ #abs -> [ :s1 |  s1 abs ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> concatBinding [
^ #concat -> [ :s1 :s2 |  s1 asString , s2 asString ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #'as yet unclassified' }
JbInterpreter >> gcdBinding [
^ #gcd -> "[ :s1 :s2 |  |block| block := [ :x1 :x2 | ^ x1 ]. block value: s1 value: s2.]"
[ :s1 :s2 | (s1 = 0) ifTrue: [ s2 ] ifFalse: [ thisContext closure value: (s2\\s1) value: s1 ] ]
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	(self class selectors select: [ :func | func endsWith: 'Binding' ])
		do: [ :prim| 
			| temp assoc|
			temp := JbPrimitive new.
			temp block: (self perform: prim) value.
			assoc := self perform: prim.
			environment at: assoc key put: temp ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> inputBinding [
	^ #input
		-> [ :arg1 | self uimanager request: arg1 ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #'as yet unclassified' }
JbInterpreter >> lengthBinding [
^ #length -> [ :s1 |  s1 size ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> modBinding [
^ #mod -> [ :s1 :s2 |  s1 \\ s2 ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> notBinding [
^ #not -> [ :s1 |  s1 not ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
^ #print -> [:value | self transcript show: value printString]
]

{ #category : #primitives }
JbInterpreter >> printLnBinding [
^ #println -> [:value | self transcript show: value printString; cr]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #'as yet unclassified' }
JbInterpreter >> stringToNumberBinding [
^ #stringToNumber -> [ :s1 |  s1 asNumber ]
]

{ #category : #accessing }
JbInterpreter >> transcript [
^ transcript ifNil: [Transcript]
]

{ #category : #accessing }
JbInterpreter >> transcript: arg1 [
	transcript := arg1
]

{ #category : #accessing }
JbInterpreter >> uimanager [
^ uimanager ifNil: [ UIManager default]
]

{ #category : #accessing }
JbInterpreter >> uimanager: arg1 [
	uimanager := arg1
]
