"
Intent: Compute a narrative walk (a simple path, no repeats) through an NwGraph for a given flowRef,
using NwContext to resolve variants and to rank candidate paths.

Responsibilities
* Enumerate candidate simple paths constrained to a narrative flow:
   ** simplePathsFrom:in:flowRef:context:maxLen:
   ** simplePathsAnyStartIn:flowRef:context:maxLen:
   ** dfsFrom:current:in:flowRef:context:maxLen:results:
* Filter candidates against an existing partial walk (path:allowedAgainstExisting:).
* Select “best” next path segments:
   ** bestPathStartingAt:in:flowRef:context:existing:
   ** bestPathAnyStartIn:flowRef:context:existing:
* Produce a whole-walk traversal that stitches best segments until coverage is sufficient:
   ** hybridTraversalIn:flowRef:context:

Collaborators
* {{gtClass:NwGraph}}: provides nodeIds, size, and narrativeSuccessorsOf:flowRef:context: (incl. variant resolution).
* {{gtClass:NwContext}}: provides path scoring (averageWeightForPathNodes:in:) for ranking candidates.
* {{gtClass:NwNode}}: indirectly via node ids; used for context scoring.
* {{gtClass:NwEdge}}: indirectly via NwGraph successor queries; provides flowRef/typeSymbol.

Notes
* Current selection primarily optimizes path length, with context-score as a tie-breaker.
* Walk output is an Array of node ids (ordered).
"
Class {
	#name : #NwWalk,
	#superclass : #Object,
	#category : 'Nw-Core'
}

