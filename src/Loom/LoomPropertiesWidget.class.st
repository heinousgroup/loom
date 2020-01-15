Class {
	#name : #LoomPropertiesWidget,
	#superclass : #ComposableModel,
	#instVars : [
		'textName',
		'sourceObject'
	],
	#classInstVars : [
		'textName'
	],
	#category : #Loom
}

{ #category : #specs }
LoomPropertiesWidget class >> defaultSpec [

	^ SpecColumnLayout composed
		add: #textName
		yourself
]

{ #category : #accessing }
LoomPropertiesWidget class >> name: aName [
	"comment stating purpose of message"

	textName := aName.
	"Do the changed code here"
]

{ #category : #api }
LoomPropertiesWidget >> extent [
	"Sets the size of the window"

	^ 400 @ 120
]

{ #category : #initialization }
LoomPropertiesWidget >> initializeWidgets [
	"widget instantiation"

	textName := self newLabel.
	
	"widget configuration"
	textName label: '[name]'
	
]

{ #category : #api }
LoomPropertiesWidget >> source: aLoomObject [
	"Sets the loomObject instance variable on the LoomPropertiesWidget instance to the object that it is passed (should work for both blank and templated objects"

	sourceObject := aLoomObject.
]

{ #category : #accessing }
LoomPropertiesWidget >> textName [
	"Accessor so defaultSpec can access this private instance variable"

	^ textName.
]

{ #category : #api }
LoomPropertiesWidget >> title [
	"Sets window title"

	^ 'Properties'.
]
