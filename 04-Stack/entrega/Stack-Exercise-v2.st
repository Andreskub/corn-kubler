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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'F 10/11/2022 20:10:17'!
pop
	(self isEmpty) ifTrue:[self error: OOStack stackEmptyErrorDescription ].
	^stack removeFirst.! !

!OOStack methodsFor: 'operations' stamp: 'F 10/11/2022 21:31:33'!
push: anElement
	| newTop |
	
	newTop := top push: anElement .
	
	top := newTop .
	! !


!OOStack methodsFor: 'testing' stamp: 'F 10/11/2022 21:09:15'!
isEmpty
	^ top isEmpty .! !


!OOStack methodsFor: 'initialization' stamp: 'F 10/11/2022 21:06:59'!
initialize
	top := Base new.! !


!OOStack methodsFor: 'properties' stamp: 'F 10/11/2022 19:48:56'!
size
	^stack size! !

!OOStack methodsFor: 'properties' stamp: 'F 10/11/2022 21:07:31'!
top
	^top top .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #Top category: 'Stack-Exercise'!
Object subclass: #Top
	instanceVariableNames: 'elementValue nextElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Top methodsFor: 'initialization' stamp: 'F 10/11/2022 20:44:13'!
initialize
	^self subclassResponsibility .! !


!Top methodsFor: 'properties' stamp: 'F 10/11/2022 21:07:58'!
top
	^ self subclassResponsibility .! !


!Top methodsFor: 'testing' stamp: 'F 10/11/2022 21:09:26'!
isEmpty
	^ self subclassResponsibility .! !


!Top methodsFor: 'operations' stamp: 'F 10/11/2022 21:33:06'!
push: anElement

	^ self subclassResponsibility .! !


!classDefinition: #Base category: 'Stack-Exercise'!
Top subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'initialization' stamp: 'F 10/11/2022 21:34:07'!
initialize
	elementValue := nil.
	nextElement := nil.! !


!Base methodsFor: 'properties' stamp: 'F 10/11/2022 20:54:24'!
top
	^ nil. "O DEVOLVEMOS EL VALOR (QUE ES NIL)"! !


!Base methodsFor: 'testing' stamp: 'F 10/11/2022 20:57:26'!
isEmpty
	^ true.! !


!Base methodsFor: 'operations' stamp: 'F 10/11/2022 21:32:09'!
push: anElement
	
	^ Elemento new with: anElement andNext: self.
	
	! !


!classDefinition: #Elemento category: 'Stack-Exercise'!
Top subclass: #Elemento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Elemento methodsFor: 'properties' stamp: 'F 10/11/2022 20:54:56'!
top
	^ valor.! !


!Elemento methodsFor: 'intialization' stamp: 'F 10/11/2022 21:28:08'!
with: anElement andNext: theNextElement
	
	elementValue := anElement .
	nextElement := theNextElement .! !


!Elemento methodsFor: 'testing' stamp: 'F 10/11/2022 20:57:50'!
isEmpty
	^ false.! !


!Elemento methodsFor: 'operations' stamp: 'F 10/11/2022 21:31:59'!
push: anElement
	
	^ Elemento new with: anElement andNext: self.
	
	! !
