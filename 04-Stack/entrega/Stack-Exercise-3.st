!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stackWinter winterSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Ak 10/14/2022 13:27:56'!
setUp
	
	stackWinter := OOStack new.
	
	winterSentences := {'winter is coming'.'winning is everything'.'The winds of Winter'.'Winter is here'.}.
	
	winterSentences do: [:sentence | stackWinter push: sentence ].
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Ak 10/14/2022 13:19:50'!
test01PrefixCanNotBeEmpty

	| emptyStack finder|
	
	emptyStack := OOStack new.
		
	finder := SentenceFinderByPrefix with: emptyStack.
	
	self should: [finder find: ''] raise: Error description: SentenceFinderByPrefix prefixEmptyErrorDescription.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Ak 10/14/2022 13:19:43'!
test02prefixCanNotContainEmptySpaces
	
	| finder|
		
	finder := SentenceFinderByPrefix with: stackWinter .
	
	self should: [finder find: 'win ter'] raise: Error description: SentenceFinderByPrefix prefixShouldNotHaveEmptySpacesErrorDescription .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Ak 10/14/2022 13:19:37'!
test03OnePrefixIsFoundInStack

	| finder finderOccurrencies |
	
	finder := SentenceFinderByPrefix with: stackWinter.
	
	finderOccurrencies := finder find: 'Wint'.
	
	self assert: (finderOccurrencies at: 1) equals: 'Winter is here'.
	self assert: (finderOccurrencies size) equals: 1.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Ak 10/14/2022 13:06:56'!
test04PrefixDoesNotExistsInStack

	| finder finderOccurrencies |
		
	finder := SentenceFinderByPrefix with: stackWinter .
	
	finderOccurrencies := finder find: 'hola'.
	 
	self assert: finderOccurrencies isEmpty .
	self assert: (finderOccurrencies size) equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Ak 10/14/2022 13:03:33'!
test05PrefixHasTwoOccurrenciesInStack

	| finder finderOccurrencies|
	
	finder := SentenceFinderByPrefix with: stackWinter .
	
	finderOccurrencies := finder find: 'wi'.
	
	self assert: (finderOccurrencies size) equals: 2.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'Ak 10/14/2022 13:49:50'!
test06PoppedStackRemainsTheSameAsOriginal
	
	| finder actualElement |
	
	finder := SentenceFinderByPrefix with: stackWinter .
	finder find: 'wi'.
	
	self assert: winterSentences size equals: stackWinter size.

	winterSentences reversed do: [ :sentence |
		actualElement := stackWinter pop.
		self assert: sentence equals: actualElement .
		].! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'AK 10/12/2022 22:01:19'!
pop
	
	| oldTop newTop |
	
	oldTop := top.
	
	newTop := top pop.
	
	top := newTop .
	
	size := size - 1.
	
	^ oldTop getElementValue.! !

!OOStack methodsFor: 'operations' stamp: 'AK 10/12/2022 22:01:28'!
push: anElement
	| newTop |
	
	newTop := top push: anElement .
	
	top := newTop .
	
	size := size + 1.
	! !


!OOStack methodsFor: 'testing' stamp: 'F 10/11/2022 21:09:15'!
isEmpty
	^ top isEmpty .! !


!OOStack methodsFor: 'initialization' stamp: 'Ak 10/14/2022 13:03:49'!
initialize
	top := Top with: nil andNextElement: nil.
	size := 0.! !


!OOStack methodsFor: 'properties' stamp: 'AK 10/12/2022 22:00:50'!
size
	^ size.! !

!OOStack methodsFor: 'properties' stamp: 'Ak 10/14/2022 13:04:05'!
top
	
	^top getElementValue .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'F 10/13/2022 23:05:44'!
withStack: aStack

	stack := aStack .
	
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Ak 10/14/2022 13:05:02'!
findAllPrefixOccurrencies: aPrefix

	| occurrencies stackAux |
	
	occurrencies := OrderedCollection new.
	
	stackAux := OOStack new.
	
	self invertStack: stack into: stackAux AndForElementsDo: [:element | 
		(element beginsWith: aPrefix) ifTrue:[occurrencies add: element]. 
		].
	
	self invertStack: stackAux into: stack AndForElementsDo: [: element | ].
	
	^ occurrencies .
	
	
	! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Ak 10/14/2022 13:05:23'!
invertStack: aStack into: anotherStack AndForElementsDo: aClosure

	| actualElement |
	
	[aStack isEmpty not] whileTrue: [
		actualElement := aStack pop.
		aClosure value: actualElement .
		anotherStack push: actualElement .
		].
	
	^ anotherStack. ! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Ak 10/14/2022 13:05:51'!
