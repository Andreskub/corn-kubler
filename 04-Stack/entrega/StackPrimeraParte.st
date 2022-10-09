!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: 'stackTest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'setup' stamp: 'F 10/9/2022 14:15:49'!
setUp
 

	stackTest:= Stack new
! !


!StackTest methodsFor: 'tests' stamp: 'F 10/9/2022 14:16:08'!
test01StackShouldBeEmptyWhenCreated

	
	self assert: stackTest isEmpty! !

!StackTest methodsFor: 'tests' stamp: 'F 10/9/2022 14:21:51'!
test02PushElementToStackShouldNotBeEmpty
	stackTest push: 1.
	self assert: stackTest isEmpty not! !

!StackTest methodsFor: 'tests' stamp: 'F 10/9/2022 14:31:58'!
test03PushingThreeElementsShouldHaveSizeOfThree
	stackTest push:1.
	stackTest push:2.
	stackTest push:3.
	self assert: stackTest size equals: 3.! !

!StackTest methodsFor: 'tests' stamp: 'F 10/9/2022 14:46:38'!
test04PopElementFromStackWithSizeOneShouldBeEmpty
	stackTest push:1.
	stackTest pop.
	self assert: stackTest isEmpty.
	! !

!StackTest methodsFor: 'tests' stamp: 'F 10/9/2022 14:51:46'!
test05PopElementFromEmptyStackShouldRaiseError
	
	self should:[stackTest pop] raise: Error withExceptionDo: [:anError | self assert: Stack canNotPopFromEmptyStackErrorDescription equals: anError messageText ]! !

!StackTest methodsFor: 'tests' stamp: 'F 10/9/2022 15:29:21'!
test06PopReturnsTheRemovedElementAndStackIsLIFO
	stackTest push: 1.
	stackTest push: 2.
	self assert: stackTest pop equals: 2.! !

!StackTest methodsFor: 'tests' stamp: 'F 10/9/2022 15:42:19'!
test07TopReturnsLastElementWithoutRemovingIt
	stackTest push: 2.
	stackTest push: 3.
	stackTest push: 1.
	self assert: stackTest top equals: 1.
	self assert: stackTest top equals: 1.! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'properties' stamp: 'F 10/9/2022 14:27:36'!
size
	^stack size! !

!Stack methodsFor: 'properties' stamp: 'F 10/9/2022 15:41:28'!
top
	|top|
	(self isEmpty) ifTrue:[self error: Stack canNotShowTopFromAnEmptyStackErrorDescription ].
	top := self pop.
	self push: top.
	^top! !


!Stack methodsFor: 'testing' stamp: 'F 10/9/2022 14:10:02'!
isEmpty
	^stack isEmpty! !


!Stack methodsFor: 'initialization' stamp: 'F 10/9/2022 14:07:41'!
initialize
	stack:=OrderedCollection new.! !


!Stack methodsFor: 'operations' stamp: 'F 10/9/2022 14:45:42'!
pop
	(self isEmpty) ifTrue:[self error: Stack canNotPopFromEmptyStackErrorDescription ].
	^stack removeFirst.! !

!Stack methodsFor: 'operations' stamp: 'F 10/9/2022 14:23:49'!
push: anElement
	stack addFirst: anElement ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stack class' category: 'StackPrimeraParte'!
Stack class
	instanceVariableNames: ''!

!Stack class methodsFor: 'error descriptions' stamp: 'F 10/9/2022 14:43:07'!
canNotPopFromEmptyStackErrorDescription
	^'Can not pop an element from an empty stack'! !

!Stack class methodsFor: 'error descriptions' stamp: 'F 10/9/2022 15:36:40'!
canNotShowTopFromAnEmptyStackErrorDescription
	^'Empty stack does not have top'! !
