Class {
	#name : #LoomProjectSettings,
	#superclass : #Object,
	#category : #Loom
}

{ #category : #accessing }
LoomProjectSettings class >> applicationClass [
	"Private - See superimplementor's comment"

	^ LoomApplication
]

{ #category : #accessing }
LoomProjectSettings class >> projectFrameworkPragmaKeywords [
	^ Array with: 'loomProjectSettings'
]

{ #category : #settings }
LoomProjectSettings class >> projectSettingsOn: aBuilder [
	<loomProjectSettings>
	(aBuilder group: #projectSettings)
		label: self applicationName;
		description: self applicationName , ' Settings'
]

{ #category : #settings }
LoomProjectSettings class >> usernameSettingsOn: aBuilder [
	<loomProjectSettings>

	(aBuilder setting: #usernameSetting)
		target: self;
		description: 'Set the user name';
		label: 'Username';
		parent: #projectSettings
]
