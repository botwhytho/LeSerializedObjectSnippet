Trait {
	#name : 'TLeSerializedObject',
	#instVars : [
		'snippet',
		''
	],
	#category : 'LeSerializedObjectSnippet',
	#package : 'LeSerializedObjectSnippet'
}

{ #category : 'deleting' }
TLeSerializedObject >> delete [
	self preDeleteAction.
	self snippet removeSelf.
	self postDeleteAction
]

{ #category : 'serialization' }
TLeSerializedObject >> findPage [
	^ nil
]

{ #category : 'accessing' }
TLeSerializedObject >> page [
	^ self snippet ifNotNil: #page
]

{ #category : 'deleting' }
TLeSerializedObject >> postDeleteAction [
	"Override in Trait users."
]

{ #category : 'deleting' }
TLeSerializedObject >> preDeleteAction [
	"Override in Trait users."
]

{ #category : 'serialization' }
TLeSerializedObject >> serialize [
	self snippet
		ifNil: [ | newSnippet |
			newSnippet := self class snippetClass new object: self.
			self findPage ifNotNil: [ :aPage | aPage addSnippet: newSnippet ] ]
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
