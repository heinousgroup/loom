Class {
	#name : #LoomCommandBar,
	#superclass : #ComposableModel,
	#instVars : [
		'textCommand',
		'name',
		'commandTargets',
		'commandReferences'
	],
	#category : #Loom
}

{ #category : #specs }
LoomCommandBar class >> defaultSpec [
	^ SpecLayout composed
		newRow:
			[ :row | 
			row

				add: #textCommand ] yourself
]

{ #category : #adding }
LoomCommandBar >> addCommandReferences: anOrderedCollection [
	"Adds the passed orderedCollection to the commandReferences variable"

	self clearAllReferences.
	commandReferences addAll: anOrderedCollection.
	Transcript
		cr;
		show: 'LoomCommandBar: Added new command references: ';
		show: anOrderedCollection value
]

{ #category : #adding }
LoomCommandBar >> addCommandTarget: aLoomObject [
	"Adds the passed LoomObject to the commandTargets collection"

commandTargets add: aLoomObject.
			aLoomObject showCommandTargetBorder.
			aLoomObject setIsCommandTargetTrue.
]

{ #category : #adding }
LoomCommandBar >> addCommandTargets: anOrderedCollection [
	"Adds the passed orderedCollection to the commandTargets variable"

	self clearAllTargets.
	commandTargets addAll: anOrderedCollection.
	Transcript
		cr;
		show: 'LoomCommandBar: Added new command targets: ';
		show: anOrderedCollection value.
	commandTargets do: [ :each | each showCommandTargetBorder. each setIsCommandTargetTrue  ]
]

{ #category : #commanding }
LoomCommandBar >> buildCommand: anOrderedCollection message: aMessage [
	| messageAsString firstCommandTarget |
	messageAsString := aMessage asString.
	anOrderedCollection isNotEmpty
		ifTrue:
			[ "If there are currently no command targets we still need to send the buildCommand: message to some object that has an executeCommand: method.  This is for when there are no command targets, but the user is directly addressing the LoomObjects with tags"

			firstCommandTarget := anOrderedCollection at: 1.
			firstCommandTarget executeCommand: messageAsString ]
		ifFalse: [ anOrderedCollection add: LoomDummyObject new.
			firstCommandTarget := anOrderedCollection at: 1.
			firstCommandTarget executeCommand: messageAsString ]
]

{ #category : #'as yet unclassified' }
LoomCommandBar >> clearAllReferences [
	"Empties commandReferences"

	commandReferences removeAll: commandReferences.
	
]

{ #category : #'as yet unclassified' }
LoomCommandBar >> clearAllTargets [
	"Empties commandTargets"

	commandTargets isNotEmpty
		ifTrue: [ commandTargets
				do: [ :each | 
					self notify: 'clearAllTargets Loop Cycle'.
					self removeCommandTarget: each ] ]
]

{ #category : #accessing }
LoomCommandBar >> commandReferences [

	^ commandReferences.
]

{ #category : #accessing }
LoomCommandBar >> commandTargets [

	^ commandTargets.
]

{ #category : #enumerating }
LoomCommandBar >> commandTargetsDo: aBlock [
	commandTargets do: aBlock
]

{ #category : #api }
LoomCommandBar >> extent [
	"Sets the size of the window"

	^ 1000 @ 40
]

{ #category : #initialization }
LoomCommandBar >> initialize [
	super initialize.
]

{ #category : #initialization }
LoomCommandBar >> initializePresenter [
	"comment stating purpose of message"

	commandTargets := OrderedCollection new.
	commandReferences := OrderedCollection new.
	textCommand acceptBlock: [ self buildCommand: commandTargets message: textCommand text ]
]

{ #category : #initialization }
LoomCommandBar >> initializeWidgets [
	"widget instantiation"


	textCommand := self newTextInput.

	"widget configuration"
	textCommand autoAccept: false.
	textCommand ghostText: 'Enter a command, e.g. "newObject: backpack"'.

	"tab order configuration"
	self focusOrder
		add: textCommand
]

{ #category : #'error handling' }
LoomCommandBar >> notify: aString [
	"Prints the passed string in the Transcript window"

	Transcript
		cr;
		show: self class asString , ': ' , aString
]

{ #category : #removing }
LoomCommandBar >> removeCommandTarget: aLoomObject [
	"Removes the passed LoomObject from the commandTargets collection"

	aLoomObject setIsCommandTargetFalse.
	aLoomObject hideCommandTargetBorder.
	
	commandTargets remove: aLoomObject ifAbsent: [  ]
]

{ #category : #initialization }
LoomCommandBar >> setCommandReferencesWithTags: anOrderedCollection [
	"Sets the commandReferences instance variable to the passed order collection by first filtering from all current LoomObjects to the ones that have one or more of the passed tags"

	| currentLoomObjects newCommandReferences |

	currentLoomObjects := OrderedCollection new.
	
	currentLoomObjects addAll: LoomObject allInstances.
	
	newCommandReferences := currentLoomObjects select: [:each | each hasTag: anOrderedCollection ]. 
	
	newCommandReferences isNotEmpty
		ifTrue: [self addCommandReferences: newCommandReferences. ].
	
	^newCommandReferences.
]

{ #category : #initialization }
LoomCommandBar >> setCommandTargetsWithTags: anOrderedCollection [
	"Sets the commandTargets instance variable to the passed order collection by first filtering from all current LoomObjects to the ones that have one or more of the passed tags"

	| currentLoomObjects newCommandTargets currentProjectAllMorphs |
	currentLoomObjects := OrderedCollection new.
	"Below gets all morphs in the current project INCLUDING the LoomCanvas morph itself. We remove this further down"
	currentProjectAllMorphs := LoomApplication currentProject loomCanvas allMorphs asOrderedCollection.
	currentLoomObjects := currentProjectAllMorphs select: [ :each | each isMemberOf: LoomObject ].
	Transcript
		cr;
		show: 'LoomCommandBar: currentLoomObjects: ';
		show: currentLoomObjects.
	"Remove the current project's LoomCanvas from the list of all morphs"
	"currentProjectAllMorphs removeLast."
	newCommandTargets := currentLoomObjects select: [ :each | each hasTag: anOrderedCollection ].
	newCommandTargets isNotEmpty
		ifTrue: [ self addCommandTargets: newCommandTargets ]
]

{ #category : #'as yet unclassified' }
LoomCommandBar >> syncCommandTargetsToCurrentProject [
	"Sets the CommandBar's commandTargets variable to the current LoomObject command targets in the current project"

	| currentProjectAllMorphs onlyLoomObjects startingCommandTargets |
	currentProjectAllMorphs := LoomApplication currentProject loomCanvas allMorphs asOrderedCollection.
	onlyLoomObjects := currentProjectAllMorphs select: [ :each | each isMemberOf: LoomObject ].
	startingCommandTargets := onlyLoomObjects select: [ :each | each isCommandTarget ].
	startingCommandTargets isNotEmpty
		ifTrue: [ commandTargets removeAll.
			self addCommandTargets: startingCommandTargets ]
		ifFalse: [ commandTargets removeAll. ] 
]

{ #category : #accessing }
LoomCommandBar >> textCommand [
	"Accessor so defaultSpec can access this private instance variable"

	^ textCommand.
]

{ #category : #api }
LoomCommandBar >> title [
	"Sets window title"

	^ ''
]
