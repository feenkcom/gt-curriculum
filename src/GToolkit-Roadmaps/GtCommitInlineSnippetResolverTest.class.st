Class {
	#name : #GtCommitInlineSnippetResolverTest,
	#superclass : #TestCase,
	#category : #'GToolkit-Roadmaps-InlineSnippets-Tests'
}

{ #category : #tests }
GtCommitInlineSnippetResolverTest >> testRegisterIfPossibleRegistersResolverWhenRegistryAvailable [
	| registryClass registry |
	registryClass := Smalltalk
			at: #GtLepiterInlineSnippetResolverRegistry
			ifAbsent: [ ^ self skip ].
	(registryClass respondsTo: #default) ifFalse: [ ^ self skip ].

	registry := registryClass default.	"We don't know the internal protocol, but we can at least ensure it does not error."
	GtCommitInlineSnippetResolver registerIfPossible.

	self assert: registry notNil
]

{ #category : #tests }
GtCommitInlineSnippetResolverTest >> testResolveWithCommitAndCustomRepoSlug [
    | resolver inlineSnippet view labels texts |
    resolver := GtCommitInlineSnippetResolver new.
    inlineSnippet := GtCommitInlineSnippetStub withArguments: {
        'deadbeef'.
        'feenkcom/gtoolkit-roadmaps'
    }.
    view := resolver resolveInlineSnippet: inlineSnippet inContext: nil.

    labels := view children.
    self assert: labels size equals: 3.

    texts := labels collect: [ :each | each text ].
    self assert: (texts first) equals: 'deadbeef'.
    self assert: (texts second) equals: ' · '.
    self assert: (texts third) equals: 'feenkcom/gtoolkit-roadmaps'.

]

{ #category : #tests }
GtCommitInlineSnippetResolverTest >> testResolveWithCommitUsesDefaultRepoSlug [
    | resolver inlineSnippet view labels texts |
    resolver := GtCommitInlineSnippetResolver new.
    inlineSnippet := GtCommitInlineSnippetStub withArguments: { 'abcdef' }.
    view := resolver resolveInlineSnippet: inlineSnippet inContext: nil.

    "view is a BrHorizontalPane with 3 children: commit label, separator label, link"
    labels := view children.
    self assert: labels size equals: 3.

    texts := labels collect: [ :each | each text ].
    self assert: (texts first) equals: 'abcdef'.
    self assert: (texts second) equals: ' · '.
    self assert: (texts third) equals: 'feenkcom/gt-curriculum'.

]

{ #category : #tests }
GtCommitInlineSnippetResolverTest >> testResolveWithoutArgumentsShowsMissingView [
    | resolver inlineSnippet view |
    resolver := GtCommitInlineSnippetResolver new.
    inlineSnippet := GtCommitInlineSnippetStub withArguments: #().
    view := resolver resolveInlineSnippet: inlineSnippet inContext: nil.
    self assert: view class equals: BrLabel.
    self assert: view text equals: 'gtCommit snippet requires a SHA'.

]

{ #category : #tests }
GtCommitInlineSnippetResolverTest >> testSnippetName [
	| resolver |
	resolver := GtCommitInlineSnippetResolver new.
	self assert: resolver snippetName equals: 'gtCommit'
]
