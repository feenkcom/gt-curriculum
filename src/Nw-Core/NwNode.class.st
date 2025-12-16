"
Intent: Represent one topic (or “place”) in a narrative graph, including lightweight metadata
(id/type/title), optional content, and a context dictionary used for adaptation scoring.

Responsibilities:
* Hold stable identity for traversal (id).
* Provide descriptive metadata (type, title) and optional payload (content).
* Expose node context as a Dictionary for scoring/selection (context).
* Provide a readable print form for debugging/inspection (printOn:).

Collaborators
* {{gtClass:NwGraph}}: stores and retrieves nodes by id; provides traversal context (nodeAt:).
* {{gtClass:NwContext}}: scores a node by comparing NwContext parameters against this node’s context.
* {{gtClass:NwEdge}}: connects nodes and selects successors.
* {{gtClass:NwWalk}}: traverses node ids; depends on NwGraph/NwContext to choose/score paths.

Note: Node context is intentionally just a Dictionary (e.g., { #level->#beginner. #language->#en }).

"
Class {
	#name : #NwNode,
	#superclass : #Object,
	#instVars : [
		'id',
		'type',
		'title',
		'context',
		'content'
	],
	#category : #'Nw-Core'
}

{ #category : #accessing }
NwNode >> content [ ^ content
]

{ #category : #accessing }
NwNode >> content: aString [ content := aString
]

{ #category : #accessing }
NwNode >> context [ ^ context ifNil: [ Dictionary new ]
]

{ #category : #accessing }
NwNode >> context: aDict [ context := aDict
]

{ #category : #accessing }
NwNode >> id [ ^ id
]

{ #category : #accessing }
NwNode >> id: aString [ id := aString
]

{ #category : #printing }
NwNode >> printOn: s [
	super printOn: s.
	s nextPutAll: '('; nextPutAll: id asString; nextPut: $) 
]

{ #category : #accessing }
NwNode >> title [ ^ title
]

{ #category : #accessing }
NwNode >> title: aString [ title := aString
]

{ #category : #accessing }
NwNode >> type [ ^ type
]

{ #category : #accessing }
NwNode >> type: aSymbol [ type := aSymbol
]
