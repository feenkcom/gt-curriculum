"
The intended flow is:

  1. Clone the Java reference repo into a local `fedwiki-java/` directory via {{gtMethod:FwReferenceImplementation class>>repository}}.
  
  2. Use {{gtClass:GtSmaCCJavaImporter}} to build a **Java code model** of that repo ({{gtMethod:FwReferenceImplementation class>>model}}).
  
  3. Use that model inside GT (Mondrian, inspectors, queries) as your *ground truth* for what “canonical FedWiki behavior” is.

This gives you a direct way to ask, *“What does the Java ref impl actually do here?”* while sitting in Pharo/gt.

"
Class {
	#name : #FwReferenceImplementation,
	#superclass : #Object,
	#category : #'Federated-Wiki-Java-fedwiki-java'
}

{ #category : #examples }
FwReferenceImplementation class >> exampleModel [
	<gtExample>
	^ FwReferenceImplementation model
]

{ #category : #'model creation' }
FwReferenceImplementation class >> model [
	^ GtSmaCCJavaImporter new
		baseDirectory: FileLocator home / 'workspace' / 'fedwiki-java';
		buildJavaModel;
		model
]

{ #category : #accessing }
FwReferenceImplementation class >> repository [
	"git@github.com:jasonrclark/fedwiki-java.git"

	| baseDirectory |
	baseDirectory := FileLocator home / 'workspace' / 'fedwiki-java'.
	baseDirectory ensureDeleteAll.

	^ IceRepositoryCreator
		fromUrl: 'git@github.com:jasonrclark/fedwiki-java.git'
		to: baseDirectory
]
