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
	self snippet removeSelf.
	[ self postDeleteAction ] on: MessageNotUnderstood do: [  ]
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
