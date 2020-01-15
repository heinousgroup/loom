Class {
	#name : #LoomLoginForm,
	#superclass : #ComposableModel,
	#instVars : [
		'lastResponse',
		'emailField',
		'passwordField',
		'buttonLogin',
		'buttonTest1',
		'buttonTest2',
		'buttonTest3'
	],
	#category : #Loom
}

{ #category : #specs }
LoomLoginForm class >> defaultSpec [
	^ SpecColumnLayout composed
	newRow: [  :row | row add: #emailField ] height: 30;
	newRow: [  :row | row add: #passwordField ] height: 30;
	newRow: [  :row | row add: #buttonTest1 ] height: 30;
	newRow: [  :row | row add: #buttonTest2 ] height: 30;
	newRow: [  :row | row add: #buttonTest3 ] height: 30;
	newRow: [  :row | row add: #buttonLogin ] height: 30;
	yourself
]

{ #category : #accessing }
LoomLoginForm >> buttonLogin [
	^ buttonLogin
]

{ #category : #accessing }
LoomLoginForm >> buttonLogin: anObject [
	buttonLogin := anObject
]

{ #category : #accessing }
LoomLoginForm >> buttonTest1 [
	^ buttonTest1
]

{ #category : #accessing }
LoomLoginForm >> buttonTest1: anObject [
	buttonTest1 := anObject
]

{ #category : #accessing }
LoomLoginForm >> buttonTest2 [
	^ buttonTest2
]

{ #category : #accessing }
LoomLoginForm >> buttonTest2: anObject [
	buttonTest2 := anObject
]

{ #category : #accessing }
LoomLoginForm >> buttonTest3 [
	^ buttonTest3
]

{ #category : #accessing }
LoomLoginForm >> buttonTest3: anObject [
	buttonTest3 := anObject
]

{ #category : #accessing }
LoomLoginForm >> emailField [
	^ emailField
]

{ #category : #accessing }
LoomLoginForm >> emailField: anObject [
	emailField := anObject
]

{ #category : #initialization }
LoomLoginForm >> initialize [
	
	super initialize.
	
	self title: 'Login'.
	
]

{ #category : #initialization }
LoomLoginForm >> initializePresenter [
	buttonLogin action: [ self tryLogin ].
	buttonTest1 action: [ 
		emailField text: 'chriswebbymastercontrol@gmail.com'. 
		passwordField text: 'Chriswebby8888*' ].
	buttonTest2 action: [ 
		emailField text: 'loomtestuser2@gmail.com'. 
		passwordField text: 'Loomtestuser3333*' ].
	buttonTest3 action: [ 
		emailField text: 'team@heinousgroup.com'. 
		passwordField text: 'Heinousgroup304*' ].
]

{ #category : #initialization }
LoomLoginForm >> initializeWidgets [
	
	"Widget intialization"
	emailField := self newTextInput.
	passwordField := self newTextInput.
	buttonTest1 := self newButton.
	buttonTest2 := self newButton.
	buttonTest3 := self newButton.
	buttonLogin := self newButton.
	
	"Widget configuration"
	emailField
		ghostText: 'Email';
		acceptBlock: [ self tryLogin ];
		acceptOnCR: true.
	passwordField
		ghostText: 'Password';
		acceptBlock: [ self tryLogin ];
		acceptOnCR: true.
	buttonTest1 label: 'Test 1'.
	buttonTest2 label: 'Test 2'.
	buttonTest3 label: 'Test 3'.
	buttonLogin label: 'Login'.
	
	"Setting focus order"
	self focusOrder
		add: emailField;
		add: passwordField;
		add: buttonLogin.

]

{ #category : #accessing }
LoomLoginForm >> lastResponse [
	^ lastResponse
]

{ #category : #accessing }
LoomLoginForm >> lastResponse: anObject [
	lastResponse := anObject
]

{ #category : #tests }
LoomLoginForm >> loginFail [




	Transcript cr; show: 'Login Failed :('
]

{ #category : #tests }
LoomLoginForm >> loginSuccess [


	
	Transcript cr; show: 'Login Successful!'
]

{ #category : #accessing }
LoomLoginForm >> passwordField [
	^ passwordField
]

{ #category : #accessing }
LoomLoginForm >> passwordField: anObject [
	passwordField := anObject
]

{ #category : #tests }
LoomLoginForm >> tryLogin [

	| response |
	
	"emailField accept."
	"passwordField accept."	
	
	response := (ZnClient new)
  	 	url: 'http://byheinous.com/_functions-dev/validateLogin';
		headerAt: 'email' add: emailField text;
		headerAt: 'password' add: passwordField text;
		post;
 	 	response.
	self lastResponse: response.	
	response entity isNil
		ifTrue: [ self loginFail ] 
		ifFalse: [ self loginSuccess ].
		
	Transcript cr.
	response writeOn: Transcript.
	Transcript cr; show: emailField text.
	Transcript cr; show: passwordField text.
	Transcript cr.
	Transcript cr.
	Transcript flush.
]
