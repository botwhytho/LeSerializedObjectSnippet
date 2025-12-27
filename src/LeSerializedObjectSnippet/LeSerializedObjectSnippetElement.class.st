Class {
	#name : 'LeSerializedObjectSnippetElement',
	#superclass : 'LeSnippetElement',
	#instVars : [
		'objectInspector',
		'objectSnippetElement'
	],
	#category : 'LeSerializedObjectSnippet-! Views',
	#package : 'LeSerializedObjectSnippet',
	#tag : '! Views'
}

{ #category : 'api - snippet view model' }
LeSerializedObjectSnippetElement >> onSnippetViewModelChanged [
	self
		enqueueTask: (BlTaskAction new
				action: [ objectSnippetElement
						text: (LeJsonV4 uniqueInstance
								serializePrettyWithoutSchemaAttribute: self snippet object) asRopedText ])
]

{ #category : 'api - view' }
LeSerializedObjectSnippetElement >> snippetContent [
	<return: #BlElement>
	^ objectSnippetElement
		ifNil: [ objectSnippetElement := BrEditor new
					aptitude: BrGlamorousRegularEditorAptitude new;
					styler: JSONParser gtStyler;
					padding: (BlInsets
							top: 0
							left: 2
							bottom: 0
							right: 0);
					beReadOnlyWithSelection ]
]

{ #category : 'api - view' }
LeSerializedObjectSnippetElement >> snippetToolbar [
	<return: #BlElement or: nil>
	| copyText inspectObject inspectSnippet serializeObject toolbarElement |
	toolbarElement := BrToolbar new
			aptitude: BrGlamorousToolbarAptitude;
			hMatchParent;
			vFitContent.

	copyText := BrButton new
			beSmallSize;
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons changes;
			label: 'Copy Text';
			action: [ :aButton | 
				GtClipboard
					clipboardText: (LeJsonV4 uniqueInstance
							serializePrettyWithoutSchemaAttribute: self snippet object) ].

	serializeObject := BrButton new
			beSmallSize;
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons accept;
			label: 'Save Changes';
			action: [ :aButton | self snippet serialize ].

	inspectObject := BrButton new
			beSmallSize;
			aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
			icon: BrGlamorousVectorIcons inspect;
			label: 'Object';
			action: [ :aButton | aButton phlow spawnObject: self snippet object ].

	inspectSnippet := BrButton new
			beSmallSize;
			aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
			icon: BrGlamorousVectorIcons inspect;
			label: 'Snippet';
			action: [ :aButton | aButton phlow spawnObject: self snippet ].

	^ toolbarElement
		addItems: {copyText.
				serializeObject.
				inspectObject.
				inspectSnippet}
]

{ #category : 'api - snippet view model' }
LeSerializedObjectSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.

	self snippet weak
		when: LeSnippetContentChanged
		send: #onSnippetViewModelChanged
		to: self
]
