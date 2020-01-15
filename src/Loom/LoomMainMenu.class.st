Class {
	#name : #LoomMainMenu,
	#superclass : #ComposableModel,
	#instVars : [
		'generalControlBar',
		'commandBar',
		'projectBar'
	],
	#category : #Loom
}

{ #category : #specs }
LoomMainMenu class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row | 
			row
				add: #projectBar;
				add: #commandBar;
				add: #generalControlBar ];
		yourself
]

{ #category : #accessing }
LoomMainMenu >> commandBar [
	^ commandBar
]

{ #category : #accessing }
LoomMainMenu >> generalControlBar [
	^ generalControlBar 
]

{ #category : #initialization }
LoomMainMenu >> initialize [
	self notify: '[initialize] called'.
	super initialize.
	self openWithSpec.
]

{ #category : #initialization }
LoomMainMenu >> initializePresenter [

	
]

{ #category : #initialization }
LoomMainMenu >> initializeWidgets [
	generalControlBar := self instantiate: LoomGeneralControlBar.
	commandBar := self instantiate: LoomCommandBar.
	projectBar := self instantiate: LoomProjectWindow.
	CommandBar := commandBar.
	projectBar startFSM
]

{ #category : #'error handling' }
LoomMainMenu >> notify: aString [
	"Prints the passed string in the Transcript window"

	Transcript
		cr;
		show: self class asString , ': ' , aString
]

{ #category : #accessing }
LoomMainMenu >> projectBar [
	^ projectBar
]

{ #category : #api }
LoomMainMenu >> title [
	^ ''
]
