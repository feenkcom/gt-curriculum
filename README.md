# Readme
This repo serves as a holding place for Lepiter pages and source code for tutorials and exercises to support a curriculum for teaching moldable development. 
All material developed here will eventually be migrated to the Glamorous Toolkit book, as it stabilizes.
## Installation

```st
Metacello new
	repository: 'github://feenkcom/gt-curriculum:main/src';
	baseline: 'GtCurriculum';
	load.
#BaselineOfGtCurriculum asClass loadLepiter
```

## Surfacing roadmap traces inside GT
- `GtRoadmapTrace` (see `src/GtCurriculum/GtRoadmapTrace.class.st`) records a learner’s traversal: visited steps, optional notes, artifacts, and start/end times. It serializes to plain dictionaries, so traces can live inside Lepiter snippets or FedWiki JSON.
- To surface traces in Glamorous Toolkit, register a lightweight hook wherever roadmap steps are activated (e.g., `GtRoadmapView>>onStepActivated:`) and call `GtRoadmapTrace current recordVisitOf: step id withNote: userInput`.
- Expose the trace via a `gtViewTraceFor:` extension that consumes `#timelineItems` so every roadmap page (or teaching unit) can embed “how the path was actually traversed”.
- Because traces use `storeOn:`/`fromDictionary:`, you can paste the literal text from a Lepiter snippet back into a workspace to recreate the overlay or analytics.
