Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> testAbs [
self interpret: 'var y = abs (42);'.
self assert: (interpreter environment at: 'y')  equals: 42.
self interpret: 'var y = abs (-42);'.
self assert: (interpreter environment at: 'y')  equals: 42.
]

{ #category : #tests }
JbInterpreterTest >> testClosures [
self interpret: '
var x = 5;
var z = 3;
var f = function () {z = x;};
var g = function (y) { 
	var x = 42;
	y();
	};
g(f);
'.
self assert: (interpreter environment at: 'z') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testConcat [
self interpret: 'var y = concat ("hgkl", "ghigh");'.
self assert: (interpreter environment at: 'y')  equals: 'hgklghigh'.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var y = 4 > 2;'.
	self assert: (interpreter environment at: 'y') equals: true.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCall [

self interpret: 'var x = 5;var f = function () {x = 99;};f();'.
self assert: (interpreter environment at: 'x') equals: 99.
self interpret: 'var x = 5;var f = function (z) {x = z;};f(-3);'.
self assert: (interpreter environment at: 'x') equals: -3.
self deny: (interpreter environment includesKey: 'z').
]

{ #category : #tests }
JbInterpreterTest >> testFunctionDeclaration [
	| f |
	self interpret: 'var f = function (x) {x = 99;return x;};'.
	f := interpreter environment at: 'f'.
	self assert: f body size equals: 2.
	self assert: f environment equals: interpreter environment.
	self assert: f parameters size equals: 1.
	self assert: f parameters first equals: 'x'.
	self interpret: 'var f = function (high,mid,low) {x = 99;y = 2;return x;};'.
	f := interpreter environment at: 'f'.
	self assert: f body size equals: 3.
	self assert: f environment equals: interpreter environment.
	self assert: f parameters size equals: 3.
	self assert: f parameters first equals: 'high'.
	self assert: f parameters second equals: 'mid'.
	self assert: f parameters third equals: 'low'.
	
]

{ #category : #tests }
JbInterpreterTest >> testFunctionReturn [

self interpret: 'var x = 5;var f = function () {return x;};var t = f();'.
self assert: (interpreter environment at: 't') equals: 5.

]

{ #category : #tests }
JbInterpreterTest >> testGCD [
self interpret: 'var gcd = function (x,y) {if (x==0) {return y;} else {return gcd(mod (y,x),x);}};var h = gcd(35,10);var b = gcd(31,2);'.
"self interpret: 'var gcd = function (x,y) {if (x==0) {return y} else {return gcd (mod (y,x),x)};};'."
"self interpret: 'var y = gcd (10,15);'."
self assert: (interpreter environment at: 'h') equals: 5.
self assert: (interpreter environment at: 'b') equals: 1.

]

{ #category : #tests }
JbInterpreterTest >> testInput [ 
|ui|
ui := MockUIManager new.
interpreter uimanager: ui.
self interpret: 'input ("enter a number");'.
self assert: ui contents equals: '42'
]

{ #category : #tests }
JbInterpreterTest >> testLength [
self interpret: 'var y = length ("hgklghigh");'.
self assert: (interpreter environment at: 'y')  equals: 9.

]

{ #category : #tests }
JbInterpreterTest >> testMod [
self interpret: 'var y = mod (12,10);'.
self assert: (interpreter environment at: 'y')  equals: 2.
self interpret: 'var y = mod (10,10);'.
self assert: (interpreter environment at: 'y')  equals: 0.
]

{ #category : #tests }
JbInterpreterTest >> testNot [
self interpret: 'var y = not (true);'.
self assert: (interpreter environment at: 'y')  equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testStringToNumber [
|ui|
ui := MockUIManager new.
interpreter uimanager: ui.
self interpret: 'var y = stringToNumber ("123456789");'.
self assert: (interpreter environment at: 'y')  equals: 123456789.
"enter 4 for the test to pass, "
self interpret: 'var target = stringToNumber(input ("Enter a number to find its root"));'.
self assert: (interpreter environment at: 'target') equals: 42.

]

{ #category : #tests }
JbInterpreterTest >> testTranscript [
|script|
script := MockTranscript new.
interpreter transcript: script.
self interpret: 'print (10);'.
self assert: script contents equals: '10'.
]

{ #category : #tests }
JbInterpreterTest >> testWhileProgram [
self interpret: 'var x= 0;var y = 0;while (x<=10) {y=y+x;x=x+1;}'.
self assert: (interpreter environment at: 'y') equals: 55.
]
