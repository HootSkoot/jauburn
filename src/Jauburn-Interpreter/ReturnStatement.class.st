Class {
	#name : #ReturnStatement,
	#superclass : #Error,
	#instVars : [
		'returnValue'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #accessing }
ReturnStatement >> returnValue [
	^ returnValue
]

{ #category : #accessing }
ReturnStatement >> returnValue: anObject [
	returnValue := anObject
]
