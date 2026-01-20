"
Intent: Hold a narrative graph consisting of nodes, edges, and variant-groups.
Provide query and traversal helpers used by narrative walk computation.

Responsibilities
* Manage node storage (Dictionary id -> NwNode).
* Manage edge storage (OrderedCollection of NwEdge).
* Manage variant groups (Dictionary groupId -> member nodeIds).
* Provide graph queries used by traversal:
   ** nodeAt:, nodeIds, size
   ** edgesFrom:
   ** narrativeSuccessorsOf:flowRef:context:
* Resolve variant-group targets during traversal by selecting the “best” member for a given NwContext.

Collaborators
* {{gtClass:NwNode}}: stored in nodes dictionary; provides per-node context for scoring.
* {{gtClass:NwEdge}}: stored in edges; provides from/to and traversal qualifiers (typeSymbol, flowRef).
* {{gtClass:NwContext}}: provides weightForNodeContext: used to select a variant member.
* {{gtClass:NwWalk}}: consumes narrativeSuccessorsOf:flowRef:context: as its successor function.

Notes
* Variant groups are addressed by ids starting with 'V:' and map to multiple topic ids.
* Import helpers exist for fixtures (fromFixtureDictionary:/JSON/file) to bootstrap example graphs.
"
Class {
	#name : 'NwGraph',
	#superclass : 'Object',
	#instVars : [
		'nodes',
		'edges',
		'variantGroups'
	],
	#category : 'Nw-Core',
	#package : 'Nw-Core'
}

