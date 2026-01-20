"
Intent: Represent an “adaptation context” (Λ) as an ordered set of key/value preferences.
Provide scoring primitives used to pick variants and rank candidate paths.

Responsibilities
* Store ordered context parameters (orderedParams) preserving priority (earlier = more important).
* Offer construction helpers:
   ** empty
   ** fromOrderedPairs:
   ** fromDictionaryPreserving:
* Provide scoring helpers for traversal:
   ** weightForNodeContext: (compare this context against a node’s context dictionary)
   ** averageWeightForPathNodes:in: (aggregate scoring across a candidate path)
   ** orderWeightForKey: (priority weighting derived from orderedParams position)
   
Collaborators
* {{gtClass:NwNode}}: supplies node context dictionary to be scored.
* {{gtClass:NwGraph}}: supplies node lookup by id for path scoring and variant selection.
* {{gtClass:NwWalk}}: uses averageWeightForPathNodes:in: as a secondary score/tiebreaker.
* {{gtClass:NwGraph}} (variant selection): calls weightForNodeContext: to choose best member of a variant group.

Note: The context is intentionally minimal and can be extended later (e.g., richer matching rules).
"
Class {
	#name : 'NwContext',
	#superclass : 'Object',
	#instVars : [
		'orderedParams'
	],
	#category : 'Nw-Core',
	#package : 'Nw-Core'
}

{ #category : 'instance creation' }
NwContext class >> empty [
	"Answer a context with no constraints.
    Useful when we just want a walk without any level/language filters."

	^ self new
]

{ #category : 'instance creation' }
NwContext class >> fromDictionaryPreserving: dict [
	"Fallback: best effort order = iteration order of dict (may vary)."
	^ self fromOrderedPairs: (dict associations asOrderedCollection)
]

{ #category : 'instance creation' }
NwContext class >> fromOrderedPairs: assocArray [
	"assocArray like: { #level->#beginner. #language->#en } in desired priority order."
	| c |
	c := self new.
	assocArray do: [ :assoc | c orderedParams add: assoc ].
	^ c
]

{ #category : 'scoring' }
NwContext >> averageWeightForPathNodes: nodeIds in: aGraph [
	| sum |
	nodeIds isEmpty ifTrue: [ ^ 0 ].
	sum := nodeIds sum: [ :nid | self weightForNodeContext: ((aGraph nodeAt: nid) ifNil: [ Dictionary new ]) context ].
	^ sum asFloat / nodeIds size asFloat
]

{ #category : 'init' }
NwContext >> initialize [ orderedParams := OrderedCollection new
]

{ #category : 'scoring' }
NwContext >> orderWeightForKey: aKey [
	| idx size |
	size := orderedParams size.
	idx := (orderedParams indexOf: (orderedParams detect: [ :a | a key = aKey ] ifNone: [ ^ 0 ])).
	^ size - idx + 1
]

{ #category : 'accessing' }
NwContext >> orderedParams [ ^ orderedParams
]

{ #category : 'scoring' }
NwContext >> weightForNodeContext: nodeCtx [
	"Listing 3: sum order weights of satisfied parameters; equality used as satisfaction."
	| total |
	total := 0.
	orderedParams doWithIndex: [ :assoc :i |
		| k v |
		k := assoc key. v := assoc value.
		(nodeCtx includesKey: k)
			ifTrue: [ (nodeCtx at: k) = v ifTrue: [ total := total + (self orderWeightForKey: k) ] ] ].
	^ total
]
