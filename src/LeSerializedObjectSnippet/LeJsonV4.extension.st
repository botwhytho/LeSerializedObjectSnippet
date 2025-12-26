Extension { #name : 'LeJsonV4' }

{ #category : '*LeSerializedObjectSnippet' }
LeJsonV4 >> serializePrettyWithoutSchemaAttribute: aLeModel [

	^ String streamContents: [ :stream | 
		  self serializeWithoutSchemaAttribute: aLeModel on: stream prettyPrint: true ]
]

{ #category : '*LeSerializedObjectSnippet' }
LeJsonV4 >> serializeWithoutSchemaAttribute: aLeModel on: aStream prettyPrint: aBoolean [
	"Serialise the supplied object. aLeModel is a subclass of LeModel"

	self newWriter 
		onWithoutSchemaAttribute: aStream;
		prettyPrint: aBoolean;
		nextPut: aLeModel.

]