validatePrefix: aPrefix

	aPrefix isEmpty ifTrue: [^self error: self class prefixEmptyErrorDescription].
	
	((aPrefix findString: ' ') ~= 0) ifTrue: [^self error: self class prefixShouldNotHaveEmptySpacesErrorDescription].
	
	
	
	! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'Ak 10/14/2022 13:04:21'!
find: aPrefix

	self validatePrefix: aPrefix.
	
	^ self findAllPrefixOccurrencies: aPrefix
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'Ak 10/14/2022 13:06:20'!
with: aStack

	^ self new withStack: aStack .! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'Ak 10/14/2022 13:06:15'!
prefixEmptyErrorDescription
	
	^ 'Prefix is empty'.! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'Ak 10/14/2022 13:06:12'!
prefixShouldNotHaveEmptySpacesErrorDescription

	^ 'Prefix should not have empty spaces'.! !


!classDefinition: #Top category: 'Stack-Exercise'!
Object subclass: #Top
	instanceVariableNames: 'elementValue nextElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Top methodsFor: 'initialization' stamp: 'AK 10/12/2022 20:19:57'!
initializeWith: anElement andNextElement: anotherElement
	^ self subclassResponsibility .

	 
! !


!Top methodsFor: 'properties' stamp: 'AK 10/12/2022 22:05:25'!
getElementValue
	^ self subclassResponsibility .! !

!Top methodsFor: 'properties' stamp: 'F 10/11/2022 21:07:58'!
top
	^ self subclassResponsibility .! !


!Top methodsFor: 'testing' stamp: 'F 10/11/2022 21:09:26'!
isEmpty
	^ self subclassResponsibility .! !


!Top methodsFor: 'operations' stamp: 'AK 10/12/2022 19:24:58'!
pop
	^ self subclassResponsibility .! !

!Top methodsFor: 'operations' stamp: 'F 10/11/2022 21:33:06'!
push: anElement

	^ self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Top class' category: 'Stack-Exercise'!
Top class
	instanceVariableNames: ''!

!Top class methodsFor: 'instance creation' stamp: 'Ak 10/14/2022 13:06:34'!
with: anElement andNextElement: nextElement

	
	^(self subclasses detect: [:subclass | subclass isSubclass: anElement]) new initializeWith: anElement andNextElement: nextElement.! !


!Top class methodsFor: 'testing' stamp: 'AK 10/12/2022 19:26:50'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #Base category: 'Stack-Exercise'!
Top subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'initialization' stamp: 'AK 10/12/2022 20:25:33'!
initializeWith: anElement andNextElement: anotherElement

	elementValue := self.
	nextElement := nil.! !


!Base methodsFor: 'properties' stamp: 'AK 10/12/2022 22:06:13'!
getElementValue
	^self error: Top stackEmptyErrorDescription .! !

!Base methodsFor: 'properties' stamp: 'F 10/11/2022 20:54:24'!
top
	^ nil. "O DEVOLVEMOS EL VALOR (QUE ES NIL)"! !


!Base methodsFor: 'testing' stamp: 'F 10/11/2022 20:57:26'!
isEmpty
	^ true.! !


!Base methodsFor: 'operations' stamp: 'AK 10/12/2022 19:28:06'!
pop
	^self error: Top stackEmptyErrorDescription .
	! !

!Base methodsFor: 'operations' stamp: 'AK 10/12/2022 21:51:50'!
push: anElement
	
	"^Top with: anElement andNextElement: elementValue."
	
	^Top with: anElement andNextElement: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Base class' category: 'Stack-Exercise'!
Base class
	instanceVariableNames: ''!

!Base class methodsFor: 'instance creation' stamp: 'AK 10/12/2022 19:17:49'!
isSubclass: anElement
	^ anElement isNil.! !


!classDefinition: #Element category: 'Stack-Exercise'!
Top subclass: #Element
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'properties' stamp: 'AK 10/12/2022 22:05:09'!
getElementValue
	^ elementValue .! !

!Element methodsFor: 'properties' stamp: 'F 10/11/2022 20:54:56'!
top
	^ valor.! !


!Element methodsFor: 'intialization' stamp: 'AK 10/12/2022 20:21:05'!
initializeWith: anElement andNextElement: anotherElement
		
	elementValue := anElement .
	nextElement := anotherElement .! !


!Element methodsFor: 'testing' stamp: 'F 10/11/2022 20:57:50'!
isEmpty
	^ false.! !


!Element methodsFor: 'operations' stamp: 'AK 10/12/2022 20:35:18'!
pop
	
	^ nextElement.! !

!Element methodsFor: 'operations' stamp: 'AK 10/12/2022 21:55:18'!
push: anElement
	^ Top with: anElement andNextElement: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Element class' category: 'Stack-Exercise'!
Element class
	instanceVariableNames: ''!

!Element class methodsFor: 'instance creation' stamp: 'AK 10/12/2022 19:22:49'!
isSubclass: anElement
	^ anElement isString.! !
