Class {
	#name : 'LeSerializedObjectSnippet',
	#superclass : 'LeAbstractSerializedObjectSnippet',
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

{ #category : 'initialization' }
LeSerializedObjectSnippet class >> initialize [
	self leJsonV4MappingFor: LeJsonV4 uniqueInstance newReader.
	self leJsonV4MappingFor: LeJsonV4 uniqueInstance newWriter
]

{ #category : 'lepiter-store' }
LeSerializedObjectSnippet class >> leJsonV4Name [
	^ #serializedObjectSnippet
]
