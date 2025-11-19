Class {
	#name : 'TopicMapExamplesCurriculum',
	#superclass : 'TopicMapExamples',
	#category : 'GtCurriculum',
	#package : 'GtCurriculum'
}

{ #category : 'as yet unclassified' }
TopicMapExamplesCurriculum >> exampleTutorial [
	"Same as pageNodeWhatIsGt but with breadcrumb."

	<gtExample>
	| pageNodeWhatIsGt |
	pageNodeWhatIsGt := (self topicMap
			pageNodeWithTitle: 'Exploring GitHub through GraphQL')
			viaTopicNamed: 'About Glamorous Toolkit'.

	self assert: pageNodeWhatIsGt fields size equals: 3.
	self assert: pageNodeWhatIsGt topics size equals: 5.
	self assert: pageNodeWhatIsGt kinds size equals: 1.
	self assert: pageNodeWhatIsGt pages size equals: 1.
	self assert: pageNodeWhatIsGt children isTMNodeGroup.
	self assert: pageNodeWhatIsGt children isTMPageGroup not.
	self assert: pageNodeWhatIsGt parents equals: pageNodeWhatIsGt kindNodes.
	self assert: pageNodeWhatIsGt breadcrumb notEmpty.

	^ pageNodeWhatIsGt
]

{ #category : 'as yet unclassified' }
TopicMapExamplesCurriculum >> pageNodeWhatIsGtViaTopicAboutGt [
	"Same as pageNodeWhatIsGt but with breadcrumb."

	<gtExample>
	| pageNodeWhatIsGt |
	pageNodeWhatIsGt := (self topicMap
			pageNodeWithTitle: 'What is Glamorous Toolkit?')
			viaTopicNamed: 'About Glamorous Toolkit'.

	self assert: pageNodeWhatIsGt fields size equals: 3.
	self assert: pageNodeWhatIsGt topics size equals: 5.
	self assert: pageNodeWhatIsGt kinds size equals: 1.
	self assert: pageNodeWhatIsGt pages size equals: 1.
	self assert: pageNodeWhatIsGt children isTMNodeGroup.
	self assert: pageNodeWhatIsGt children isTMPageGroup not.
	self assert: pageNodeWhatIsGt parents equals: pageNodeWhatIsGt kindNodes.
	self assert: pageNodeWhatIsGt breadcrumb notEmpty.

	^ pageNodeWhatIsGt
]
