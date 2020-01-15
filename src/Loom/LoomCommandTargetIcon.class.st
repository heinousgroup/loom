Class {
	#name : #LoomCommandTargetIcon,
	#superclass : #CircleMorph,
	#category : #Loom
}

{ #category : #drawing }
LoomCommandTargetIcon >> drawOn: aCanvas [
	| topAndBottom loomBlue transparentGrey |
	loomBlue := Color r: 0.098 g: 0.639 b: 0.749.
	transparentGrey := Color
		r: 0.105
		g: 0.105
		b: 0.105
		alpha: 0.3.
	aCanvas fillRectangle: self horizontalBar color: transparentGrey.
	topAndBottom := self verticalBar areasOutside: self horizontalBar.
	topAndBottom do: [ :each | aCanvas fillRectangle: each color: transparentGrey ]
]

{ #category : #'as yet unclassified' }
LoomCommandTargetIcon >> horizontalBar [
	| crossHeight |
	crossHeight := (self height / 3.0) rounded.
	^ self bounds insetBy: 0 @ crossHeight
]

{ #category : #initialization }
LoomCommandTargetIcon >> initialize [
	super initialize.
	self extent: 20 @ 20
]

{ #category : #'as yet unclassified' }
LoomCommandTargetIcon >> verticalBar [
	| crossWidth |
	crossWidth := (self width / 3.0) rounded.
	^ self bounds insetBy: crossWidth @ 0
]
