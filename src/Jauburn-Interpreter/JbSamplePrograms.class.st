"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'as yet unclassified' }
JbSamplePrograms class >> gcd [
|parser interpreter ast target|
parser := JbParser new.
interpreter := JbInterpreter new.
ast := parser parse: 'var a = stringToNumber(input ("Enter first number."));var b = stringToNumber(input ("Enter second number."));var gcd = function (x,y) {if (x==0) {return y;} else {return gcd(mod (y,x),x);}};var t = gcd(a,b);println (t);'.
target := interpreter interpret: ast.
]

{ #category : #'as yet unclassified' }
JbSamplePrograms class >> newtonSquareRoot [
|parser interpreter ast target|
parser := JbParser new.
interpreter := JbInterpreter new.
ast := parser parse: 'var target = stringToNumber(input ("Enter a number to find its root"));var root = target;var count = root+10;var oldRoot = 1;while (oldRoot!=0) {count = root;root = (root + (target/root))/2;println (root);oldRoot = count - root;}'.
target := interpreter interpret: ast.
]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]
