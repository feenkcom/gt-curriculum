Class {
	#name : 'GtLepiterPageFactoryExample',
	#superclass : 'Object',
	#category : 'GtCurriculum-Examples',
	#package : 'GtCurriculum',
	#tag : 'Examples'
}

{ #category : 'examples' }
GtLepiterPageFactoryExample class >> exampleRewriteJson [
	<gtExample>
	| json parsed |
	json := '{"__type":"page","uid":{"__type":"uid","uidString":"733A1E4E-8D2D-4A18-8F2B-593E2C458C9B"}}'.
	parsed := NeoJSONReader fromString: json.
	self assert: ((parsed at: 'uid') at: 'uidString') size equals: 36.
	^ parsed
]
