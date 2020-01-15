Class {
	#name : #LoomProject,
	#superclass : #Object,
	#instVars : [
		'loomCanvas'
	],
	#category : #Loom
}

{ #category : #'as yet unclassified' }
LoomProject >> doCloseActions [
	"loomCanvas hide"

	loomCanvas hide.

	self notify: '[doCloseActions] called'.
]

{ #category : #'as yet unclassified' }
LoomProject >> doOpenActions [
	self notify: '[doOpenActions] called'. loomCanvas openInWorld.
	World addMorphBack: loomCanvas.
	loomCanvas fitToWindowSize.
	loomCanvas beSticky.
	CommandBar syncCommandTargetsToCurrentProject.
	self notify: 'CommandBar commandTargets synced to current project'
]

{ #category : #initialization }
LoomProject >> initialize [
	loomCanvas := LoomCanvas new.
	
]

{ #category : #accessing }
LoomProject >> loomCanvas [
	^ loomCanvas
]

{ #category : #'error handling' }
LoomProject >> notify: aString [
	"Prints the passed string in the Transcript window"

	Transcript
		cr;
		show: self class asString , ': ' , aString
]
