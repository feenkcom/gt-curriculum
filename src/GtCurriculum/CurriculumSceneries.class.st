"
Some alternative maps of the curriculum as sceneries
"
Class {
	#name : #CurriculumSceneries,
	#superclass : #Object,
	#category : #'GtCurriculum-Sceneries'
}

{ #category : #fixtures }
CurriculumSceneries class >> basicsNarrativeFixtureJSON [
"Fixture for the NwGraph used by NwWalk to represent the narrative
walk for #1. Learn the basics of Glamorous Toolkit.

This is a minimal, linear path that follows the high-level outline:

  Get started
    → What is GT?
    → Case study: explainable system
    → Moldable development
    → Lepiter live documentation
    → Side roads
    → Self assessment

Adjust node ids / titles / metadata to match your existing NwGraph
schema if needed."
^ '{
  "nodes": [
    { "id": "get-started",         "title": "Get started",                                       "kind": "section" },
    { "id": "what-is-gt",          "title": "What is Glamorous Toolkit?",                        "kind": "section" },
    { "id": "case-study",          "title": "Using a simple case study to create an explainable system", "kind": "section" },
    { "id": "moldable-dev",        "title": "What is moldable development?",                     "kind": "section" },
    { "id": "lepiter-live-docs",   "title": "Using Lepiter for live documentation",              "kind": "section" },
    { "id": "side-roads",          "title": "Side roads",                                        "kind": "section" },
    { "id": "self-assessment",     "title": "Self assessment",                                   "kind": "section" }
  ],
  "edges": [
    { "from": "get-started",       "to": "what-is-gt",        "type": "narrative", "flowRef": "gt-basics-1" },
    { "from": "what-is-gt",        "to": "case-study",        "type": "narrative", "flowRef": "gt-basics-1" },
    { "from": "case-study",        "to": "moldable-dev",      "type": "narrative", "flowRef": "gt-basics-1" },
    { "from": "moldable-dev",      "to": "lepiter-live-docs", "type": "narrative", "flowRef": "gt-basics-1" },
    { "from": "lepiter-live-docs", "to": "side-roads",        "type": "narrative", "flowRef": "gt-basics-1" },
    { "from": "side-roads",        "to": "self-assessment",   "type": "narrative", "flowRef": "gt-basics-1" }
  ]
}'
]

