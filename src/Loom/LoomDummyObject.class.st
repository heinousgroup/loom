Class {
	#name : #LoomDummyObject,
	#superclass : #Object,
	#instVars : [
		'isCommandTarget'
	],
	#category : #Loom
}

{ #category : #'as yet unclassified' }
LoomDummyObject >> executeCommand: aMessage [
	"Used mainly to see if there are any valid tags to be added to commandtargets, then sends 'executeCommand: messageAsString' or whatever on all newly added commandTargets"

	| colon hasColon beforeColon afterColon afterColonTrimmed tagsAndCommand command validCommand referencesAndValues values messageContentsCollection tagsForTargetting commandTargets |
	colon := ':'.
	tagsForTargetting := OrderedCollection new.
	values := OrderedCollection new.
	hasColon := colon search: aMessage asString.

	"Immediately remove the dummy object as a command target"
	CommandBar clearAllTargets.

	"Check if potential command is a 'colon command' or not."
	hasColon
		ifTrue: [ messageContentsCollection := aMessage asString splitOn: colon.
			beforeColon := messageContentsCollection at: 1.
			afterColon := messageContentsCollection at: 2.
			"Get an orderedCollection of all tags and commands (values before the colon, split on spaces)"
			tagsAndCommand := beforeColon splitOn: ' '.
			command := tagsAndCommand last.
			command := command , colon.
			"Get an orderedCollection of only the tags (by excluding the last string which is assumed to be the command)"
			tagsForTargetting := tagsAndCommand allButLast.
			afterColonTrimmed := afterColon trimLeft.
			referencesAndValues := afterColonTrimmed splitOn: ' '.
			tagsForTargetting isNotEmpty
				ifTrue: [ "Tell all newly added command targets to perform the command that was sent to this dummy object"
					CommandBar setCommandTargetsWithTags: tagsForTargetting.
					commandTargets := CommandBar commandTargets.
					commandTargets do: [ :each | each perform: 'executeCommand:' asSymbol with: aMessage ] ]
				ifFalse: [ validCommand := self hasCommand: command.
					validCommand
						ifTrue: [ self perform: command asSymbol with: referencesAndValues ]
						ifFalse: [ self notify: 'Error - Command not found in commands protocol' ] ] ]
		ifFalse: [ messageContentsCollection := aMessage asString splitOn: ' '.
			tagsForTargetting := messageContentsCollection allButLast.
			tagsForTargetting isNotEmpty
				ifTrue: [ "Tell all newly added command targets to perform the command that was sent to this dummy object"
					CommandBar setCommandTargetsWithTags: tagsForTargetting.
					commandTargets := CommandBar commandTargets.
					commandTargets do: [ :each | each perform: 'executeCommand:' asSymbol with: aMessage ] ]
				ifFalse: [ validCommand := self hasCommand: command.
					validCommand
						ifTrue: [ self perform: command asSymbol ]
						ifFalse: [ self notify: 'Error - Command not found in commands protocol' ] ] ]
]

{ #category : #testing }
LoomDummyObject >> hasCommand: aCommand [
	"Checks if the LoomObject has the passed command in its 'commands' protocol"

	| availableCommands |
	availableCommands := OrderedCollection new.
	availableCommands := LoomDummyObject allSelectorsInProtocol: #commands.
	^ availableCommands includes: aCommand
]

{ #category : #'as yet unclassified' }
LoomDummyObject >> hideCommandTargetBorder [
	"Sets the LoomObject's borderWidth to 0"

	^ true
]

{ #category : #initialization }
LoomDummyObject >> initialize [

	super initialize.
	isCommandTarget := false
]

{ #category : #commands }
LoomDummyObject >> newObject [
	"Creates a new LoomObject without any specified tags"

	LoomObject new openInCurrentProject
]

{ #category : #commands }
LoomDummyObject >> newObject: anOrderedCollection [
	"Same as newSibling: command, just more intuitive to type or say"

	| newLoomObject |
	newLoomObject := LoomObject new openInCurrentProject.
	anOrderedCollection do: [ :each | newLoomObject addTagsFromString: each ]
]

{ #category : #'error handling' }
LoomDummyObject >> notify: aString [
	"Prints the passed string in the Transcript window"

	Transcript
		cr;
		show: self class asString , ': ' , aString
]

{ #category : #removing }
LoomDummyObject >> removeAsCommandTarget [
	CommandBar removeCommandTarget: self
]

{ #category : #initialization }
LoomDummyObject >> setIsCommandTargetFalse [
	"Sets this LoomDummyObject's isCommandTarget instance variable to false"

	isCommandTarget := false
]

{ #category : #initialization }
LoomDummyObject >> setIsCommandTargetTrue [
	"Sets this LoomDummyObject's isCommandTarget instance variable to true"

	isCommandTarget := true
]
