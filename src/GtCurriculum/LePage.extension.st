Extension { #name : #LePage }

{ #category : #'*GtCurriculum' }
LePage >> gtBookTraceTitle [
	^ self title ifNil: [ super gtBookTraceTitle ]
]

{ #category : #'*GtCurriculum' }
LePage >> gtBookTraceUid [
	^ self uid asString
]
