Class {
	#name : 'LeAbstractSerializedObjectSnippet',
	#superclass : 'LeSnippet',
	#instVars : [
		'object'
	],
	#category : 'LeSerializedObjectSnippet-Model',
	#package : 'LeSerializedObjectSnippet',
	#tag : 'Model'
}

{ #category : 'api - accessing menu' }
LeAbstractSerializedObjectSnippet class >> contextMenuItemSpecification [
	"Define a method with the `<leSnippetSpecification>` pragma in a subclass if you neeed creation of snippets from the `LePage` UI."

	"<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description"
]

{ #category : 'instace creation' }
LeAbstractSerializedObjectSnippet class >> empty [
	^ self new
]

{ #category : 'initialization' }
LeAbstractSerializedObjectSnippet class >> initialize [
	"Subclasses need to regsiter themselves with readers/writers for correct functionality.
	Use the commented out lines below to achieve that."

	self subclassResponsibility	

	"self leJsonV4MappingFor: LeJsonV4 uniqueInstance newReader.
	self leJsonV4MappingFor: LeJsonV4 uniqueInstance newWriter"
]

{ #category : 'testing' }
LeAbstractSerializedObjectSnippet class >> isAbstract [
	^ self = LeAbstractSerializedObjectSnippet
]

{ #category : 'mapping - model' }
LeAbstractSerializedObjectSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: (#object -> #object);
		yourself 
]

{ #category : 'lepiter-store' }
LeAbstractSerializedObjectSnippet class >> leJsonV4Name [
	self subclassResponsibility
]

{ #category : 'converting' }
LeAbstractSerializedObjectSnippet >> asSnippetViewModel [
	<return: #LeJsonSnippetViewModel>
	^ LeSerializedObjectSnippetViewModel new snippetModel: self
]

{ #category : 'testing' }
LeAbstractSerializedObjectSnippet >> canMoveToAnotherDatabase [
	^ true
]

{ #category : 'api - accessing' }
LeAbstractSerializedObjectSnippet >> contentAsString [
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
LeAbstractSerializedObjectSnippet >> json [
	^ LeJsonV4 uniqueInstance serializePrettyWithoutSchemaAttribute: self object
]

{ #category : 'accessing' }
LeAbstractSerializedObjectSnippet >> json: aString [
	object := LeJsonV4 default deserialize: aString readStream.
	[ object snippet: self] on: MessageNotUnderstood do: [ ].
	self serialize
]

{ #category : 'accessing' }
LeAbstractSerializedObjectSnippet >> object [
	^ object
]

{ #category : 'accessing' }
LeAbstractSerializedObjectSnippet >> object: anObject [
	object := anObject.
	[ object snippet: self ] on: MessageNotUnderstood do: [  ].
	self serialize
]

{ #category : 'printing' }
LeAbstractSerializedObjectSnippet >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self object printOn: aStream.
	aStream nextPut: $)
]

{ #category : 'serialization' }
LeAbstractSerializedObjectSnippet >> serialize [
	self updateEditTimeAndEmail.
	self announceContentChangedBy: self
]

{ #category : 'printing' }
LeAbstractSerializedObjectSnippet >> storeOn: aStream [
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
