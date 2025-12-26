Class {
	#name : 'BaselineOfLeSerializedObjectSnippet',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfLeSerializedObjectSnippet',
	#package : 'BaselineOfLeSerializedObjectSnippet'
}

{ #category : 'baseline' }
BaselineOfLeSerializedObjectSnippet >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'LeSerializedObjectSnippet'
		]
]
