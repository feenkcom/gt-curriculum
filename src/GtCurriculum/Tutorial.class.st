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

{ #category : #'class accessing' }
Tutorial class >> topicMap [
	^ TopicMapExamplesCurriculum new topicMap
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
		select: [ :node | 
			node kinds
				anySatisfy: [ :kind | (kind respondsTo: #title) and: [ kind title = 'Tutorial' ] ] ])
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
Tutorial >> tutorial [
	"Should return a collection of selectors that when executed create related lessons."

	^ self shouldBeImplemented
]
