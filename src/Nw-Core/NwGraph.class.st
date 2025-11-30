Class {
	#name : #NwGraph,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges',
		'variantGroups'
	],
	#category : #'Nw-Core'
}

{ #category : #import }
NwGraph class >> fromFixtureDictionary: dict [
	| g |
	g := self new.
	(dict at: #topics ifAbsent: [ dict at: 'topics' ])
		do: [ :td | g addNode: (NwNode fromDictionary: td asDictionary) ].
	(dict
		at: #variantGroups
		ifAbsent: [ dict at: 'variantGroups' ifAbsent: [ #() ] ])
		do: [ :vg | 
			g
				addVariantGroup: (vg at: #id ifAbsent: [ vg at: 'id' ])
				members: ((vg at: #members ifAbsent: [ vg at: 'members' ])
						collect: [ :m | m at: #topic ifAbsent: [ m at: 'topic' ] ]) ].
	(dict at: #associations ifAbsent: [ dict at: 'associations' ])
		do: [ :ed | g addEdge: (NwEdge fromDictionary: ed asDictionary) ].
	^ g
]

{ #category : #import }
NwGraph class >> fromFixtureFile: aFileReference [
	| json |
	json := aFileReference contents.
	^ self fromFixtureJSON: json
]

{ #category : #import }
NwGraph class >> fromFixtureJSON: jsonString [
	| neo dict |
	neo := Smalltalk at: #NeoJSONReader ifAbsent: [ nil ].
	neo ifNil: [ self error: 'NeoJSONReader not available' ].
	dict := neo fromString: jsonString.
	^ self fromFixtureDictionary: dict
]

{ #category : #building }
NwGraph >> addEdge: anEdge [
	edges add: anEdge
]

{ #category : #building }
NwGraph >> addNode: aNode [
	nodes at: aNode id put: aNode
]

{ #category : #building }
NwGraph >> addVariantGroup: groupId members: memberIds [
	variantGroups at: groupId put: memberIds asOrderedCollection
]

{ #category : #selection }
NwGraph >> chooseVariantForGroup: groupId context: ctx [
	| members best bestScore |
	members := variantGroups at: groupId ifAbsent: [ ^ nil ].
	best := nil.
	bestScore := -1.
	members
		do: [ :topicId | 
			| n score |
			n := self nodeAt: topicId.
			n
				ifNotNil: [ score := ctx weightForNodeContext: n context.
					score > bestScore
						ifTrue: [ best := topicId.
							bestScore := score ] ] ].
	^ best
]

{ #category : #query }
NwGraph >> edgesFrom: nodeId [
	^ edges select: [ :e | e fromId = nodeId ]
]

{ #category : #initialization }
NwGraph >> initialize [
	super initialize.
	nodes := Dictionary new.
	edges := OrderedCollection new.
	variantGroups := Dictionary new
]

{ #category : #query }
NwGraph >> narrativeSuccessorsOf: nodeId flowRef: aFlowRef context: ctx [
	"Return successor nodeIds following narrative edges of the same flowRef.
	Resolve variant-group targets (ids beginning with 'V:') by picking best
	member for ctx."

	| outs |
	outs := (self edgesFrom: nodeId)
			select: [ :e | e typeSymbol = #narrative and: [ e flowRef = aFlowRef ] ].
	^ (outs
		collect: [ :e | 
			| toId |
			toId := e toId.
			(toId beginsWith: 'V:')
				ifTrue: [ self chooseVariantForGroup: toId context: ctx ]
				ifFalse: [ toId ] ]) reject: [ :nid | nid isNil ]
]

{ #category : #query }
NwGraph >> nodeAt: nodeId [
	^ nodes at: nodeId ifAbsent: [ nil ]
]

{ #category : #accessing }
NwGraph >> nodeIds [
	"Return all node ids."
	^ self nodes keys asArray
]

{ #category : #accessing }
NwGraph >> nodes [
	"Access the internal node dictionary."
	^ nodes ifNil: [ nodes := Dictionary new ]
]

{ #category : #accessing }
NwGraph >> size [
	^ self nodes size
]
