Class {
	#name : #GtRoadmapTrace,
	#superclass : #Object,
	#instVars : [
		'startTime',
		'endTime',
		'visitedSteps',
		'notes',
		'artifacts',
		'events'
	],
	#category : #'GtCurriculum-Paths'
}

{ #category : #examples }
GtRoadmapTrace class >> exampleTimelineItems [ 
	<gtExample>
	^ self exampleTrace timelineItems
]

{ #category : #examples }
GtRoadmapTrace class >> exampleTrace [
	<gtExample>
	| trace |
	trace := self new.
	trace
		recordVisitOf: 'Unit 1 – Learn the basics of GT'
			withNote: 'Watched the Inspector video.';
		recordVisitOf: 'Unit 2 – Start your own project'
			withNote: 'Cloned the template repo.'.
	trace endNow.
	^ trace
]

{ #category : #examples }
GtRoadmapTrace class >> exampleVisitWithMetadata [
	<gtExample>
	| trace |
	trace := self new.
	trace
		recordVisitOf: 'step-a'
		title: 'Step A'
		note: 'Captured data'
		artifact: 'snippet-1'
		timestamp: DateAndTime now.
	trace endNow.
	^ trace events last
]

{ #category : #'instance creation' }
GtRoadmapTrace class >> fromDictionary: aDictionary [
	^ self new
		startTime: (aDictionary at: #startTime ifAbsent: [ nil ]);
		endTime: (aDictionary at: #endTime ifAbsent: [ nil ]);
		visitedSteps: (aDictionary at: #visitedSteps ifAbsent: [ #() ]) asOrderedCollection;
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

{ #category : #'as yet unclassified' }
GtRoadmapTrace class >> parseDateAndTimeString: aString [
	[ | sanitized |
	^ [ DateAndTime fromString: aString ]
		on: Error
		do: [ sanitized := aString copyReplaceAll: 'T' with: ' '.
			[ DateAndTime readFrom: sanitized readStream ] on: Error do: [ nil ] ] ]
]

{ #category : #private }
GtRoadmapTrace >> addEventFromDictionary: anEventDictionary [
	self
		recordVisitOf: (anEventDictionary at: #stepId)
		title: (anEventDictionary at: #title ifAbsent: [ nil ])
		note: (anEventDictionary at: #note ifAbsent: [ nil ])
		artifact: (anEventDictionary at: #artifact ifAbsent: [ nil ])
		timestamp: (self class
				parseDateAndTimeString: (anEventDictionary at: #timestamp ifAbsent: [ nil ]))
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

{ #category : #'as yet unclassified' }
GtRoadmapTrace >> events [
	^ events
]

{ #category : #'as yet unclassified' }
GtRoadmapTrace >> events: aCollection [
	events := aCollection asOrderedCollection
]

{ #category : #'as yet unclassified' }
GtRoadmapTrace >> gtJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON';
		object: [ self asDictionary asGtJson ];
		view: #gtJsonObjectFor:context:
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
GtRoadmapTrace >> recordVisitOf: aStepId title: aTitle note: aNote artifact: anArtifact timestamp: aDateAndTime [
	| timestamp event |
	timestamp := aDateAndTime ifNil: [ DateAndTime now ].
	self visitedSteps add: aStepId.
	aNote ifNotNil: [ self notes at: aStepId put: aNote ].
	anArtifact ifNotNil: [ self artifacts at: aStepId put: anArtifact ].
	event := Dictionary new
			at: #stepId put: aStepId;
			at: #title put: (aTitle ifNil: [ aStepId ]);
			at: #note put: aNote;
			at: #artifact put: anArtifact;
			at: #timestamp put: timestamp;
			yourself.
	self events add: event.
	^ event
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

	^ self events
		collectWithIndex: [ :event :index | 
			Dictionary new
				at: #order put: index;
				at: #stepId put: (event at: #stepId);
				at: #title put: (event at: #title ifAbsent: [ event at: #stepId ]);
				at: #note put: (event at: #note ifAbsent: [ '' ]);
				at: #artifact put: (event at: #artifact ifAbsent: [ nil ]);
				at: #timestamp put: (event at: #timestamp ifAbsent: [ nil ]);
				yourself ]
]

{ #category : #accessing }
GtRoadmapTrace >> visitedSteps [
	^ visitedSteps
]

{ #category : #accessing }
GtRoadmapTrace >> visitedSteps: aCollection [
	visitedSteps := aCollection asOrderedCollection
]
