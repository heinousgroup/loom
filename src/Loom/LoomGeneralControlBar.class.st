Class {
	#name : #LoomGeneralControlBar,
	#superclass : #ComposableModel,
	#instVars : [
		'buttonNewBlankObject',
		'buttonTest2'
	],
	#category : #Loom
}

{ #category : #specs }
LoomGeneralControlBar class >> defaultSpec [
	^ SpecLayout composed
		newRow:
			[ :row | 
			row
				add: #buttonNewBlankObject;

				add: #buttonTest2
] yourself
]

{ #category : #accessing }
LoomGeneralControlBar >> buttonNewBlankObject [
	^ buttonNewBlankObject
]

{ #category : #accessing }
LoomGeneralControlBar >> buttonTest2 [
	^ buttonTest2
]

{ #category : #'as yet unclassified' }
LoomGeneralControlBar >> createBlankObject [
	"Creates a blank LoomObject"

	CommandBar clearAllTargets.
	LoomObject new openInCurrentProject
]

{ #category : #initialization }
LoomGeneralControlBar >> initialize [
	super initialize
]

{ #category : #initialization }
LoomGeneralControlBar >> initializePresenter [
	buttonNewBlankObject action: [ self createBlankObject ].
	buttonTest2 action: [ self notify: CommandBar commandTargets asString  ]
]

{ #category : #initialization }
LoomGeneralControlBar >> initializeWidgets [
	"widget instantiation"

	buttonNewBlankObject := self newButton.

	buttonTest2 := self newButton.


	"widget configuration"
	buttonNewBlankObject label: 'Spawn New Object'.

	buttonTest2 label: 'Test 2'.


	"tab order configuration"
	self focusOrder
		add: buttonNewBlankObject;

		add: buttonTest2
]

{ #category : #'error handling' }
LoomGeneralControlBar >> notify: aString [
	"Prints the passed string in the Transcript window"

	Transcript
		cr;
		show: self class asString , ': ' , aString
]
