Class {
	#name : #JbWhileLoopNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'statements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileLoopNode >> condition [
	^ condition
]

{ #category : #accessing }
JbWhileLoopNode >> condition: anObject [
	condition := anObject
]

{ #category : #'as yet unclassified' }
JbWhileLoopNode >> executeIn: environment [ 
" ((environment at: identifier ) call: (self arguments do: [ :each | each evaluateIn: environment]) in: environment)"

"(environment at: identifier ) call: (self arguments collect: [ :each | each evaluateIn: environment  ]) in: environment."
^[ condition evaluateIn: environment  ] whileTrue: [statements do: [ :each | each executeIn: environment ]].
]

{ #category : #accessing }
JbWhileLoopNode >> statements [
	^ statements
]

{ #category : #accessing }
JbWhileLoopNode >> statements: anObject [
	statements := anObject
]
