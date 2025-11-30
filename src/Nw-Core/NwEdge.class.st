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
