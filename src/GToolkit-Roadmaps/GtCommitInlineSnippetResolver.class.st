Class {
	#name : #GtCommitInlineSnippetResolver,
	#superclass : #Object,
	#category : #'GToolkit-Roadmaps-InlineSnippets'
}

{ #category : #'gt-examples' }
GtCommitInlineSnippetResolver class >> gtExampleCommitViewCustomRepo [
    <gtExample>
    | resolver |
    resolver := self new.
    ^ resolver viewForCommit: 'abcdef1234567890' repoSlug: 'feenkcom/gtoolkit-roadmaps'

]

{ #category : #'gt-examples' }
GtCommitInlineSnippetResolver class >> gtExampleCommitViewDefaultRepo [
    <gtExample>
    | resolver |
    resolver := self new.
    ^ resolver viewForCommit: 'abcdef1234567890' repoSlug: 'feenkcom/gt-curriculum'

]

{ #category : #'gt-examples' }
GtCommitInlineSnippetResolver class >> gtExampleMissingCommitView [
    <gtExample>
    | resolver |
    resolver := self new.
    ^ resolver viewForMissingCommit

]

{ #category : #'gt-examples' }
GtCommitInlineSnippetResolver class >> gtExampleSnippetName [
    <gtExample>
    ^ self new snippetName

]

{ #category : #registration }
GtCommitInlineSnippetResolver class >> initialize [
	self registerIfPossible
]

{ #category : #registration }
GtCommitInlineSnippetResolver class >> registerIfPossible [
	(Smalltalk at: #GtLepiterInlineSnippetResolverRegistry ifAbsent: [ ^ self ])
		ifNotNil: [ :registryClass | 
			| registry |
			registry := (registryClass respondsTo: #default)
					ifTrue: [ registryClass default ]
					ifFalse: [ nil ].
			registry ifNotNil: [ registry registerResolver: self new ] ]
]

{ #category : #resolving }
GtCommitInlineSnippetResolver >> resolveInlineSnippet: anInlineSnippet inContext: aContext [
	| args commit repoSlug |
	args := (anInlineSnippet respondsTo: #arguments)
			ifTrue: [ anInlineSnippet arguments ]
			ifFalse: [ #() ].
	commit := args at: 1 ifAbsent: [ ^ self viewForMissingCommit ].
	repoSlug := args at: 2 ifAbsent: [ 'feenkcom/gt-curriculum' ].
	^ self viewForCommit: commit repoSlug: repoSlug
]

{ #category : #accessing }
GtCommitInlineSnippetResolver >> snippetName [
	^ 'gtCommit'
]

{ #category : #private }
GtCommitInlineSnippetResolver >> viewForCommit: aCommit repoSlug: aSlug [
	| url row |
	url := 'https://github.com/', aSlug, '/commit/', aCommit.
	row := BrHorizontalPane new
		hMatchParent;
		vFitContent.
	row addChild: (BrLabel new
		text: aCommit;
		aptitude: BrGlamorousLabelAptitude new bold;
		yourself).
	row addChild: (BrLabel new
		text: ' · ';
		yourself).
	row addChild: (BrLink new
		text: aSlug;
		action: [ Smalltalk ui openUrl: url ];
		yourself).
	^ row

]

{ #category : #private }
GtCommitInlineSnippetResolver >> viewForMissingCommit [
	^ BrLabel new
		text: 'gtCommit snippet requires a SHA';
		aptitude: (BrGlamorousLabelAptitude new foreground: Color red);
		yourself
]
