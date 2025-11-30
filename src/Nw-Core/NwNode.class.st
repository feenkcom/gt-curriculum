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
