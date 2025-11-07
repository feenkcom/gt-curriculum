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
