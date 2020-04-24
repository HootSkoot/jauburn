Class {
	#name : #JbIfElseNode,
	#superclass : #JbIfNode,
	#instVars : [
		'falseStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #'as yet unclassified' }
JbIfElseNode >> executeIn: environment [ 
" ((environment at: identifier ) call: (self arguments do: [ :each | each evaluateIn: environment]) in: environment)"

"(environment at: identifier ) call: (self arguments collect: [ :each | each evaluateIn: environment  ]) in: environment."
^( condition evaluateIn: environment  ) ifTrue: [trueStatements do: [ :each | each executeIn: environment ]] ifFalse: [falseStatements do: [ :each | each executeIn: environment ]].
]

{ #category : #accessing }
JbIfElseNode >> falseStatements [
	^ falseStatements
]

{ #category : #accessing }
JbIfElseNode >> falseStatements: anObject [
	falseStatements := anObject
]
