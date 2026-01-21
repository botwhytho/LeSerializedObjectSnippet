Trait {
	#name : 'TLeSerializedProtoObject',
	#instVars : [
		'snippet'
	],
	#category : 'LeSerializedObjectSnippet',
	#package : 'LeSerializedObjectSnippet'
}

{ #category : 'accessing' }
TLeSerializedProtoObject classSide >> snippetClass [
	^ LeSerializedObjectSnippet
]

{ #category : 'deleting' }
TLeSerializedProtoObject >> delete [
	self preDeleteAction.
	self snippet ifNotNil: #removeSelf.
	self postDeleteAction
]

{ #category : 'serialization' }
TLeSerializedProtoObject >> findPage [
	^ nil
]

{ #category : 'action' }
TLeSerializedProtoObject >> gtDeleteActionFor: anAction [
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
TLeSerializedProtoObject >> gtSerializeActionFor: anAction [
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
TLeSerializedProtoObject >> page [
	^ self snippet ifNotNil: #page
]

{ #category : 'deleting' }
TLeSerializedProtoObject >> postDeleteAction [
]

{ #category : 'deleting' }
TLeSerializedProtoObject >> preDeleteAction [
]

{ #category : 'serialization' }
TLeSerializedProtoObject >> serialize [
	self snippet
		ifNil: [ self findPage
				ifNotNil: [ :aPage | aPage addSnippet: (self class snippetClass new object: self) ] ]
		ifNotNil: #serialize
]

{ #category : 'accessing' }
TLeSerializedProtoObject >> snippet [
	^ snippet
]

{ #category : 'accessing' }
TLeSerializedProtoObject >> snippet: aSnippet [
	snippet := aSnippet
]
