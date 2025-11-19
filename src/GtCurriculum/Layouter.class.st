Class {
	#name : 'Layouter',
	#superclass : 'Object',
	#category : 'GtCurriculum-Layouter',
	#package : 'GtCurriculum',
	#tag : 'Layouter'
}

{ #category : 'examples' }
Layouter class >> exampleMotivationSingleSnippet [
	<gtExample>
	| text |
	text := Layouter new singleSnippetListFrom: #(
		'You have a legacy software system and have questions about the source code and the runtime.'
		'You want to explore the API of an external software system.'
		'You have massive amounts of log data that you want to analyze.'
		'You are building a novel application, and need a way to explore different ways of modeling the domain.'
	).
	self assert: (text includesSubstring: '- You have a legacy software system').
	^ text

]

{ #category : 'examples' }
Layouter class >> exampleRenderSpecs [
	<gtExample>
	| html pdf spec |
	html := Layouter for: #html5.
	pdf := Layouter for: #pdf2.
	spec := {#map -> #MyMap.
			#topics -> #(#Concept1 #Task2 #Ref3)} asDictionary.
	^ {#html5 -> (html render: spec).
		#pdf2 -> (pdf render: spec)} asDictionary
]

{ #category : 'instance creation' }
Layouter class >> for: aSymbol [
	"Factory selecting a concrete layouter by output keyword (e.g., #html5, #pdf2)."

	| map klass |
	map := Dictionary new
			at: #html5 put: DitaOTLayouterHTML5;
			at: #pdf2 put: DitaOTLayouterPDF2;
			yourself.
	klass := map
			at: aSymbol
			ifAbsent: [ self error: 'Unknown layout target: ' , aSymbol printString ].
	^ klass new
]

{ #category : 'rendering' }
Layouter >> render: aTopicGraph [
	"Abstract template: subclasses decide how to render a DITA topic graph."

	"NB: or a topic graph in general – render a graph"

	self subclassResponsibility
]

{ #category : 'helpers' }
Layouter >> singleSnippetListFrom: items [
	"Return a single text block with bullets, suitable for one Lepiter text snippet."

	| lines |
	lines := items collect: [ :each | '- ' , each ].
	^ String crlf join: lines
]
