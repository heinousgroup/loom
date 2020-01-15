Class {
	#name : #LoomProjectWindow,
	#superclass : #Object,
	#category : #Loom
}

{ #category : #adding }
LoomProjectWindow class >> addButtonSpecsTo: row [
	row
		newRow: [ :r | 
			r
				add: #newProjectButton;
				add: #saveProjectButton;
				add: #openFromFileButton;
				add: #removeProjectButton;
				add: #closeProjectButton ]
]

{ #category : #adding }
LoomProjectWindow class >> addSpecsTo: row [
	self addButtonSpecsTo: row
]

{ #category : #callbacks }
LoomProjectWindow >> closeAfterCreateProject [
	"Answer <true> if receiver's window should close after creation of a project"

	^ true
]

{ #category : #defaults }
LoomProjectWindow >> defaultProjectManagerClass [
	
	^ LoomProjectManager
]

{ #category : #api }
LoomProjectWindow >> defaultWindowTitle [
	^ 'Projects'
]

{ #category : #callbacks }
LoomProjectWindow >> doPostSaveActions [
	self notify: '[doPostSaveActions] called'
]

{ #category : #'error handling' }
LoomProjectWindow >> notify: aString [
	"Prints the passed string in the Transcript window"

	Transcript
		cr;
		show: self class asString , ': ' , aString
]

{ #category : #callbacks }
LoomProjectWindow >> updateStateOpened [

	self notify: '[updateStateOpened] called'
]
