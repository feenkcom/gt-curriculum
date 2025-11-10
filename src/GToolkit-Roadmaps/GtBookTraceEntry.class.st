Class {
	#name : #GtBookTraceEntry,
	#superclass : #Object,
	#instVars : [
		'pageTitle',
		'pageUid',
		'roadmapStepId',
		'timestamp'
	],
	#category : #'GToolkit-Roadmaps-Traces'
}

{ #category : #serialization }
GtBookTraceEntry class >> fromSerialized: aDict [
	^ self new
		pageTitle: (aDict at: #pageTitle ifAbsent: [ '' ]);
		pageUid: (aDict at: #pageUid ifAbsent: [ '' ]);
		roadmapStepId: (aDict at: #roadmapStepId ifAbsent: [ nil ]);
		timestamp: (DateAndTime fromString: (aDict at: #timestamp));
		yourself
]

{ #category : #serialization }
GtBookTraceEntry >> asSerialized [
	^ Dictionary
		newFrom: {#pageTitle -> pageTitle.
				#pageUid -> pageUid.
				#roadmapStepId -> roadmapStepId.
				#timestamp -> timestamp asString}
]

{ #category : #accessing }
GtBookTraceEntry >> pageTitle [
	^ pageTitle
]

{ #category : #accessing }
GtBookTraceEntry >> pageTitle: aString [
	pageTitle := aString
]

{ #category : #accessing }
GtBookTraceEntry >> pageUid [
	^ pageUid
]

{ #category : #accessing }
GtBookTraceEntry >> pageUid: aString [
    pageUid := aString

]

{ #category : #accessing }
GtBookTraceEntry >> roadmapStepId [
	^ roadmapStepId
]

{ #category : #accessing }
GtBookTraceEntry >> roadmapStepId: anObject [
	roadmapStepId := anObject
]

{ #category : #accessing }
GtBookTraceEntry >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GtBookTraceEntry >> timestamp: aDateAndTime [
	timestamp := aDateAndTime
]
