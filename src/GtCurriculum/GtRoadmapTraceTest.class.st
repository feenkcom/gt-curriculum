Class {
	#name : 'GtRoadmapTraceTest',
	#superclass : 'TestCase',
	#category : 'GtCurriculum-Tests',
	#package : 'GtCurriculum',
	#tag : 'Tests'
}

{ #category : 'tests' }
GtRoadmapTraceTest >> testFromDictionaryNormalizesDates [
	| rawTrace trace firstEvent |
	rawTrace := Dictionary new
			at: #startTime put: '2025-11-10T12:00:00+01:00';
			at: #endTime put: '2025-11-10T12:05:00+01:00';
			at: #events
				put: {Dictionary new
							at: #stepId put: 'step-1';
							at: #note put: 'first visit';
							at: #timestamp put: '2025-11-10T12:01:00+01:00';
							yourself};
			yourself.
	trace := GtRoadmapTrace fromDictionary: rawTrace.
	self assert: trace startTime class equals: DateAndTime.
	self assert: trace endTime class equals: DateAndTime.
	firstEvent := trace events first.
	self assert: (firstEvent at: #timestamp) class equals: DateAndTime
]

{ #category : 'tests' }
GtRoadmapTraceTest >> testRecordVisitPreservesHistory [
	| trace matchingEvents |
	trace := GtRoadmapTrace new.
	trace recordVisitOf: 'step-42' withNote: 'first note'.
	trace recordVisitOf: 'step-42' withNote: 'second note'.
	matchingEvents := trace events
			select: [ :each | (each at: #stepId) = 'step-42' ].
	self assert: matchingEvents size equals: 2.
	self assert: (matchingEvents first at: #note) equals: 'first note'.
	self assert: (matchingEvents second at: #note) equals: 'second note'.
	self assert: (trace notes at: 'step-42') equals: 'second note'
]

{ #category : 'tests' }
GtRoadmapTraceTest >> testTimelineItemsExposeStepMetadata [
	| trace timeline |
	trace := GtRoadmapTrace new.
	trace
		recordVisitOf: 'step-a'
		title: 'Step A'
		note: 'Captured data'
		artifact: 'snippet-1'
		timestamp: (DateAndTime
				year: 2025
				month: 11
				day: 10
				hour: 12
				minute: 0
				second: 0).
	timeline := trace timelineItems.
	self assert: timeline size equals: 1.
	self assert: (timeline first at: #stepId) equals: 'step-a'.
	self assert: (timeline first at: #title) equals: 'Step A'.
	self assert: (timeline first at: #note) equals: 'Captured data'.
	self assert: (timeline first at: #artifact) equals: 'snippet-1'.
	self assert: (timeline first includesKey: #timestamp)
]
