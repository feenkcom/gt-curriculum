"
To create your own tutorial:
- subclass AbstractTutorial
- implement a few methods which return a Lesson instance
- implement the method #tutorial which returns a collection of selectors that when executed create related lessons.

For examples, see MockTutorial (minimalist) and PharoSyntaxTutorial (the default Pharo tutorial).

See the PharoTutorial class comment to execute your own tutorial.
"
Class {
	#name : #Tutorial,
	#superclass : #AbstractTutorial,
	#category : #GtCurriculum
}

{ #category : #'as yet unclassified' }
Tutorial class >> exampleAllKinds [
	<gtExample>
	^ (self topicMap pageNodes flatCollect: [ :node | node kinds ]) asSet
		asOrderedCollection
]

{ #category : #'as yet unclassified' }
Tutorial class >> exampleTutorialPages [
	<gtExample>
	^ self tutorialNamedPages
]

{ #category : #'as yet unclassified' }
Tutorial class >> lessonPageNamed: aString [
	"Return the LePage with the given title from the tutorial pages."

	^ self tutorialPages detect: [ :page | page title = aString ]
]

{ #category : #'as yet unclassified' }
Tutorial class >> pagesForFieldNamed: fieldName [
	| topicMap fieldNode |
	topicMap := self topicMap.	"TMGtBookRoadmapExamples shows how to get the database node."
	fieldNode := TMGtBookRoadmapExamples new gtBasicsFieldNode.	"Or search the field nodes for the name you want."

	^ fieldNode pages
]

{ #category : #'as yet unclassified' }
Tutorial class >> pagesForTopicNamed: aTopic [
	^ self topicMap pages4Topic: aTopic
]

{ #category : #'class accessing' }
Tutorial class >> topicMap [
	^ TopicMap default
]

{ #category : #'class accessing' }
Tutorial class >> tutorialNamedPages [
	^ (self tutorialPages collect: [ :page | page title ]) asOrderedCollection
]

{ #category : #'class accessing' }
Tutorial class >> tutorialPageNodes [
	| nodes |
	nodes := self topicMap pageNodes.
	^ (nodes
		select: [ :node | node kinds anySatisfy: [ :kind | kind = 'Tutorial' ] ])
		asOrderedCollection
]

{ #category : #'class accessing' }
Tutorial class >> tutorialPages [
	| pages |
	pages := OrderedCollection new.
	self tutorialPageNodes
		do: [ :node | node pages ifNotEmpty: [ pages addAll: node pages ] ].
	^ pages
]

{ #category : #'as yet unclassified' }
Tutorial >> exampleTutorial [
	<gtExample>
	| tutorial |
	tutorial := Tutorial new.
	^ tutorial
]

{ #category : #'as yet unclassified' }
Tutorial >> lessonIntro [
	| page |
	page := self class lessonPageNamed: 'A Moldable Development Curriculum'.
	^ Lesson new
		title: page title;
		content: page;
		yourself	"or use whatever API Lesson expects"
]

{ #category : #'as yet unclassified' }
Tutorial >> tutorial [
	"Return a collection of selectors that create Lesson instances."

	^ self shouldBeImplemented
]
