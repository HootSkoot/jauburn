Class {
	#name : #JbFunctionCallNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'arguments'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbFunctionCallNode >> arguments [
	^ arguments
]

{ #category : #accessing }
JbFunctionCallNode >> arguments: anObject [
	arguments := anObject
]

{ #category : #'as yet unclassified' }
JbFunctionCallNode >> evaluateIn: environment [ 
 ^ self executeIn: environment 
]

{ #category : #'as yet unclassified' }
JbFunctionCallNode >> executeIn: environment [ 
" ((environment at: identifier ) call: (self arguments do: [ :each | each evaluateIn: environment]) in: environment)"

^(environment at: identifier ) call: (self arguments collect: [ :each | each evaluateIn: environment  ]) in: environment.
]

{ #category : #accessing }
JbFunctionCallNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbFunctionCallNode >> identifier: anObject [
	identifier := anObject
]
