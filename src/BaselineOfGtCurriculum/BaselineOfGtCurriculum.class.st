Class {
	#name : #BaselineOfGtCurriculum,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtCurriculum
}

{ #category : #loading }
BaselineOfGtCurriculum class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'gt-curriculum' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGtCurriculum >> baseline: spec [
	<baseline>
	^ spec
		for: #common
		do: [ spec
				package: 'GtCurriculum';
				package: 'Federated-Wiki' ]
]
