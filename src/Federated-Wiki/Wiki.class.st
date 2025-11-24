Class {
	#name : #Wiki,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'Federated-Wiki-localhost'
}

{ #category : #accessing }
Wiki class >> assets [
	^ '/Users/rgb/.wiki/localhost/assets'
]

{ #category : #accessing }
Wiki class >> client [
	^ '/usr/local/lib/node_modules/wiki/node_modules/wiki-client/client'
]

{ #category : #accessing }
Wiki class >> commons [
	^ '/Users/rgb/.wiki/commons'
]

{ #category : #accessing }
Wiki class >> data [
	^ '/Users/rgb/.wiki/localhost'
]

{ #category : #'as yet unclassified' }
Wiki class >> dataDirForHost: aHostString [
	"Base directory for a given FedWiki host."

	^ self homeDir / aHostString
]

{ #category : #accessing }
Wiki class >> database [
	"{ type: './page' }"

	^ #db
]

{ #category : #accessing }
Wiki class >> db [
	"Answer db as pages filePath string"

	| pages |
	pages := '/Users/rgb/.wiki/wiki.ralfbarkow.ch/pages/'.
	^ pages
]

{ #category : #accessing }
Wiki class >> home [
	^ 'welcome-visitors'
]

{ #category : #'as yet unclassified' }
Wiki class >> homeDir [
	"Where all per-site data lives locally."

	^ FileLocator home / '.wiki'
]

{ #category : #accessing }
Wiki class >> id [
	^ '/Users/rgb/.wiki/localhost/status/owner.json'
]

{ #category : #accessing }
Wiki class >> isServerRunning [
	| response |
	"Try to load the welcome-visitors page to check if the server is running"
	[ response := ZnClient new
			http;
			host: 'localhost';
			port: 3000;
			path: Wiki home , '.json';
			get ] on: ConnectionTimedOut do: [ ^ false ].
	^ response isNotNil
]

{ #category : #accessing }
Wiki class >> neighbors [
	^ ''
]

{ #category : #accessing }
Wiki class >> packageDir [
	^ '/usr/local/lib/node_modules/wiki/node_modules'
]

{ #category : #accessing }
Wiki class >> pages [
^ Wiki db
]

{ #category : #accessing }
Wiki class >> pagesDirForHost: host [
  ^ (self dataDirForHost: host) / 'pages'.
]

{ #category : #accessing }
Wiki class >> port [
	^ 3000
]

{ #category : #accessing }
Wiki class >> recycler [
	^ '/Users/rgb/.wiki/localhost/recycle'
]

{ #category : #accessing }
Wiki class >> root [
^ '/usr/local/lib/node_modules/wiki/node_modules/wiki-server'
]

{ #category : #'as yet unclassified' }
Wiki class >> sitemapFileForHost: aHostString [
	"Local on-disk sitemap file."

	^ (self statusDirForHost: aHostString) / 'sitemap.json'
]

{ #category : #accessing }
Wiki class >> status [
	^ '/Users/rgb/.wiki/localhost/status'
]

{ #category : #'as yet unclassified' }
Wiki class >> statusDirForHost: aHostString [
	"Status dir that contains sitemap.json snapshots."

	^ (self dataDirForHost: aHostString) / 'status'
]

{ #category : #accessing }
Wiki class >> uploadLimit [
	^ '5mb'
]

{ #category : #accessing }
Wiki class >> url [
	^ 'http://localhost'
]

{ #category : #accessing }
Wiki >> gtRawDataFor: aView [
	<gtView>
	^ aView list
		title: 'Raw Data';
		items: [ rawData associations]
]

{ #category : #accessing }
Wiki >> rawData: dictionary [ 
	rawData := dictionary
	
]

{ #category : #accessing }
Wiki >> slugs [
	^ rawData collect: [:dictionary | Slug new rawData: dictionary]
]
