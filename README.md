
## Installation

```Smalltalk
[ EpMonitor current
	disableDuring: [ Metacello new
			repository: 'github://botwhytho/LeSerializedObjectSnippet:main/src';
			baseline: 'LeSerializedObjectSnippet';
			load ] ] asAsyncPromiseWithUserBackgroundPriority
```

To depend on this package add this to your baseline:

```Smalltalk
spec baseline: 'LeSerializedObjectSnippet' with: [spec repository: 'github://botwhytho/LeSerializedObjectSnippet:main/src']
```
