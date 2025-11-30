Class {
	#name : #NwContext,
	#superclass : #Object,
	#instVars : [
		'orderedParams'
	],
	#category : #'Nw-Core'
}

{ #category : #'instance creation' }
NwContext class >> fromDictionaryPreserving: dict [
	"Fallback: best effort order = iteration order of dict (may vary)."
	^ self fromOrderedPairs: (dict associations asOrderedCollection)
]

{ #category : #'instance creation' }
NwContext class >> fromOrderedPairs: assocArray [
	"assocArray like: { #level->#beginner. #language->#en } in desired priority order."
	| c |
	c := self new.
	assocArray do: [ :assoc | c orderedParams add: assoc ].
	^ c
]

{ #category : #scoring }
NwContext >> averageWeightForPathNodes: nodeIds in: aGraph [
	| sum |
	nodeIds isEmpty ifTrue: [ ^ 0 ].
	sum := nodeIds sum: [ :nid | self weightForNodeContext: ((aGraph nodeAt: nid) ifNil: [ Dictionary new ]) context ].
	^ sum asFloat / nodeIds size asFloat
]

{ #category : #init }
NwContext >> initialize [ orderedParams := OrderedCollection new
]

{ #category : #scoring }
NwContext >> orderWeightForKey: aKey [
	| idx size |
	size := orderedParams size.
	idx := (orderedParams indexOf: (orderedParams detect: [ :a | a key = aKey ] ifNone: [ ^ 0 ])).
	^ size - idx + 1
]

{ #category : #accessing }
NwContext >> orderedParams [ ^ orderedParams
]

{ #category : #scoring }
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
