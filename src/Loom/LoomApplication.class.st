Class {
	#name : #LoomApplication,
	#superclass : #Object,
	#category : #Loom
}

{ #category : #accessing }
LoomApplication class >> applicationName [
	"Answer a <String> with receiver's name"

	^'Loom'
]

{ #category : #defaults }
LoomApplication >> defaultProjectClass [
	"Private - See superimplementor's comment"

	^ LoomProject
]
