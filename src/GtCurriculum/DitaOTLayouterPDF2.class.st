Class {
	#name : #DitaOTLayouterPDF2,
	#superclass : #DitaOTLayouter,
	#category : #'GtCurriculum-Layouter'
}

{ #category : #examples }
DitaOTLayouterPDF2 class >> exampleTransformId [
	<gtExample>
	^ DitaOTLayouterPDF2 new toolkitTransformId
]

{ #category : #config }
DitaOTLayouterPDF2 >> defaultParams [
	^ super defaultParams copy
		at: #toc put: true;
		at: #index put: true;
		yourself
]

{ #category : #config }
DitaOTLayouterPDF2 >> toolkitTransformId [
	^ 'org.dita.pdf2'
]
