Class {
	#name : #JbIfNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfNode >> condition [
	^ condition
]

{ #category : #accessing }
JbIfNode >> condition: anObject [
	condition := anObject
]

{ #category : #'as yet unclassified' }
JbIfNode >> executeIn: environment [ 
" ((environment at: identifier ) call: (self arguments do: [ :each | each evaluateIn: environment]) in: environment)"

"(environment at: identifier ) call: (self arguments collect: [ :each | each evaluateIn: environment  ]) in: environment."
^( condition evaluateIn: environment  ) ifTrue: [trueStatements do: [ :each | each executeIn: environment ]].
]

{ #category : #accessing }
JbIfNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbIfNode >> trueStatements: anObject [
	trueStatements := anObject
]
