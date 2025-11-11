Class {
	#name : #GtBookTrace,
	#superclass : #Object,
	#instVars : [
		'id',
		'label',
		'startedAt',
		'finishedAt',
		'entries'
	],
	#classVars : [
		'Current'
	],
	#classInstVars : [
		'id',
		'label',
		'startedAt',
		'entries'
	],
	#category : #'GToolkit-Roadmaps-Traces'
}

{ #category : #accessing }
GtBookTrace class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #'as yet unclassified' }
GtBookTrace class >> exampleRecordVisitWithFallback [ 
	<gtExample>
	| trace |
	trace := self new.
	trace recordVisitOfPage: nil fromStep: nil.
	^ trace entries last asSerialized
]

{ #category : #accessing }
GtBookTrace class >> finishCurrent [
	Current ifNotNil: [ Current finishedAt: DateAndTime now ]
]

{ #category : #serialization }
GtBookTrace class >> fromSerialized: aDict [
	| trace entriesData finishedAtString |
	trace := self new.
	trace id: (UUID fromString: (aDict at: #id)).
	trace label: (aDict at: #label ifAbsent: [ 'My GT Book path' ]).
	trace startedAt: (DateAndTime fromString: (aDict at: #startedAt)).
	finishedAtString := aDict at: #finishedAt ifAbsent: [ nil ].
	finishedAtString isNil
		ifFalse: [ trace finishedAt: (DateAndTime fromString: finishedAtString) ].
	entriesData := aDict at: #entries ifAbsent: [ #() ].
	trace
		entries: (entriesData collect: [ :each | GtBookTraceEntry fromSerialized: each ]).
	^ trace
]

{ #category : #'as yet unclassified' }
GtBookTrace class >> initialize [
	super initialize.
	id := UUID new.
	label := 'My GT Book path'.
	startedAt := DateAndTime now.
	entries := OrderedCollection new
]

{ #category : #accessing }
GtBookTrace class >> resetCurrent [
	Current := nil
]

{ #category : #serialization }
GtBookTrace >> asSerialized [
	"Return a literal structure describing this trace."

	^ Dictionary
		newFrom: {#id -> id asString.
				#label -> label.
				#startedAt -> startedAt asString.
				#finishedAt -> (finishedAt ifNil: [ nil ]).
				#entries -> (entries collect: [ :e | e asSerialized ])}
]

{ #category : #accessing }
GtBookTrace >> entries [
	^ entries
]

{ #category : #accessing }
GtBookTrace >> entries: aCollection [
	entries := aCollection
]

{ #category : #accessing }
GtBookTrace >> finishedAt [
	^ finishedAt
]

{ #category : #accessing }
GtBookTrace >> finishedAt: aDateAndTime [
	finishedAt := aDateAndTime
]

{ #category : #'gt-views' }
GtBookTrace >> gtViewPathFor: aView [
	<gtView>
	^ aView columnedList
		title: 'My GT Book path';
		items: [ entries ];
		column: 'Time' text: [ :e | e timestamp printString ];
		column: 'Page' text: [ :e | e pageTitle ];
		column: 'Step' text: [ :e | e roadmapStepId ifNil: [ '' ] ]
]

{ #category : #accessing }
GtBookTrace >> id [
	^ id
]

{ #category : #accessing }
GtBookTrace >> id: anObject [
	id := anObject
]

{ #category : #initialization }
GtBookTrace >> initialize [
	super initialize.
	id := UUID new.
	label := 'My GT Book path'.
	startedAt := DateAndTime now.
	entries := OrderedCollection new
]

{ #category : #accessing }
GtBookTrace >> label [
	^ label
]

{ #category : #accessing }
GtBookTrace >> label: aString [
	label := aString
]

{ #category : #recording }
GtBookTrace >> recordVisitOfPage: aLePage [
	^ self recordVisitOfPage: aLePage fromStep: nil
]

{ #category : #recording }
GtBookTrace >> recordVisitOfPage: aLePage fromStep: aRoadmapStepOrNil [
	| entry |
	entry := GtBookTraceEntry new
			pageTitle: aLePage title;
			pageUid: aLePage uid asString;
			roadmapStepId: (aRoadmapStepOrNil ifNotNil: [ aRoadmapStepOrNil id ]);
			timestamp: DateAndTime now;
			yourself.
	entries add: entry
]

{ #category : #accessing }
GtBookTrace >> startedAt [
	^ startedAt
]

{ #category : #accessing }
GtBookTrace >> startedAt: aDateAndTime [
	startedAt := aDateAndTime
]

{ #category : #serialization }
GtBookTrace >> storeOn: aStream [
	"Print a Smalltalk expression that reconstructs this trace."

	aStream
		nextPutAll: 'GtBookTrace fromSerialized: ';
		nextPutAll: self asSerialized storeString
]
