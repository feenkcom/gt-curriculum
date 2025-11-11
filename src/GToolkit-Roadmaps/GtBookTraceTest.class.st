Class {
	#name : #GtBookTraceTest,
	#superclass : #TestCase,
	#category : #'GToolkit-Roadmaps-Tests'
}

{ #category : #tests }
GtBookTraceTest >> testRecordVisitAcceptsStringStep [
	| trace entry |
	trace := GtBookTrace new.
	trace recordVisitOfPage: Object new fromStep: 'custom-step'.
	entry := trace entries last.
	self assert: entry roadmapStepId equals: 'custom-step'
]

{ #category : #tests }
GtBookTraceTest >> testRecordVisitFallsBackWhenPageMissing [
	| trace entry |
	trace := GtBookTrace new.
	trace recordVisitOfPage: nil fromStep: nil.
	entry := trace entries last.
	self assert: entry pageTitle equals: 'Unknown page'.
	self assert: entry pageUid size equals: UUID new asString size
]
