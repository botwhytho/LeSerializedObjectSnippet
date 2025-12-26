Extension { #name : 'LeJsonV4Writer' }

{ #category : '*LeSerializedObjectSnippet' }
LeJsonV4Writer >> onWithoutSchemaAttribute: aStream [

	super on: aStream.
	firstMappedObject := false.
]
