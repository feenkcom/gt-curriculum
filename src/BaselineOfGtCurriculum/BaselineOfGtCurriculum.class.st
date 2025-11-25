Class {
	#name : 'BaselineOfGtCurriculum',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGtCurriculum',
	#package : 'BaselineOfGtCurriculum'
}

{ #category : 'loading' }
BaselineOfGtCurriculum class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines copyWith: BaselineOfGToolkit
]

{ #category : 'loading' }
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

{ #category : 'baseline' }
BaselineOfGtCurriculum >> baseline: spec [
	" Do we need all this?
	^ spec
		for: #common
		do: [ spec
				baseline: 'Bloc'
					with: [ spec repository: 'github://feenkcom/Bloc:main/src' ];
				baseline: 'BlocPac'
					with: [ spec repository: 'github://feenkcom/bloc-pac:main/src' ];
				baseline: 'Brick'
					with: [ spec repository: 'github://feenkcom/Brick:main/src' ];
				baseline: 'GToolkit4Famix3'
					with: [ spec repository: 'github://feenkcom/gt4famix3:main/src' ];
				baseline: 'GToolkitPhlow'
					with: [ spec repository: 'github://feenkcom/gtoolkit-phlow:main/src' ];
				baseline: 'GtoolkitRoadmaps'
					with: [ spec repository: 'github://feenkcom/gtoolkit-roadmaps:main/src' ];
				baseline: 'GToolkitScenery'
					with: [ spec repository: 'github://feenkcom/gtoolkit-scenery:main/src' ];
				baseline: 'GToolkitFileUtility'
					with: [ spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
				baseline: 'GToolkitWebView'
					with: [ spec repository: 'github://feenkcom/gtoolkit-webview:main/src' ];
				baseline: 'LepiterEngineCore'
					with: [ spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'NeoJSON'
					with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ].
			spec
				baseline: 'JSParser'
				with: [ spec repository: 'github://j-brant/SmaCC' ].
			spec
				package: 'GtCurriculum'
					with: [ spec requires: #(Brick GtoolkitRoadmaps GToolkitScenery LepiterEngineCore) ];
				package: 'Federated-Wiki'
					with: [ spec
							requires: #(Bloc BlocPac Brick GToolkitPhlow GToolkitWebView LepiterEngineCore NeoJSON JSParser) ];
				package: 'Federated-Wiki-Java' with: [ spec requires: #(GToolkit4Famix3) ] ]"

	<baseline>
	^ spec
		for: #common
		do: [ spec
				package: 'GtCurriculum';
				package: 'Federated-Wiki';
				package: 'Federated-Wiki-Java' ]
]
