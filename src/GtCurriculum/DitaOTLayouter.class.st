Class {
	#name : #DitaOTLayouter,
	#superclass : #Object,
	#category : #'GtCurriculum-Layouter'
}

{ #category : #config }
DitaOTLayouter >> defaultParams [
	"Site-wide defaults; extend/override per subclass or per call."

	^ {#args -> #()} asDictionary
]

{ #category : #convenience }
DitaOTLayouter >> normalize: aTopicGraph [
	"Convert our internal topic graph into a DITA-OT friendly input (map + topics).
	 Stub for now; adapt to your graph structure."

	^ aTopicGraph
]

{ #category : #rendering }
DitaOTLayouter >> render: aTopicGraph [
	"Here we would hand off to the DITA-OT pipeline. For now, we simulate the call
	 by returning a small command spec that a runner could execute."

	^ {#transformId -> self toolkitTransformId.
		#inputs -> (self normalize: aTopicGraph).
		#params -> self defaultParams} asDictionary
]

{ #category : #config }
DitaOTLayouter >> toolkitTransformId [
	"Return the DITA-OT transform id this layouter targets. Subclasses override."

	self subclassResponsibility
]
