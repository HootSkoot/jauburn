Class {
	#name : #JbReturnStatementNode,
	#superclass : #Object,
	#instVars : [
		'expression'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #'as yet unclassified' }
JbReturnStatementNode >> evaluateIn: environment [ 
"^ self expression"
|temp|
temp := ReturnStatement new.
temp returnValue: (expression evaluateIn: environment).
temp signal.
]

{ #category : #'as yet unclassified' }
JbReturnStatementNode >> executeIn: aEnvironment [ 
self evaluateIn: aEnvironment 
]

{ #category : #accessing }
JbReturnStatementNode >> expression [
	^ expression
]

{ #category : #accessing }
JbReturnStatementNode >> expression: anObject [
	expression := anObject
]