{ #category : 'fixtures' }
NwGraph class >> fixtureDictionary [
	| d |
	d := Dictionary new.

	"TOPICS — Array of Dictionaries"
	d at: 'topics' put: {
		(Dictionary newFrom: {
			'id' -> 'n1'.
			'topic' -> 'Topic A'.
			'type' -> 'concept'.
		}).
		(Dictionary newFrom: {
			'id' -> 'n2'.
			'topic' -> 'Topic B'.
			'type' -> 'concept'.
		}).
	}.

	"EDGES — STRING keys, not symbols"
	d at: 'edges' put: {
		(Dictionary newFrom: {
			'from' -> 'n1'.
			'to'   -> 'n2'.
			'type' -> 'sequence'.
		}).
	}.

	"VARIANT GROUPS"
	d at: 'variantGroups' put: {
		(Dictionary newFrom: {
			'id' -> 'vg1'.
			'members' -> {
				(Dictionary newFrom: { 'topic' -> 'Topic A' }).
				(Dictionary newFrom: { 'topic' -> 'Topic B' }).
			}.
		}).
	}.

	"ASSOCIATIONS"
	d at: 'associations' put: {
		(Dictionary newFrom: {
			'source' -> 'Topic A'.
			'target' -> 'Topic B'.
			'type'   -> 'narrative'.
		}).
	}.

	^ d
]

{ #category : 'import' }
NwGraph class >> fromFixtureDictionary: dict [
	| g rawNodes rawEdges rawAssocs rawVgs titleToId |

	g := self new.

	"--- 1) NODES / TOPICS (accept nodes or topics) ---"
	rawNodes := dict at: #nodes ifAbsent: [
		dict at: 'nodes' ifAbsent: [
			dict at: #topics ifAbsent: [ dict at: 'topics' ifAbsent: [ #() ] ] ] ].

	rawNodes do: [ :td |
		| id title type ctx content nd |
		id := td at: #id ifAbsent: [ td at: 'id' ifAbsent: [ nil ] ].
		title := td at: #title ifAbsent: [
			td at: 'title' ifAbsent: [
				td at: #topic ifAbsent: [ td at: 'topic' ifAbsent: [ nil ] ] ] ].
		type := td at: #type ifAbsent: [ td at: 'type' ifAbsent: [ nil ] ].
		ctx := td at: #context ifAbsent: [ td at: 'context' ifAbsent: [ nil ] ].
		content := td at: #content ifAbsent: [ td at: 'content' ifAbsent: [ nil ] ].

		nd := Dictionary new.
		id ifNotNil: [ nd at: #id put: id ].
		title ifNotNil: [ nd at: #title put: title ].
		type ifNotNil: [ nd at: #type put: (type isString ifTrue: [ type asSymbol ] ifFalse: [ type ]) ].
		ctx ifNotNil: [ nd at: #context put: ctx ].
		content ifNotNil: [ nd at: #content put: content ].

		g addNode: (NwNode fromDictionary: nd)
	].

	"Build title->id index for resolving variantGroups + associations"
	titleToId := Dictionary new.
	g nodes valuesDo: [ :n |
		(n title notNil and: [ n id notNil ]) ifTrue: [
			titleToId at: n title put: n id ] ].

	"--- 2) VARIANT GROUPS (resolve member titles -> ids) ---"
	rawVgs := dict at: #variantGroups ifAbsent: [ dict at: 'variantGroups' ifAbsent: [ #() ] ].
	rawVgs do: [ :vg |
		| gid members memberIds |
		gid := vg at: #id ifAbsent: [ vg at: 'id' ].
		members := vg at: #members ifAbsent: [ vg at: 'members' ].
		memberIds := members collect: [ :m |
			| t |
			t := m at: #topic ifAbsent: [ m at: 'topic' ifAbsent: [
				m at: #title ifAbsent: [ m at: 'title' ifAbsent: [ nil ] ] ] ].
			titleToId at: t ifAbsent: [ t ] ].
		g addVariantGroup: gid members: memberIds
	].

	"--- 3) EDGES (prefer edges; fallback convert associations->edges) ---"
	rawEdges := dict at: #edges ifAbsent: [ dict at: 'edges' ifAbsent: [ nil ] ].
	rawAssocs := dict at: #associations ifAbsent: [ dict at: 'associations' ifAbsent: [ #() ] ].

	rawEdges notNil
		ifTrue: [
			rawEdges do: [ :ed | g addEdge: (NwEdge fromDictionary: ed asDictionary) ]
		]
		ifFalse: [
			rawAssocs do: [ :a |
				| src tgt typ flowRef ed |
				src := a at: #source ifAbsent: [ a at: 'source' ifAbsent: [ nil ] ].
				tgt := a at: #target ifAbsent: [ a at: 'target' ifAbsent: [ nil ] ].
				typ := a at: #type ifAbsent: [ a at: 'type' ifAbsent: [ 'narrative' ] ].
				flowRef := a at: #flowRef ifAbsent: [ a at: 'flowRef' ifAbsent: [ nil ] ].

				ed := Dictionary new.
				ed at: #from put: (titleToId at: src ifAbsent: [ src ]).
				ed at: #to   put: (titleToId at: tgt ifAbsent: [ tgt ]).
				ed at: #type put: typ.
				flowRef ifNotNil: [ ed at: #flowRef put: flowRef ].

				g addEdge: (NwEdge fromDictionary: ed)
			]
		].

	^ g
]

{ #category : 'import' }
NwGraph class >> fromFixtureFile: aFileReference [
	| json |
	json := aFileReference contents.
	^ self fromFixtureJSON: json
]

{ #category : 'import' }
NwGraph class >> fromFixtureJSON: jsonString [
	| neo dict |
	neo := Smalltalk at: #NeoJSONReader ifAbsent: [ nil ].
	neo ifNil: [ self error: 'NeoJSONReader not available' ].
	dict := neo fromString: jsonString.
	^ self fromFixtureDictionary: dict
]

{ #category : 'building' }
NwGraph >> addEdge: anEdge [
	edges add: anEdge
]

{ #category : 'building' }
NwGraph >> addNode: aNode [
	nodes at: aNode id put: aNode
]

{ #category : 'building' }
NwGraph >> addVariantGroup: groupId members: memberIds [
	variantGroups at: groupId put: memberIds asOrderedCollection
]

{ #category : 'selection' }
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

{ #category : 'accessing' }
NwGraph >> edges [
| result |
result := OrderedCollection new.
self nodeIds do: [ :id |
  result addAll: (self edgesFrom: id) ].
^ result
]

{ #category : 'query' }
NwGraph >> edgesFrom: nodeId [
	^ edges select: [ :e | e fromId = nodeId ]
]

{ #category : 'initialization' }
NwGraph >> initialize [
	super initialize.
	nodes := Dictionary new.
	edges := OrderedCollection new.
	variantGroups := Dictionary new
]

{ #category : 'query' }
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

{ #category : 'query' }
NwGraph >> nodeAt: nodeId [
	^ nodes at: nodeId ifAbsent: [ nil ]
]

{ #category : 'accessing' }
NwGraph >> nodeIds [
	"Return all node ids."
	^ self nodes keys asArray
]

{ #category : 'accessing' }
NwGraph >> nodes [
	"Access the internal node dictionary."
	^ nodes ifNil: [ nodes := Dictionary new ]
]

{ #category : 'accessing' }
NwGraph >> size [
	^ self nodes size
]
