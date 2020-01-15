Class {
	#name : #LoomObject,
	#superclass : #PasteUpMorph,
	#instVars : [
		'name',
		'tags',
		'application',
		'isCommandTarget',
		'commandTargetIcon'
	],
	#category : #Loom
}

{ #category : #adding }
LoomObject >> addTag: anOrderedCollection [
	"Adds the passed tag to the tag array instance variable of the LoomObject"

	 tags addAll: anOrderedCollection.
	
]

{ #category : #adding }
LoomObject >> addTagsFromOrderedCollection: anOrderedCollection [
	tags addAll: anOrderedCollection.
]

{ #category : #adding }
LoomObject >> addTagsFromString: aString [
	"Takes passed string, splits on spaces out to an orderedCollection, then adds the orderedCollection of to the LoomObject's tag variable"

	| tagsToAdd |
	
	tagsToAdd := OrderedCollection new.
	
	tagsToAdd := aString splitOn: ' '.
	
	tags addAll: tagsToAdd.
]

{ #category : #accessing }
LoomObject >> application [
	^ application
]

{ #category : #accessing }
LoomObject >> application: anObject [
	application := anObject
]

{ #category : #commandTargetIcon }
LoomObject >> centerCommandTargetIcon [

	commandTargetIcon center: self center.
]

{ #category : #'event handling' }
LoomObject >> click: anEvent [
	"comment stating purpose of message"

	self notify: 'Clicked A Loom Object'.
]

{ #category : #accessing }
LoomObject >> commandTargetIcon [
	"Accessor"

		^ commandTargetIcon
]

{ #category : #'as yet unclassified' }
LoomObject >> createProperties [
	"Creates a new properties object (pane) and opens it in the world"

	| properties |

	self notify: 'Loom Object Recieved createProperties method call'. 
	properties := LoomPropertiesWidget new openWithSpec
]

{ #category : #'as yet unclassified' }
LoomObject >> executeCommand: aMessage [
	"Correctly formats and then executes the command sent from the user using the command bar"

	| colon hasColon beforeColon afterColon afterColonTrimmed tagsAndCommand command values messageContentsCollection tagsForTargetting referencesAndValues validCommand |
	colon := ':'.
	tagsForTargetting := OrderedCollection new.
	values := OrderedCollection new.
	hasColon := colon search: aMessage asString.
	"Check if potential command is a 'colon command' or not."
	hasColon
		ifTrue: [ messageContentsCollection := aMessage asString splitOn: colon.
			beforeColon := messageContentsCollection at: 1.
			afterColon := messageContentsCollection at: 2.
			"Get an orderedCollection of all tags and commands (values before the colon, split on spaces)"
			tagsAndCommand := beforeColon splitOn: ' '.
			"Get an orderedCollection of only the tags (by excluding the last string which is assumed to be the command)"
			tagsForTargetting := tagsAndCommand allButLast.
			command := tagsAndCommand last.
			"Add the colon back on to the end of the command string (it was automatically removed during the initial splitOn: method)"
			command := command , colon.
			tagsForTargetting isNotEmpty
				ifTrue: [ CommandBar setCommandTargetsWithTags: tagsForTargetting ].
			afterColonTrimmed := afterColon trimLeft.
			referencesAndValues := afterColonTrimmed splitOn: ' '.
			validCommand := self hasCommand: command.
			validCommand
				ifTrue: [ self perform: command asSymbol with: referencesAndValues ]
				ifFalse: [ self notify: 'Error - Command not found in commands protocol' ] ]
		ifFalse: [ messageContentsCollection := aMessage asString splitOn: ' '.
			tagsForTargetting := messageContentsCollection allButLast.
			tagsForTargetting isNotEmpty
				ifTrue: [ CommandBar setCommandTargetsWithTags: tagsForTargetting ].
			command := messageContentsCollection last.
			validCommand := self hasCommand: command.
			validCommand
				ifTrue: [ self perform: command asSymbol ]
				ifFalse: [ self notify: 'Error - Command not found in commands protocol' ] ]
]

{ #category : #commands }
LoomObject >> fullHeight [
	"Sets the Loom Object's height property to that of its owner morph"

	CommandBar
		commandTargetsDo: [ :each | 
			each height: owner height.
			each top: owner top ]
]

{ #category : #commands }
LoomObject >> fullWidth [
	"Sets the Loom Object's width property to that of its owner morph"

	CommandBar
		commandTargetsDo: [ :each | 
			each width: owner width.
			each left: owner left ]
]

{ #category : #commands }
LoomObject >> goldenRatio [
	"Sets the Loom Object's width and height to the golden ratio (can use in combination with fullWidth or fullHeight to quickly size submorphs"

	| newWidth newHeight |
	CommandBar
		commandTargetsDo: [ :each | 
			newWidth := owner width / 1.618.
			newHeight := owner height / 1.618.
			each width: newWidth.
			each height: newHeight ]
]

{ #category : #'event handling' }
LoomObject >> handleKeystroke: anEvent [
	"Handles keystrokes for currently focused LoomObject"

		| keyValue |
		keyValue := anEvent keyValue.
		keyValue = 30 "up arrow"
		ifTrue: [self position: self position - (0 @ 10)].
		keyValue = 31 "down arrow"
		ifTrue: [self position: self position + (0 @ 10)].
		keyValue = 29 "right arrow"
		ifTrue: [self position: self position + (10 @ 0)].
		keyValue = 28 "left arrow"
		ifTrue: [self position: self position - (10 @ 0)]
]

{ #category : #'event handling' }
LoomObject >> handlesMouseDown:  anEvent [
	"Returns true to indicate that it will respond to mouse down events"
	
	"Makes it so it returns true if shift is pressed"

	^anEvent shiftPressed.
	
	"^true."
]

{ #category : #'event handling' }
LoomObject >> handlesMouseEnter: anEvent [
	"comment stating purpose of message"

	^false.
]

{ #category : #'event handling' }
LoomObject >> handlesMouseOver: anEvent [
	"Returns true to indicate that it will respond to mouse over events"

	^true.
	
]

{ #category : #testing }
LoomObject >> hasCommand: aCommand [
	"Checks if the LoomObject has the passed command in its 'commands' protocol"

	| availableCommands |
	
	availableCommands := OrderedCollection new.
	availableCommands := LoomObject allSelectorsInProtocol: #commands.
	
	
	^ (availableCommands includes: aCommand).
]

{ #category : #testing }
LoomObject >> hasTag: anOrderedCollection [
	"Returns true if the LoomObject's tag variable contains a string that is also present in the passed orderedCollection"

	| tagFound tagPresent allTags tagsEmpty |
	
	tagFound := false.
	
	allTags := self tags.
	
	tagsEmpty := (allTags isNil).
	
	tagsEmpty
		ifFalse: [ 
					tags do: [:each | tagPresent := (anOrderedCollection includes: each). tagPresent ifTrue: [tagFound := true. ^tagFound.]. ] 
		].
	
	^tagFound.
]

{ #category : #'as yet unclassified' }
LoomObject >> hideCommandTargetBorder [
	"Sets the LoomObject's borderWidth to 0"
	self borderWidth: 0.
]

{ #category : #initialization }
LoomObject >> initialize [
	super initialize.
	color := Color r: 0.9 g: 0.9 b: 0.9.
	bounds := 16 @ 80 extent: 100 @ 100.
	borderColor := Color r: 0.098 g: 0.639 b: 0.749.
	self initializeCommandTargetIcon.
	self borderWidth: 0.
	isCommandTarget := false.
	tags := OrderedCollection new.
	tags add: '*'.
	self setAsCommandTarget.

	"Need to get a reference to the current (only) LoomApplication >> DON'T ACTUALLY NEED THIS AT ALL"
	self application: LoomApplication


	"self on: #startDrag send: #fullWidth to: self."

	"Below still doesn't work because this LoomObject needs to first recieve the mouseDown event before it will set the below"
	"super on: #mouseDown send: #fullHeight to: self."



	"self createPropertiesPane: self << runs a method on this LoomObject that creates an instance of a LoomPropertiesPane object and passes it 'self' from this LoomObject to use as the data for this specific instance of LoomPropertiesPane"

	"properties := self createProperties"
]

{ #category : #initialization }
LoomObject >> initializeCommandTargetIcon [
	"Creates the LoomObject's command target icon.  Not visible by default"

	commandTargetIcon := LoomCommandTargetIcon new.
	self addMorphCentered: commandTargetIcon.
	commandTargetIcon hide

	
]

{ #category : #accessing }
LoomObject >> isCommandTarget [
	"Accessor"

	^ isCommandTarget
]

{ #category : #'dropping/grabbing' }
LoomObject >> mouseDown: anEvent [
	"Changes clicked object's color to white"

	anEvent redButtonPressed
		ifTrue: [ self toggleAsCommandTarget ].
	anEvent yellowButtonPressed
		ifTrue: [ self color: Color orange.
			self name: 'Orange Guy' ].
	self changed

	"^anEvent"

	"anEvent hand waitForClicksOrDrag: self event: anEvent."
]

{ #category : #'event handling' }
LoomObject >> mouseEnter: anEvent [
	"Hands focus to the LoomObject the mouse just hovered over"
	
	anEvent redButtonPressed
	ifTrue: [self setAsCommandTarget].
	self changed

]

{ #category : #'event handling' }
LoomObject >> mouseLeave: anEvent [
	"Remove focus on object when mouse leave event is triggered"

	
	"anEvent hand newKeyboardFocus: nil"
]

{ #category : #'event handling' }
LoomObject >> mouseUp: anEvent [

	

]

{ #category : #commands }
LoomObject >> newChild: anOrderedCollection [
	"Create a new LoomObject as the child of each of the current commandTargets"

	| child |
	
	CommandBar
		commandTargetsDo: [ :each | 
			child := LoomObject new.
			child openInCurrentProject.
			child addTagsFromOrderedCollection: anOrderedCollection.
			each addMorphCentered: child.
			each removeAsCommandTarget ]
]

{ #category : #commands }
LoomObject >> newObject [
	"Creates a new LoomObject without any specified tags"

	CommandBar clearAllTargets.
	LoomObject new openInCurrentProject
]

{ #category : #commands }
LoomObject >> newObject: anOrderedCollection [
	"Creates a new LoomObject with passed tags"

	| newLoomObject |
	CommandBar clearAllTargets.
	newLoomObject := LoomObject new openInCurrentProject.
	anOrderedCollection do: [ :each | newLoomObject addTagsFromString: each ].
	

]

{ #category : #'error handling' }
LoomObject >> notify: aString [
	"Prints the passed string in the Transcript window"

	Transcript
		cr;
		show: self class asString , ': ' , aString
]

{ #category : #'as yet unclassified' }
LoomObject >> openInCurrentProject [
	"Opens the LoomObject in the current project's LoomCanvas."

	LoomApplication hasProject
		ifTrue: [ LoomApplication currentProject loomCanvas addMorphCentered: self ]
		ifFalse: [ self notify: 'No currentProject to add LoomObject to']
]

{ #category : #commands }
LoomObject >> pickColor [
	"Opens a color picker dialog"


	CommandBar commandTargetsDo: [ :each | each changeColor ]
]

{ #category : #commands }
LoomObject >> remove [

		
		
	CommandBar
		commandTargetsDo: [ :each | 
			each setIsCommandTargetFalse.
			each delete ].
		
		
	CommandBar syncCommandTargetsToCurrentProject
]

{ #category : #removing }
LoomObject >> removeAsCommandTarget [
	CommandBar removeCommandTarget: self.
]

{ #category : #commands }
LoomObject >> rotate: aString [
	"Rotates the LoomObject based on an integer degree value passed in"

	| angle isValidAngle |
	angle := aString asNumber.
	isValidAngle := angle between: -360 and: 360.
	isValidAngle
		ifTrue: [ self notify: 'Valid degrees!'.
			"self heading: degrees."
			self position: self position + (Point r: 8 degrees: angle) ]
		ifFalse: [ 
				self notify: 'Whoops! Please enter valid angle between -360 & 360, e.g. "rotate: 45".' ]
]

{ #category : #commands }
LoomObject >> scale: anOrderedCollection [
	"Scales the LoomObject based on a multiplier that is the passed value"

	| scaleMultiplier isPositive isFloat scaleString startsWithPeriod values |
	values := self setCommandReferencesReturnValues: anOrderedCollection.
	scaleString := values at: 1.
	startsWithPeriod := scaleString beginsWith: '.'.
	startsWithPeriod
		ifTrue: [ scaleString := '0' , scaleString ].
	scaleMultiplier := scaleString asNumber.
	isPositive := scaleMultiplier strictlyPositive.
	isFloat := scaleMultiplier isFloat.
	isPositive
		ifTrue: [ self notify: 'Positive Number Entered. Good Job.'.
			CommandBar commandTargetsDo: [ :each | each extent: each extent * scaleMultiplier ] ]
		ifFalse: [ self notify: 'Whoops! The multiplier must be a positive number.' ]
]

{ #category : #initialization }
LoomObject >> setAsCommandTarget [
	"Sets self to the command input's target instance variable"

	CommandBar addCommandTarget: self.
]

{ #category : #initialization }
LoomObject >> setCommandReferencesReturnValues: anOrderedCollection [
	"Takes in anOrderedCollection of value(s) and/or reference(s), sets references to CommandBar's commandReferences variable, and returns only the values (by simply removing the first value of the passed orderedCollection "

	| newCommandReferences |
	newCommandReferences := CommandBar setCommandReferencesWithTags: anOrderedCollection.
	newCommandReferences isNotEmpty
		ifTrue: [ newCommandReferences do: [ anOrderedCollection removeFirst ] ].
	^ anOrderedCollection
]

{ #category : #initialization }
LoomObject >> setIsCommandTargetFalse [
	"Sets this LoomObject's isCommandTarget instance variable to false"

	isCommandTarget := false
]

{ #category : #initialization }
LoomObject >> setIsCommandTargetTrue [
	"Sets this LoomObject's isCommandTarget instance variable to true"

	isCommandTarget := true.
	"self addDropShadow.
	self changed"
]

{ #category : #commandTargetIcon }
LoomObject >> showCommandTargetBorder [
	"commandTargetIcon center: self center.
	commandTargetIcon show"

	self borderWidth: 5.
]

{ #category : #commands }
LoomObject >> size: anOrderedCollection [
	| values validInput newWidth newHeight |
	values := self setCommandReferencesReturnValues: anOrderedCollection.
	validInput := true.
	newWidth := values at: 1.
	newHeight := values at: 2.
	newWidth := newWidth asNumber.
	newHeight := newHeight asNumber.
	newWidth isNumber
		ifFalse: [ validInput := false.
			self notify: 'Width value must be a valid number' ].
	newHeight isNumber
		ifFalse: [ validInput := false.
			self notify: 'Height value must be a valid number' ].
	newWidth := newWidth
		asInteger;
		abs.
	newHeight := newHeight
		asInteger;
		abs.
	validInput
		ifTrue: [ CommandBar
				commandTargetsDo: [ :each | 
					each extent: newWidth @ newHeight ] ]
]

{ #category : #'as yet unclassified' }
LoomObject >> splitReferencesAndValues: anOrderedCollection [
	"Returns two orderedCollections of references and values (used for command system) "

	| referencesAsStrings references values referencesAndValues |
	
	referencesAsStrings := anOrderedCollection new.
	references := anOrderedCollection new.
	values := anOrderedCollection new.
	
	referencesAndValues := anOrderedCollection.
	
	
	
	
]

{ #category : #commands }
LoomObject >> tag: anOrderedCollection [
	"Adds one or more tag to the LoomObject's tag orderedCollection variable."


	CommandBar commandTargetsDo: [ :each | each addTag: anOrderedCollection ]
]

{ #category : #accessing }
LoomObject >> tags [
	"Accessor"

	^tags.
]

{ #category : #commands }
LoomObject >> targetParent [
	"Sets the command bar's target to the currently targetted LoomObject's owner"

	| parentToAdd parentIsLoomObject |
	CommandBar
		commandTargetsDo: [ :each | 
			parentToAdd := each owner.
			parentIsLoomObject := parentToAdd isMemberOf: LoomObject.
			parentIsLoomObject
				ifTrue: [ CommandBar addCommandTarget: parentToAdd.
					CommandBar removeCommandTarget: each ]
				ifFalse: [ self notify: 'Parent is not a LoomObject. Parent not added as command target' ] ]
]

{ #category : #'as yet unclassified' }
LoomObject >> toggleAsCommandTarget [
	isCommandTarget
		ifTrue: [ 
			CommandBar removeCommandTarget: self ]
		ifFalse: [ CommandBar addCommandTarget: self ]
]
