Class {
	#name : #GtLearningPath,
	#superclass : #Object,
	#instVars : [
		'title',
		'audience',
		'problemStatement',
		'duration',
		'goals',
		'prerequisites',
		'segments',
		'resources',
		'assessments',
		'tags'
	],
	#category : #'GtCurriculum-Paths'
}

{ #category : #'instance creation' }
GtLearningPath class >> named: aTitle audience: anAudience problem: aProblem [
	^ self new
		title: aTitle;
		audience: anAudience;
		problemStatement: aProblem;
		yourself
]

{ #category : #assessments }
GtLearningPath >> addAssessment: anAssessment [
	self assessments add: anAssessment.
	^ anAssessment
]

{ #category : #goals }
GtLearningPath >> addGoal: aGoal [
	self goals add: aGoal.
	^ aGoal
]

{ #category : #prerequisites }
GtLearningPath >> addPrerequisite: aPrerequisite [
	self prerequisites add: aPrerequisite.
	^ aPrerequisite
]

{ #category : #resources }
GtLearningPath >> addResource: aResource [
	self resources add: aResource.
	^ aResource
]

{ #category : #segments }
GtLearningPath >> addSegment: aSegment [
	self segments add: aSegment.
	^ aSegment
]

{ #category : #tags }
GtLearningPath >> addTag: aTag [
	self tags add: aTag.
	^ aTag
]

{ #category : #export }
GtLearningPath >> asDictionary [
	^ Dictionary new
		at: #title put: self title;
		at: #audience put: self audience;
		at: #problemStatement put: self problemStatement;
		at: #duration put: self duration;
		at: #goals put: self goals asArray;
		at: #prerequisites put: self prerequisites asArray;
		at: #segments put: self segments asArray;
		at: #resources put: self resources asArray;
		at: #assessments put: self assessments asArray;
		at: #tags put: self tags asArray;
		yourself
]

{ #category : #assessments }
GtLearningPath >> assessments [
	^ assessments ifNil: [ assessments := OrderedCollection new ]
]

{ #category : #assessments }
GtLearningPath >> assessments: aCollection [
	assessments := aCollection asOrderedCollection
]

{ #category : #accessing }
GtLearningPath >> audience [
	^ audience
]

{ #category : #accessing }
GtLearningPath >> audience: aValue [
	audience := aValue
]

{ #category : #printing }
GtLearningPath >> describeOn: aStream [
	aStream
		nextPutAll: self title;
		nextPutAll: ' (' , self audience , ')';
		lf;
		nextPutAll: self problemStatement;
		lf;
		nextPutAll: 'Segments: ';
		lf.
	self segments
		do: [ :each | 
			aStream
				nextPutAll: ' - ';
				nextPutAll: each;
				lf ]
]

{ #category : #accessing }
GtLearningPath >> duration [
	^ duration
]

{ #category : #accessing }
GtLearningPath >> duration: aValue [
	duration := aValue
]

{ #category : #examples }
GtLearningPath >> examplePureGitOnboarding [
	<gtExample>
	<return: #GtLearningPath>
	| path |
	path := GtLearningPath
			named: 'Pure Git Onboarding'
			audience: 'Newcomer'
			problem: 'I need to inspect a repository without touching the CLI'.

	path
		duration: 'half-day';
		addGoal: 'Open existing repositories with Pure Git';
		addGoal: 'Clone a remote and verify HEAD';
		addPrerequisite: 'GT 1.0+ with Git CLI configured';
		addSegment: 'Verify IceGitCliPlatform';
		addSegment: 'Wrap an on-disk repository';
		addSegment: 'Clone feenkcom/iceberg-git-cli';
		addResource: 'docs/pure-git/pure-git-tool-overview.dita';
		addAssessment: 'Submit a short repo-health report'.

	^ path
]

{ #category : #goals }
GtLearningPath >> goals [
	^ goals ifNil: [ goals := OrderedCollection new ]
]

{ #category : #goals }
GtLearningPath >> goals: aCollection [
	goals := aCollection asOrderedCollection
]

{ #category : #views }
GtLearningPath >> gtJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON';
		object: [ self asDictionary asGtJson ];
		view: #gtJsonObjectFor:context:
]

{ #category : #prerequisites }
GtLearningPath >> prerequisites [
	^ prerequisites ifNil: [ prerequisites := OrderedCollection new ]
]

{ #category : #prerequisites }
GtLearningPath >> prerequisites: aCollection [
	prerequisites := aCollection asOrderedCollection
]

{ #category : #accessing }
GtLearningPath >> problemStatement [
	^ problemStatement
]

{ #category : #accessing }
GtLearningPath >> problemStatement: aValue [
	problemStatement := aValue
]

{ #category : #resources }
GtLearningPath >> resources [
	^ resources ifNil: [ resources := OrderedCollection new ]
]

{ #category : #resources }
GtLearningPath >> resources: aCollection [
	resources := aCollection asOrderedCollection
]

{ #category : #segments }
GtLearningPath >> segments [
	^ segments ifNil: [ segments := OrderedCollection new ]
]

{ #category : #segments }
GtLearningPath >> segments: aCollection [
	segments := aCollection asOrderedCollection
]

{ #category : #tags }
GtLearningPath >> tags [
	^ tags ifNil: [ tags := OrderedCollection new ]
]

{ #category : #tags }
GtLearningPath >> tags: aCollection [
	tags := aCollection asOrderedCollection
]

{ #category : #accessing }
GtLearningPath >> title [
	^ title
]

{ #category : #accessing }
GtLearningPath >> title: aValue [
	title := aValue
]
