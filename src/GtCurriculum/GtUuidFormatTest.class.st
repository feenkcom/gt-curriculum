Class {
	#name : 'GtUuidFormatTest',
	#superclass : 'TestCase',
	#category : 'GtCurriculum-Tests',
	#package : 'GtCurriculum',
	#tag : 'Tests'
}

{ #category : 'tests' }
GtUuidFormatTest >> testUuidStringHas36Characters [
	| uuid |
	uuid := UUID new asString.
	self assert: uuid size equals: 36
]
