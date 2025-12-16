"
Intent: Represent a directed association between two node ids in a narrative graph, annotated
with traversal semantics (typeSymbol, flowRef) and optional narration (transitionText).

Responsibilities
* Define a directed link between node ids (fromId -> toId).
* Carry traversal classification (typeSymbol) such as #narrative.
* Carry flow partitioning (flowRef) so a walk follows a single narrative flow.
* Provide human-readable transition text (transitionText) for rendering/UX.
* Optionally carry an edge-specific context dictionary (context) for future adaptation rules.

Collaborators
* {{gtClass:NwGraph}}: owns edge collection; filters edges by fromId, typeSymbol, flowRef.
* {{gtClass:NwNode}}: edge endpoints refer to node ids; resolution happens via NwGraph nodeAt:.
* {{gtClass:NwWalk}}: uses NwGraph narrativeSuccessorsOf:flowRef:context: to follow edges.

Note: Edges target either concrete topic ids or variant group ids (e.g., 'V:Proof') that NwGraph resolves.
"
Class {
	#name : #NwEdge,
	#superclass : #Object,
	#instVars : [
		'fromId',
		'toId',
		'typeSymbol',
		'flowRef',
		'transitionText',
		'context'
	],
	#category : #'Nw-Core'
}

{ #category : #import }
NwEdge class >> fromDictionary: d [
	| e |
	e := self new.
	e fromId: (d at: #from ifAbsent: [ d at: 'from' ]).
	e toId: (d at: #to ifAbsent: [ d at: 'to' ]).
	e typeSymbol: ((d at: #type ifAbsent: [ d at: 'type' ]) asString asLowercase asSymbol).
	e flowRef: (d at: #flowRef ifAbsent: [ d at: 'flowRef' ifAbsent: [ nil ] ]).
	e transitionText: (d at: #transitionText ifAbsent: [ d at: 'transitionText' ifAbsent: [ nil ] ]).
	e context: (d at: #context ifAbsent: [ d at: 'context' ifAbsent: [ Dictionary new ] ]) asDictionary.
	^ e
]

{ #category : #accessing }
NwEdge >> context [ ^ context ifNil: [ Dictionary new ]
]

{ #category : #accessing }
NwEdge >> context: d [ context := d
]

{ #category : #accessing }
NwEdge >> flowRef [ ^ flowRef
]

{ #category : #accessing }
NwEdge >> flowRef: s [ flowRef := s
]

{ #category : #accessing }
NwEdge >> fromId [ ^ fromId
]

{ #category : #accessing }
NwEdge >> fromId: s [ fromId := s
]

{ #category : #accessing }
NwEdge >> toId [ ^ toId
]

{ #category : #accessing }
NwEdge >> toId: s [ toId := s
]

{ #category : #accessing }
NwEdge >> transitionText [ ^ transitionText ifNil: [ '' ]
]

{ #category : #accessing }
NwEdge >> transitionText: s [ transitionText := s
]

{ #category : #accessing }
NwEdge >> typeSymbol [ ^ typeSymbol
]

{ #category : #accessing }
NwEdge >> typeSymbol: sym [ typeSymbol := sym
]
