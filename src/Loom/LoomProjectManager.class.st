Class {
	#name : #LoomProjectManager,
	#superclass : #Object,
	#category : #Loom
}

{ #category : #accessing }
LoomProjectManager >> applicationClass [
	"Private - See superimplementor's comment"

	^ LoomApplication
]

{ #category : #initialization }
LoomProjectManager >> initialize [
	"Private - See superimplementor's comment"

	super initialize.
	self applicationClass: LoomApplication.
	self projectClass: LoomProject.
]

{ #category : #'error handling' }
LoomProjectManager >> notify: aString [
	"Prints the passed string in the Transcript window"

	Transcript
		cr;
		show: self class asString , ': ' , aString
]

{ #category : #accessing }
LoomProjectManager >> projectClass [
	" Answer the user class representing a project "

	^ LoomProject
]

{ #category : #accessing }
LoomProjectManager >> settingsClass [
	"Private - See superimplementor's comment"

	^ LoomProjectSettings
]
