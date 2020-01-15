Class {
	#name : #LoomCanvas,
	#superclass : #PasteUpMorph,
	#category : #Loom
}

{ #category : #drawing }
LoomCanvas >> clipSubmorphs [
	^ true.
]

{ #category : #'as yet unclassified' }
LoomCanvas >> fitToWindowSize [
	"Resizes the LoomCanvas to fit correctly in the current world"

	self width: owner width.
	self left: owner left.
	self top: owner top + 80.
	self height: owner height - 40.
]

{ #category : #initialization }
LoomCanvas >> initialize [
	super initialize.
	self extent: 600 @ 400.
	color := Color
		r: 0.325
		g: 0.325
		b: 0.325
		alpha: 1.0.
	borderColor := Color
		r: 0.325
		g: 0.325
		b: 0.325
		alpha: 1.0.
	self
		on: $  shift
		do: [  ]
]

{ #category : #'error handling' }
LoomCanvas >> notify: aString [
	"Prints the passed string in the Transcript window"

	Transcript
		cr;
		show: self class asString , ': ' , aString
]
