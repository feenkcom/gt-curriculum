Class {
	#name : #GtRoadmapTrace,
	#superclass : #Object,
	#instVars : [
		'startTime',
		'endTime',
		'visitedSteps',
		'notes',
		'artifacts'
	],
	#category : #'GtCurriculum-Paths'
}

{ #category : #examples }
GtRoadmapTrace class >> exampleTrace [
	<gtExample>
	| trace |
	trace := GtRoadmapTrace new
			recordVisitOf: 'Unit 1 – Learn the basics of GT'
				withNote: 'Watched the Inspector video.';
			recordVisitOf: 'Unit 2 – Start your own project'
				withNote: 'Cloned the template repo.'.
	trace endNow.
	^ trace
]

{ #category : #'instance creation' }
GtRoadmapTrace class >> fromDictionary: aDictionary [
	^ self new
		startTime: (aDictionary at: #startTime ifAbsent: [ nil ]);
		endTime: (aDictionary at: #endTime ifAbsent: [ nil ]);
		visitedSteps: ((aDictionary at: #visitedSteps ifAbsent: [ #() ]) asOrderedCollection);
		notes: (aDictionary at: #notes ifAbsent: [ Dictionary new ]) asDictionary;
		artifacts: (aDictionary at: #artifacts ifAbsent: [ Dictionary new ]) asDictionary;
		yourself
]

{ #category : #'instance creation' }
GtRoadmapTrace class >> new [
	^ super new
		initialize;
		yourself
]

{ #category : #accessing }
GtRoadmapTrace >> artifacts [
	^ artifacts
]

{ #category : #accessing }
GtRoadmapTrace >> artifacts: aDictionary [
	artifacts := aDictionary
]

{ #category : #serialization }
GtRoadmapTrace >> asDictionary [
	^ Dictionary new
		at: #startTime put: self startTime;
		at: #endTime put: self endTime;
		at: #visitedSteps put: self visitedSteps asArray;
		at: #notes put: self notes copy;
		at: #artifacts put: self artifacts copy;
		yourself
]

{ #category : #recording }
GtRoadmapTrace >> endNow [
	self endTime: DateAndTime now
]

{ #category : #accessing }
GtRoadmapTrace >> endTime [
	^ endTime
]

{ #category : #accessing }
GtRoadmapTrace >> endTime: aDateAndTime [
	endTime := aDateAndTime
]

{ #category : #initialization }
GtRoadmapTrace >> initialize [
	super initialize.
	startTime := DateAndTime now.
	visitedSteps := OrderedCollection new.
	notes := Dictionary new.
	artifacts := Dictionary new.
]

{ #category : #accessing }
GtRoadmapTrace >> notes [
	^ notes
]

{ #category : #accessing }
GtRoadmapTrace >> notes: aDictionary [
	notes := aDictionary
]

{ #category : #printing }
GtRoadmapTrace >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' start: ';
		print: self startTime;
		nextPutAll: ' steps: ';
		print: self visitedSteps size
]

{ #category : #recording }
GtRoadmapTrace >> recordVisitOf: aStepId [
	self visitedSteps add: aStepId.
	^ aStepId
]

{ #category : #recording }
GtRoadmapTrace >> recordVisitOf: aStepId withArtifact: anObject [
	self recordVisitOf: aStepId.
	self artifacts at: aStepId put: anObject.
	^ anObject
]

{ #category : #recording }
GtRoadmapTrace >> recordVisitOf: aStepId withNote: aString [
	self recordVisitOf: aStepId.
	aString ifNotNil: [ self notes at: aStepId put: aString ].
	^ aString
]

{ #category : #accessing }
GtRoadmapTrace >> startTime [
	^ startTime
]

{ #category : #accessing }
GtRoadmapTrace >> startTime: aDateAndTime [
	startTime := aDateAndTime
]

{ #category : #serialization }
GtRoadmapTrace >> storeOn: aStream [
	aStream
		nextPutAll: 'GtRoadmapTrace fromDictionary: ';
		nextPutAll: self asDictionary storeString
]

{ #category : #ui }
GtRoadmapTrace >> timelineItems [
	"Helper for Spec/GT views"
	^ self visitedSteps
		collectWithIndex: [ :step :index | 
			{ 
				#order -> index.
				#step -> step.
				#note -> (self notes at: step ifAbsent: [ '' ]).
			} asDictionary ]
]

{ #category : #accessing }
GtRoadmapTrace >> visitedSteps [
	^ visitedSteps
]

{ #category : #accessing }
GtRoadmapTrace >> visitedSteps: aCollection [
	visitedSteps := aCollection asOrderedCollection
]