{ #category : #selection }
NwWalk class >> bestPathAnyStartIn: g flowRef: aFlowRef context: ctx existing: existing [
	| all candidates scored |
	all := self
			simplePathsAnyStartIn: g
			flowRef: aFlowRef
			context: ctx
			maxLen: nil.
	candidates := all
			select: [ :p | self path: p allowedAgainstExisting: existing ].
	scored := candidates
			collect: [ :p | 
				{p.
					p size.
					ctx averageWeightForPathNodes: p in: g} ].
	^ scored
		ifEmpty: [ nil ]
		ifNotEmpty: [ (scored
				asSortedCollection: [ :a :b | a second > b second or: [ a second = b second and: [ a third > b third ] ] ])
				first first ]
]

{ #category : #selection }
NwWalk class >> bestPathStartingAt: startId in: g flowRef: aFlowRef context: ctx existing: existing [
	| candidates scored |
	candidates := self
			simplePathsFrom: startId
			in: g
			flowRef: aFlowRef
			context: ctx
			maxLen: nil.
	candidates := candidates
			select: [ :p | self path: p allowedAgainstExisting: existing ].
	scored := candidates
			collect: [ :p | 
				{p.
					p size.
					ctx averageWeightForPathNodes: p in: g} ].
	^ scored
		ifEmpty: [ nil ]
		ifNotEmpty: [ (scored
				asSortedCollection: [ :a :b | a second > b second or: [ a second = b second and: [ a third > b third ] ] ])
				first first ]
]

{ #category : #enumeration }
NwWalk class >> dfsFrom: currentId current: prefix in: g flowRef: aFlowRef context: ctx maxLen: maxLen results: results [
	| succs |
	(maxLen notNil and: [ prefix size >= maxLen ]) ifTrue: [ ^ self ].
	succs := g
			narrativeSuccessorsOf: currentId
			flowRef: aFlowRef
			context: ctx.
	succs
		do: [ :nid | 
			(prefix includes: nid)
				ifTrue: [  "simple path => no repeats" ]
				ifFalse: [ | next |
					next := prefix copyWith: nid.
					results add: next.
					self
						dfsFrom: nid
						current: next
						in: g
						flowRef: aFlowRef
						context: ctx
						maxLen: maxLen
						results: results ] ]
]

{ #category : #examples }
NwWalk class >> exampleFixtureAdvanced [
	<gtExample>
	| file g ctx P |
	file := FileLocator workingDirectory / 'docs' / 'fixtures'
			/ 'wow-narrative-fixture.json'.
	file exists ifFalse: [ ^ '(fixture missing)' ].
	g := NwGraph fromFixtureFile: file.
	ctx := NwContext
			fromOrderedPairs: {#level -> #advanced.
					#language -> #en}.
	P := self
			hybridTraversalIn: g
			flowRef: 'intro-defn-proof'
			context: ctx.
	^ P
]

{ #category : #examples }
NwWalk class >> exampleFixtureBeginner [
	<gtExample>
	| file g ctx P |
	file := FileLocator workingDirectory / 'docs' / 'fixtures'
			/ 'wow-narrative-fixture.json'.
	file exists ifFalse: [ ^ '(fixture missing)' ].
	g := NwGraph fromFixtureFile: file.
	ctx := NwContext
			fromOrderedPairs: {#level -> #beginner.
					#language -> #en}.
	P := self
			hybridTraversalIn: g
			flowRef: 'intro-defn-proof'
			context: ctx.
	^ P
]

{ #category : #traversal }
NwWalk class >> hybridTraversalIn: g flowRef: aFlowRef context: ctx [
	| P n Pprime remaining |
	P := OrderedCollection new.
	[ g size <= P size ]
		whileFalse: [ n := P ifEmpty: [ nil ] ifNotEmpty: [ P last ].
			Pprime := n
					ifNil: [ self
							bestPathAnyStartIn: g
							flowRef: aFlowRef
							context: ctx
							existing: P ]
					ifNotNil: [ self
							bestPathStartingAt: n
							in: g
							flowRef: aFlowRef
							context: ctx
							existing: P ].
			Pprime ifNil: [ ^ P asArray ].
			(P isEmpty or: [ Pprime isEmpty ])
				ifTrue: [ P addAll: Pprime ]
				ifFalse: [ | overlap |
					overlap := 0.
					[ overlap < (P size min: Pprime size)
						and: [ (P copyFrom: P size - overlap to: P size)
								= (Pprime copyFrom: 1 to: overlap + 1) ] ]
						whileTrue: [ overlap := overlap + 1 ].
					overlap > 0
						ifTrue: [ P addAll: (Pprime copyFrom: overlap + 1 to: Pprime size) ]
						ifFalse: [ P addAll: Pprime ] ].
			remaining := g size - P asSet size.
			remaining <= 0 ifTrue: [ ^ P asArray ] ].
	^ P asArray
]

{ #category : #selection }
NwWalk class >> path: candidate allowedAgainstExisting: existing [
	"Allow if v2..vi not in existing, or prefix(cand) = suffix(existing)."

	| k j prefix |
	existing isEmpty ifTrue: [ ^ true ].
	candidate size <= 1 ifTrue: [ ^ true ].
	(candidate allButFirst anySatisfy: [ :nid | existing includes: nid ]) not
		ifTrue: [ ^ true ].

	k := existing size.
	j := (candidate size min: existing size) - 1.
	j <= 0 ifTrue: [ ^ true ].
	prefix := candidate copyFrom: 1 to: j.
	^ prefix = (existing copyFrom: k - j + 1 to: k)
]

{ #category : #enumeration }
NwWalk class >> simplePathsAnyStartIn: g flowRef: aFlowRef context: ctx maxLen: maxLen [
	| all |
	all := OrderedCollection new.
	g nodeIds
		do: [ :nid | 
			all
				addAll: (self
						simplePathsFrom: nid
						in: g
						flowRef: aFlowRef
						context: ctx
						maxLen: maxLen) ].
	^ all asArray
]

{ #category : #enumeration }
NwWalk class >> simplePathsFrom: startId in: g flowRef: aFlowRef context: ctx maxLen: maxLen [
	| results |
	results := OrderedCollection new.
	self
		dfsFrom: startId
		current: (OrderedCollection with: startId)
		in: g
		flowRef: aFlowRef
		context: ctx
		maxLen: maxLen
		results: results.
	^ results asArray
]
