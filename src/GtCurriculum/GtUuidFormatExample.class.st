Class {
	#name : 'GtUuidFormatExample',
	#superclass : 'Object',
	#category : 'GtCurriculum-Examples',
	#package : 'GtCurriculum',
	#tag : 'Examples'
}

{ #category : 'examples' }
GtUuidFormatExample class >> exampleUuidLength [
	<gtExample>
	| uuid |
	uuid := UUID new asString.
	self assert: uuid size equals: 36.
	^ uuid
]