{ #category : #'narrative walks' }
CurriculumSceneries class >> basicsNarrativeGraph [
    "NwGraph for #1. Learn the basics of Glamorous Toolkit.
    Nodes are Orte; edges define the gt-basics-1 narrative flow."

    | g baseCtx nIntro nCase nMoldable nLepiter nSideRoads nSelfAssess |
    g := NwGraph new.

    baseCtx := Dictionary newFrom: {
        #level   -> #beginner.
        #language -> #en }.

    nIntro := (NwNode new
        id: 'GT:Intro';
        type: #Section;
        title: 'What is GT?';
        context: baseCtx copy;
        yourself).

    nCase := (NwNode new
        id: 'GT:Case';
        type: #CaseStudy;
        title: 'Case study: explainable system';
        context: baseCtx copy;
        yourself).

    nMoldable := (NwNode new
        id: 'GT:Moldable';
        type: #Concept;
        title: 'Moldable development';
        context: baseCtx copy;
        yourself).

    nLepiter := (NwNode new
        id: 'GT:Lepiter';
        type: #Tool;
        title: 'Lepiter live documentation';
        context: baseCtx copy;
        yourself).

    nSideRoads := (NwNode new
        id: 'GT:SideRoads';
        type: #SideRoad;
        title: 'Side roads: navigation, community, Smalltalk';
        context: baseCtx copy;
        yourself).

    nSelfAssess := (NwNode new
        id: 'GT:SelfAssess';
        type: #Checkpoint;
        title: 'Self assessment';
        context: baseCtx copy;
        yourself).

    { nIntro. nCase. nMoldable. nLepiter. nSideRoads. nSelfAssess }
        do: [ :n | g addNode: n ].

    g addEdge: (NwEdge new
        fromId: 'GT:Intro';
        toId:   'GT:Case';
        typeSymbol: #narrative;
        flowRef: 'gt-basics-1';
        transitionText: 'From definition of GT to a concrete case study.';
        yourself).

    g addEdge: (NwEdge new
        fromId: 'GT:Case';
        toId:   'GT:Moldable';
        typeSymbol: #narrative;
        flowRef: 'gt-basics-1';
        transitionText: 'Surface moldable development from the case.';
        yourself).

    g addEdge: (NwEdge new
        fromId: 'GT:Moldable';
        toId:   'GT:Lepiter';
        typeSymbol: #narrative;
        flowRef: 'gt-basics-1';
        transitionText: 'Show Lepiter as live documentation for exploration.';
        yourself).

    g addEdge: (NwEdge new
        fromId: 'GT:Lepiter';
        toId:   'GT:SideRoads';
        typeSymbol: #narrative;
        flowRef: 'gt-basics-1';
        transitionText: 'Offer optional side roads: book navigation, community, Smalltalk.';
        yourself).

    g addEdge: (NwEdge new
        fromId: 'GT:SideRoads';
        toId:   'GT:SelfAssess';
        typeSymbol: #narrative;
        flowRef: 'gt-basics-1';
        transitionText: 'Close the module with self-assessment.';
        yourself).

    ^ g

]

{ #category : #'narrative walks' }
CurriculumSceneries class >> gtBasicsNarrativeWalkWithNwWalk [
    <gtExample>
    "Narrative walk for #1. Learn the basics of GT,
    using NwWalk over the basics narrative graph.

    Inspect the result to see the ordered path of node ids."

    | graph context walk |
    graph := self basicsNarrativeGraph.

    "Minimal, unconstrained context — all nodes are eligible."
    context := NwContext empty.

    walk := NwWalk
        hybridTraversalIn: graph
        flowRef: 'gt-basics-1'
        context: context.

    ^ walk

]

{ #category : #scenery }
CurriculumSceneries >> basicsScenery [
	"NB: Generated by GtScenery>>#storeAsExampleMethod -- do not edit."

	<gtExample>
	<noTest>
	<storedScenery>
	<return: #GtScenery>
	| scenery item1 item2 item3 item4 item5 item6 item7 item8 item9 item10 item11 item12 item13 item14 item15 item16 item17 item18 item19 item20 item21 item22 item23 item24 item25 item26 item27 item28 |
	scenery := GtScenery new.
	item1 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new
					label: '# 1. Learn the basics of Glamorous Toolkit';
					weight: #bold;
					width: 265.4300231933594;
					backgroundColor: (Color
							r: 1.0
							g: 0.9012707722385142
							b: 0.9012707722385142
							alpha: 1.0)) asItem.
	item1 position: -246.775390625 @ 332.10496616363525.
	item1 extent: 265.4300231933594 @ 28.0.
	item2 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new
					label: 'What is GT';
					weight: #bold;
					width: 73.96601867675781;
					backgroundColor: (Color
							r: 0.9951124144672532
							g: 0.9794721407624634
							b: 0.9208211143695014
							alpha: 1.0)) asItem.
	item2 position: 208.65463256835938 @ 124.10496616363525.
	item2 extent: 73.96601867675781 @ 28.0.
	item3 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new
					label: 'Using a simple case study, how can GT be used to create an explainable system';
					weight: #bold;
					width: 265.4300231933594;
					backgroundColor: (Color
							r: 0.9951124144672532
							g: 0.9794721407624634
							b: 0.9208211143695014
							alpha: 1.0)) asItem.
	item3 position: 177.65463256835938 @ 326.10496616363525.
	item3 extent: 265.4300231933594 @ 46.0.
	item4 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new
					label: 'What is *moldable development*, and how does it support the creation of explainable system';
					weight: #bold;
					width: 302.9099493209014;
					backgroundColor: (Color
							r: 0.9951124144672532
							g: 0.9794721407624634
							b: 0.9208211143695014
							alpha: 1.0)) asItem.
	item4 position: 164.65463256835938 @ 464.10496616363525.
	item4 extent: 302.9099493209014 @ 46.0.
	item5 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new
					label: 'How to use Lepiter notebooks to create *live documentation* for your exploration';
					weight: #bold;
					width: 265.4300231933594;
					backgroundColor: (Color
							r: 0.9951124144672532
							g: 0.9794721407624634
							b: 0.9208211143695014
							alpha: 1.0)) asItem.
	item5 position: 165.65463256835938 @ 706.1049661636353.
	item5 extent: 265.4300231933594 @ 46.0.
	item6 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new
					label: 'Side roads';
					weight: #bold;
					width: 74.37200927734375;
					backgroundColor: (Color
							r: 0.8699902248289345
							g: 0.9755620723362659
							b: 0.9951124144672532
							alpha: 1.0)) asItem.
	item6 position: 44.654632568359375 @ 938.1049661636353.
	item6 extent: 74.37200927734375 @ 28.0.
	item7 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new label: 'Glamorous Toolkit') asItem.
	item7 position: 421.92350542805707 @ 30.95547125749897.
	item7 extent: 123.4000244140625 @ 28.0.
	item8 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new label: 'What is Glamorous Toolkit?')
					asItem.
	item8 position: 443.6021960801717 @ 88.37377128546801.
	item8 extent: 176.90803527832037 @ 28.000000000000014.
	item9 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'A short history of Glamorous Toolkit') asItem.
	item9 position: 448.3713516469599 @ 140.03685840030676.
	item9 extent: 231.62007141113287 @ 28.0.
	item10 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new label: 'Getting started with GT in 7''')
					asItem.
	item10 position: 452.9188758342197 @ 184.63823888234822.
	item10 extent: 182.1580200195313 @ 28.0.
	item11 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new label: 'How to install Glamorous Toolkit')
					asItem.
	item11 position: 406.6172154114924 @ 236.1485554224099.
	item11 extent: 210.90003967285162 @ 28.0.
	item12 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new label: 'Glamorous Toolkit as a case study')
					asItem.
	item12 position: 525.8890297529051 @ 290.9546372319475.
	item12 extent: 217.3400421142578 @ 28.0.
	item13 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'Working with a REST API: the GitHub case study') asItem.
	item13 position: 501.2374367362668 @ 353.3668393375428.
	item13 extent: 301.88604736328125 @ 28.0.
	item14 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'Developers spend most of their time figuring systems out') asItem.
	item14 position: 527.1535043627887 @ 410.53057856192106.
	item14 extent: 361.1620788574219 @ 28.0.
	item15 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'The Moldable Development Environment';
					width: 262.18202209472656) asItem.
	item15 position: 564.3092251552841 @ 469.0751305473392.
	item15 extent: 262.18202209472656 @ 28.0.
	item16 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'How to get started with Moldable Development';
					width: 299.8140869140625) asItem.
	item16 position: 563.7427897161374 @ 518.7346190728929.
	item16 extent: 299.8140869140625 @ 28.0.
	item17 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'Molding the environment';
					width: 166.29600524902344) asItem.
	item17 position: 569.5362964911126 @ 575.8044412690729.
	item17 extent: 166.29600524902344 @ 28.0.
	item18 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'What is the difference between Moldable Development and ...')
					asItem.
	item18 position: 412.5305160174539 @ 620.6797344765873.
	item18 extent: 387.048095703125 @ 28.0.
	item19 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'Lepiter';
					width: 54.12800598144531) asItem.
	item19 position: 521.1759280065464 @ 697.6485584726946.
	item19 extent: 54.12800598144531 @ 28.0.
	item20 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'A single starting point for scripting, linking and documenting')
					asItem.
	item20 position: 501.4691580787479 @ 748.6446761879774.
	item20 extent: 384.1920166015625 @ 28.0.
	item21 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new
					label: 'How to navigate the GT book';
					weight: #bold;
					width: 186.38604736328125;
					backgroundColor: (Color
							r: 0.8699902248289345
							g: 0.9755620723362659
							b: 0.9951124144672532
							alpha: 1.0)) asItem.
	item21 position: 335.0266418457031 @ 857.1049661636353.
	item21 extent: 186.38604736328125 @ 28.0.
	item22 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new
					label: 'How to engage with the GT community';
					weight: #bold;
					width: 247.48202514648438;
					backgroundColor: (Color
							r: 0.8699902248289345
							g: 0.9755620723362659
							b: 0.9951124144672532
							alpha: 1.0)) asItem.
	item22 position: 319.0266418457031 @ 980.1049661636353.
	item22 extent: 247.48202514648438 @ 28.0.
	item23 := scenery
			addSceneryItem: (GtSceneryMindMapNodeStencil new
					label: 'How to work with Smalltalk';
					weight: #bold;
					width: 181.19203186035156;
					backgroundColor: (Color
							r: 0.8699902248289345
							g: 0.9755620723362659
							b: 0.9951124144672532
							alpha: 1.0)) asItem.
	item23 position: 319.0266418457031 @ 1096.1049661636353.
	item23 extent: 181.19203186035156 @ 28.0.
	item24 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new label: 'About this book') asItem.
	item24 position: 646.9893807589289 @ 821.6178393927088.
	item24 extent: 107.38401794433594 @ 28.0.
	item25 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new label: 'How do I find my pages?') asItem.
	item25 position: 654.5074905003906 @ 877.5056851346579.
	item25 extent: 157.9800262451172 @ 28.0.
	item26 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new label: 'Topic Map') asItem.
	item26 position: 660.8330566721629 @ 927.2432762684637.
	item26 extent: 71.78201293945313 @ 28.0.
	item27 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'Engage with the community and contribute') asItem.
	item27 position: 657.0015004576867 @ 989.8075422571328.
	item27 extent: 276.29400634765625 @ 28.0.
	item28 := scenery
			addSceneryItem: (GtSceneryLePageTitleLabelStencil new
					label: 'A gentle introduction to Pharo Smalltalk') asItem.
	item28 position: 644.1737555799702 @ 1101.4411158848418.
	item28 extent: 258.03802490234375 @ 28.0.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item1
		to: item2.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item1
		to: item3.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item1
		to: item4.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item1
		to: item5.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item1
		to: item6.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item2
		to: item7.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item2
		to: item8.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item2
		to: item9.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item2
		to: item10.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item2
		to: item11.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item3
		to: item12.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item3
		to: item13.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item4
		to: item14.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item4
		to: item15.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item4
		to: item16.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item4
		to: item17.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item4
		to: item18.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item5
		to: item19.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item5
		to: item20.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item6
		to: item21.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item6
		to: item22.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item6
		to: item23.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item21
		to: item24.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item21
		to: item25.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item21
		to: item26.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item22
		to: item27.
	scenery
		addConnectionWithStencil: GtSceneryStraightArcStencil new
		from: item23
		to: item28.
	scenery storeStringMethodName: 'CurriculumSceneries>>#basicsScenery'.
	^ scenery
]
