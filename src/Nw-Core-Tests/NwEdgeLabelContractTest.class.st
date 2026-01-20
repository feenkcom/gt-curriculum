Class {
	#name : 'NwEdgeLabelContractTest',
	#superclass : 'TestCase',
	#category : 'Nw-Core-Tests',
	#package : 'Nw-Core-Tests'
}

{ #category : 'helpers' }
NwEdgeLabelContractTest >> buildTinyGraph [
| g nIntro nDef nAlt nThm |
g := NwGraph new.

nIntro := (NwNode new
	id: 'T:Intro';
	type: #Section;
	title: 'Intro';
	context: (Dictionary newFrom: { #level->#beginner. #language->#en });
	yourself).

nDef := (NwNode new
	id: 'T:Def';
	type: #Definition;
	title: 'Def';
	context: (Dictionary newFrom: { #level->#beginner. #language->#en });
	yourself).

nAlt := (NwNode new
	id: 'T:Alt';
	type: #Section;
	title: 'Alt';
	context: (Dictionary newFrom: { #level->#beginner. #language->#en });
	yourself).

nThm := (NwNode new
	id: 'T:Thm';
	type: #Theorem;
	title: 'Thm';
	context: (Dictionary newFrom: { #level->#advanced. #language->#en });
	yourself).

{ nIntro. nDef. nAlt. nThm } do: [ :n | g addNode: n ].

"Semantic edge (must be ungrouped): Intro -> Def"
g addEdge: (NwEdge new
	fromId: 'T:Intro';
	toId: 'T:Def';
	typeSymbol: #semantic;
	flowRef: nil;
	transitionText: nil;
	yourself).

"Narrative flow F1: Intro -> Def -> Thm"
g addEdge: (NwEdge new
	fromId: 'T:Intro';
	toId: 'T:Def';
	typeSymbol: #narrative;
	flowRef: 'intro-defn-proof';
	transitionText: 'Now we introduce the definition.';
	yourself).

g addEdge: (NwEdge new
	fromId: 'T:Def';
	toId: 'T:Thm';
	typeSymbol: #narrative;
	flowRef: 'intro-defn-proof';
	transitionText: 'With the definition in place, state the theorem.';
	yourself).

"Narrative flow F2: Intro -> Alt"
g addEdge: (NwEdge new
	fromId: 'T:Intro';
	toId: 'T:Alt';
	typeSymbol: #narrative;
	flowRef: 'intro-alt';
	transitionText: 'Alternative entry: motivate by example first.';
	yourself).

^ g
]

{ #category : 'tests' }
NwEdgeLabelContractTest >> testEdgeApiSelectorsExist [
self assert: (NwEdge canUnderstand: #fromId:).
self assert: (NwEdge canUnderstand: #toId:).
self assert: (NwEdge canUnderstand: #typeSymbol:).
self assert: (NwEdge canUnderstand: #flowRef:).
self assert: (NwEdge canUnderstand: #transitionText:).

self assert: (NwNode canUnderstand: #id:).
self assert: (NwNode canUnderstand: #type:).
self assert: (NwNode canUnderstand: #title:).
self assert: (NwNode canUnderstand: #context:)
]

{ #category : 'tests' }
NwEdgeLabelContractTest >> testEdgeLabelInvariantsForFlowRef [
| g edges |
g := self buildTinyGraph.
edges := g edges.

edges do: [ :e |
    (e typeSymbol = #semantic) ifTrue: [
        self assert: e flowRef isNil ].
    (e typeSymbol = #narrative) ifTrue: [
        self assert: e flowRef notNil ] ]
]

{ #category : 'tests' }
NwEdgeLabelContractTest >> testInvalidEdgeConstructionIsRejected [
| e |

"Semantic edge must not have flowRef"
e := NwEdge new
  fromId: 'A';
  toId: 'B';
  typeSymbol: #semantic;
  flowRef: 'some-flow';
  yourself.

self
  should: [ e validateLabelContract ]
  raise: Error.

"Narrative edge must have flowRef"
e := NwEdge new
  fromId: 'A';
  toId: 'B';
  typeSymbol: #narrative;
  flowRef: nil;
  yourself.

self
  should: [ e validateLabelContract ]
  raise: Error.

]

{ #category : 'tests' }
NwEdgeLabelContractTest >> testInvalidEdgeConstructionTestIsNotAboutMissingSelectors [
	self
		deny: (NwEdge class canUnderstand: #from:to:typeSymbol:flowRef:transitionText:)
]

{ #category : 'tests' }
NwEdgeLabelContractTest >> testInvalidEdgesAreRejectedByValidation [
| e |
e := NwEdge new
	fromId: 'A';
	toId: 'B';
	typeSymbol: #semantic;
	flowRef: 'some-flow';
	yourself.

self should: [ e validateLabelContract ] raise: Error.

e := NwEdge new
	fromId: 'A';
	toId: 'B';
	typeSymbol: #narrative;
	flowRef: nil;
	yourself.

self should: [ e validateLabelContract ] raise: Error
]

{ #category : 'tests' }
NwEdgeLabelContractTest >> testNarrativeSuccessorsRespectFlowRef [
| g ctx succF1 succF2 |
g := self buildTinyGraph.
ctx := NwContext fromOrderedPairs: { #level->#beginner. #language->#en }.

succF1 := g narrativeSuccessorsOf: 'T:Intro' flowRef: 'intro-defn-proof' context: ctx.
succF2 := g narrativeSuccessorsOf: 'T:Intro' flowRef: 'intro-alt' context: ctx.

self assert: (succF1 includes: 'T:Def').
self deny:   (succF1 includes: 'T:Alt').

self assert: (succF2 includes: 'T:Alt').
self deny:   (succF2 includes: 'T:Def')
]

{ #category : 'tests' }
NwEdgeLabelContractTest >> testSemanticEdgesAreUngrouped [
| g semanticEdges |
g := self buildTinyGraph.

semanticEdges := g edges select: [ :e | e typeSymbol = #semantic ].

self assert: semanticEdges notEmpty.
self assert: (semanticEdges allSatisfy: [ :e | e flowRef isNil ])
]

{ #category : 'tests' }
NwEdgeLabelContractTest >> testSemanticNarrativeFlowRefInvariant [
| g edges semanticEdges narrativeEdges |
g := self buildTinyGraph.
edges := g edges.

semanticEdges := edges select: [ :e | e typeSymbol = #semantic ].
narrativeEdges := edges select: [ :e | e typeSymbol = #narrative ].

self assert: semanticEdges notEmpty.
self assert: narrativeEdges notEmpty.

self assert: (semanticEdges allSatisfy: [ :e | e flowRef isNil ]).
self assert: (narrativeEdges allSatisfy: [ :e | e flowRef notNil ])
]
