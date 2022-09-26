!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'F 9/26/2022 20:20:00'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	self should: [(CustomerBook new) addCustomerNamed: 'John Lennon'] notTakeMoreThan: 50 milliSeconds.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'F 9/26/2022 20:19:53'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'] notTakeMoreThan: 100 milliSeconds.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'F 9/26/2022 20:19:48'!
test03CanNotAddACustomerWithEmptyName 
	
	| customerBook |
	customerBook := CustomerBook new.
	self should: [ customerBook addCustomerNamed: ''] raise: Error description: CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'F 9/26/2022 20:19:43'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook|
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'] raise: Error description: CustomerBook customerCanNotBeFoundErrorMessage.
	self assert: [customerBook numberOfCustomers = 1 & customerBook includesCustomerNamed: 'John Lennon'].
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'F 9/26/2022 20:17:47'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AK 9/25/2022 16:15:57'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'F 9/26/2022 20:19:31'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
		
	self should: [customerBook suspendCustomerNamed: 'Ringo Starr'] raise: Error description: CustomerBook customerCanNotBeSuspendedErrorMessage.
	self assert: [customerBook numberOfCustomers = 1 & customerBook includesCustomerNamed: 'John Lennon'].
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'F 9/26/2022 20:19:36'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	customerBook suspendCustomerNamed: 'John Lennon'.
	
	self should: [customerBook suspendCustomerNamed: 'John Lennon'] raise: Error description: CustomerBook customerCanNotBeSuspendedErrorMessage.
	self assert: [customerBook numberOfCustomers = 1 & customerBook includesCustomerNamed: 'John Lennon'].
	
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'AK 9/25/2022 15:25:05'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'F 9/26/2022 20:27:24'!
removeCustomerNamed: aName 
	
	1 to: self numberOfActiveCustomers do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			]
	].

	1 to: self numberOfSuspendedCustomers do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].

	self signalCustomerNameCannotBeFound .
	
	"""
	active detect: [ :customer | (customer = aName) ifTrue: [active removeAt: customer]].
	suspended detect: [ :customer | (customer = aName) ifTrue: [suspended removeAt: customer]].
	^ NotFound signal.
	"""
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'AK 9/25/2022 15:07:08'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'AK 9/25/2022 17:03:44'!
signalCustomerNameCannotBeFound

	self error: self class customerCanNotBeFoundErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'AK 9/25/2022 17:03:58'!
signalCustomerNameCannotBeSuspended

	self error: self class customerCanNotBeSuspendedErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'AK 9/25/2022 17:04:31'!
suspendCustomerNamed: aName 

	(active includes: aName) ifFalse: [self signalCustomerNameCannotBeSuspended ].
	active remove: aName.
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'AK 9/25/2022 17:02:14'!
customerCanNotBeFoundErrorMessage

	^'Customer Name Cannot Be Found'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'AK 9/25/2022 17:00:00'!
customerCanNotBeSuspendedErrorMessage

	^'Customer Name Cannot Be Suspended'! !
