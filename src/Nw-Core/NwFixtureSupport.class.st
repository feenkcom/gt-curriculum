Class {
	#name : #NwFixtureSupport,
	#superclass : #Object,
	#category : #'Nw-Core-FixtureSupport'
}

{ #category : #fixture }
NwFixtureSupport class >> fixture [
	"Return the last stored fixture, or nil."
	^ Smalltalk globals at: #NwFixture ifAbsent: [ nil ].

]

{ #category : #fixture }
NwFixtureSupport class >> fixture: anObject [
	"Store fixture globally so it survives across snippets."
	Smalltalk globals at: #NwFixture put: anObject.
	^ anObject.

]

{ #category : #fixture }
NwFixtureSupport class >> normalizeAssociation: a [
	"Accept either a Dictionary (already fine) or an Array of Associations.
	Return a Dictionary or nil."
	a isNil ifTrue: [ ^ nil ].
	(a class == Dictionary) ifTrue: [ ^ a ].
	(a respondsTo: #asDictionary) ifTrue: [ ^ a asDictionary ].
	^ nil.

]

{ #category : #fixture }
NwFixtureSupport class >> normalizeAssociationsArray [
	"Return associations as an Array of Dictionaries (no nils), best-effort."
	| f assocs |
	f := self fixture.
	assocs := self safeAtEither: #associations or: 'associations' in: f.
	assocs isNil ifTrue: [ ^ #() ].
	^ (assocs collect: [ :each | self normalizeAssociation: each ])
		reject: #isNil.

]

{ #category : #fixture }
NwFixtureSupport class >> report [
	"Never signals. Always returns a Dictionary report."
	| r f assocs nodes edges vgs |

	r := Dictionary new.
	f := self fixture.

	r at: #fixtureClass put: (f isNil ifTrue: [ #nil ] ifFalse: [ f class name asSymbol ]).
	r at: #fixtureIsNil put: f isNil.

	assocs := self safeAtEither: #associations or: 'associations' in: f.
	r at: #associationsClass put: (assocs isNil ifTrue: [ #nil ] ifFalse: [ assocs class name asSymbol ]).
	r at: #associationsSize put: (assocs isNil ifTrue: [ 0 ] ifFalse: [ assocs size ]).
	r at: #associationsHasNil put: (assocs isNil ifTrue: [ false ] ifFalse: [ assocs anySatisfy: #isNil ]).

	nodes := self safeAtEither: #nodes or: 'nodes' in: f.
	edges := self safeAtEither: #edges or: 'edges' in: f.
	vgs   := self safeAtEither: #variantGroups or: 'variantGroups' in: f.

	r at: #nodesClass put: (nodes isNil ifTrue: [ #nil ] ifFalse: [ nodes class name asSymbol ]).
	r at: #nodesSize  put: (nodes isNil ifTrue: [ 0 ] ifFalse: [ nodes size ]).
	r at: #edgesClass put: (edges isNil ifTrue: [ #nil ] ifFalse: [ edges class name asSymbol ]).
	r at: #edgesSize  put: (edges isNil ifTrue: [ 0 ] ifFalse: [ edges size ]).
	r at: #variantGroupsClass put: (vgs isNil ifTrue: [ #nil ] ifFalse: [ vgs class name asSymbol ]).
	r at: #variantGroupsSize  put: (vgs isNil ifTrue: [ 0 ] ifFalse: [ vgs size ]).

	^ r.

]

{ #category : #fixture }
NwFixtureSupport class >> safeAt: key in: dict [
	(dict isNil or: [ dict class ~~ Dictionary ])
		ifTrue: [ ^ nil ].
	^ dict at: key ifAbsent: [ nil ].

]

{ #category : #fixture }
NwFixtureSupport class >> safeAtEither: symKey or: stringKey in: dict [
	| v |
	v := self safeAt: symKey in: dict.
	v isNil ifFalse: [ ^ v ].
	^ self safeAt: stringKey in: dict.

]
