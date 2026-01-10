Trait {
	#name : 'TLeSerializedObject',
	#instVars : [
		'snippet'
	],
	#category : 'LeSerializedObjectSnippet',
	#package : 'LeSerializedObjectSnippet'
}

{ #category : 'deleting' }
TLeSerializedObject >> delete [
	[ self preDeleteAction ] on: MessageNotUnderstood do: [  ].
	self snippet ifNotNil: [ :aSnippet | aSnippet removeSelf ].
	[ self postDeleteAction ] on: MessageNotUnderstood do: [  ]
]

{ #category : 'action' }
TLeSerializedObject >> gtDeleteActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons remove;
		priority: 0.5;
		tooltip: 'Delete the item from Lepiter';
		action: [ :aBrButton :aBrTab :aBrButtonModel :anEvent | 
			anEvent consumed: true.
			self delete ]
]

{ #category : 'action' }
TLeSerializedObject >> gtSerializeActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 0;
		tooltip: 'Serialize changes to Lepiter';
		icon: BrGlamorousVectorIcons accept;
		action: [ :aBrButton :aBrTab :aBrButtonModel :anEvent | 
			anEvent consumed: true.
			self serialize ]
]

{ #category : 'accessing' }
TLeSerializedObject >> page [
	^ self snippet ifNotNil: #page
]

{ #category : 'serialization' }
TLeSerializedObject >> serialize [
	self snippet
		ifNil: [ | newSnippet |
			newSnippet := self class snippetClass new object: self.
			[ self findPage ifNotNil: [ :aPage | aPage addSnippet: newSnippet ] ]
				on: MessageNotUnderstood
				do: [  ] ]
		ifNotNil: #serialize
]

{ #category : 'accessing' }
TLeSerializedObject >> snippet [
	^ snippet
]

{ #category : 'accessing' }
TLeSerializedObject >> snippet: aSnippet [
	snippet := aSnippet
]
