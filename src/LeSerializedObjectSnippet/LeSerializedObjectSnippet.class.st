Class {
	#name : 'LeSerializedObjectSnippet',
	#superclass : 'LeSnippet',
	#instVars : [
		'object'
	],
	#category : 'LeSerializedObjectSnippet-Model',
	#package : 'LeSerializedObjectSnippet',
	#tag : 'Model'
}

{ #category : 'api - accessing menu' }
LeSerializedObjectSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : 'accessing' }
LeSerializedObjectSnippet class >> description [
	^ 'Serialized Object'
]

{ #category : 'instace creation' }
LeSerializedObjectSnippet class >> empty [
	^ self new
]

{ #category : 'lepiter-store' }
LeSerializedObjectSnippet class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary.
	Set reference to snippet from object if object has said method."
	| aLeModel |

	aLeModel := super leFromJsonV4Dictionary: aDictionary.
	[aLeModel object snippet: aLeModel] on: MessageNotUnderstood do: [ ].
	^ aLeModel
]

{ #category : 'mapping - model' }
LeSerializedObjectSnippet class >> leJsonV3AttributeMapping [
	^ super leJsonV3AttributeMapping
		add: (#object -> #object);
		yourself 
]

{ #category : 'lepiter-store' }
LeSerializedObjectSnippet class >> leJsonV3Name [
	^ #serializedObjectSnippet
]

{ #category : 'mapping - model' }
LeSerializedObjectSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: (#object -> #object);
		yourself 
]

{ #category : 'lepiter-store' }
LeSerializedObjectSnippet class >> leJsonV4Name [
	^ #serializedObjectSnippet
]

{ #category : 'converting' }
LeSerializedObjectSnippet >> asSnippetViewModel [
	<return: #LeJsonSnippetViewModel>
	^ LeSerializedObjectSnippetViewModel new snippetModel: self
]

{ #category : 'testing' }
LeSerializedObjectSnippet >> canMoveToAnotherDatabase [
	^ true
]

{ #category : 'api - accessing' }
LeSerializedObjectSnippet >> contentAsString [
	<return: #String>
	^ String
		streamContents: [ :aStream | 
			aStream
				<< '```Json';
				cr;
				<< self json;
				cr;
				<< '```' ]
]

{ #category : 'serialization' }
LeSerializedObjectSnippet >> json [
	^ LeJsonV4 uniqueInstance serializePrettyWithoutSchemaAttribute: self object
]

{ #category : 'accessing' }
LeSerializedObjectSnippet >> json: aString [
	object := LeJsonV4 default deserialize: aString readStream.
	self announceContentChangedBy: self
]

{ #category : 'accessing' }
LeSerializedObjectSnippet >> object [
	^ object
]

{ #category : 'accessing' }
LeSerializedObjectSnippet >> object: anObject [
	object := anObject.
	self announceContentChangedBy: self
]

{ #category : 'printing' }
LeSerializedObjectSnippet >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self object printOn: aStream.
	aStream nextPut: $)
]

{ #category : 'printing' }
LeSerializedObjectSnippet >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new object: '.
	self object storeOn: aStream.
	self
		childrenDo: [ :snippet | 
			aStream nextPutAll: '; addSnippet: '.
			snippet storeOn: aStream ].
	aStream nextPutAll: '; yourself)'
]
