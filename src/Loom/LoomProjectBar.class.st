Class {
	#name : #LoomProjectBar,
	#superclass : #Object,
	#instVars : [
		'projectDropdownButton'
	],
	#category : #Loom
}

{ #category : #adding }
LoomProjectBar class >> addSpecsTo: row [

	self addButtonSpecsTo: row
]

{ #category : #callbacks }
LoomProjectBar >> doPostOpenActions [
	" Basic post open actions. Redefine in subclasses if necessary "

	super doPostOpenActions.
	self updateCurrentProjectDetails
]

{ #category : #callbacks }
LoomProjectBar >> doPostSaveActions [
	" Basic successful post save actions. Redefine in subclasses if necessary "

	super doPostSaveActions.
	self updateCurrentProjectDetails
]

{ #category : #initialization }
LoomProjectBar >> initializeLabels [
	super initializeLabels.
	self currentProjectName
]

{ #category : #initialization }
LoomProjectBar >> initializePrvWidgets [
	" Private - See superimplementor's comment "

	super initializePrvWidgets.

]

{ #category : #accessing }
LoomProjectBar >> projectDropdownButton [
	^projectDropdownButton
]

{ #category : #callbacks }
LoomProjectBar >> releaseProject [
	" Private - see superimplementor's comment "

	self applicationClass releaseProject
]

{ #category : #removing }
LoomProjectBar >> removeProject [
	" Remove the selected project "

	[ super removeProject ]
		on: PFSuccessRemove , PFSuccessClose
		do: [ :ex | 
			self currentProjectsLabel label: self currentProjectLabelContent.
			self updateCurrentProjectDetails.
			ex pass ]
]

{ #category : #callbacks }
LoomProjectBar >> updateCloseProject [
	
]

{ #category : #callbacks }
LoomProjectBar >> updateNewProject: aString [
	" Private - A new project was opened, update receiver accordingly "

	super updateNewProject: aString.
	self applicationClass currentProjectName.

]

{ #category : #callbacks }
LoomProjectBar >> updateOpenedProject [
	" Private - A new project was opened, update receiver accordingly "

	super updateOpenedProject.
	self applicationClass currentProjectName.

]

{ #category : #callbacks }
LoomProjectBar >> updateProjectStatus: aBoolean [
	" Answer a <String> reporting receiver's opened file status "

	aBoolean
		ifTrue: [ ^ self translator tProjectSaved ].
	^ self translator tNotAFile
]
