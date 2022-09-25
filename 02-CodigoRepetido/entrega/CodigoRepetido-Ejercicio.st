!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'AK 9/25/2022 14:55:21'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	self should: [(CustomerBook new) addCustomerNamed: 'John Lennon'] notTakeMoreThan: 50 milliSeconds.
	
	"""
	| customerBook millisecondsBeforeRunning millisecondsAfterRunning |
	customerBook := CustomerBook new.
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	customerBook addCustomerNamed: 'John Lennon'.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (50 * millisecond)
	"""
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AK 9/25/2022 14:58:39'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'] notTakeMoreThan: 100 milliSeconds.
	
	"""
	| customerBook millisecondsBeforeRunning millisecondsAfterRunning paulMcCartney |
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	customerBook removeCustomerNamed: paulMcCartney.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (100 * millisecond).
	"""
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AK 9/25/2022 16:39:26'!
test03CanNotAddACustomerWithEmptyName 
	
	| customerBook |
	customerBook := CustomerBook new.
	self should: [ customerBook addCustomerNamed: ''] raise: Error description: CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty.
	"""
	| customerBook |
	customerBook := CustomerBook new.
	[ customerBook addCustomerNamed: ''. self fail]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
	"""! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AK 9/25/2022 17:05:38'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook|
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'] raise: Error description: CustomerBook customerCanNotBeFoundErrorMessage.
	self assert: [customerBook numberOfCustomers = 1 & customerBook includesCustomerNamed: 'John Lennon'].
	
	"""
	| customerBook johnLennon |
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
	"""
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AK 9/25/2022 17:37:20'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self assert: [customerBook numberOfAllCustomers == [0,1,1]].
	
	"""self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney)."""
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

!CustomerBookTest methodsFor: 'testing' stamp: 'AK 9/25/2022 17:07:29'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
		
	self should: [customerBook suspendCustomerNamed: 'Ringo Starr'] raise: Error description: CustomerBook customerCanNotBeSuspendedErrorMessage.
	self assert: [customerBook numberOfCustomers = 1 & customerBook includesCustomerNamed: 'John Lennon'].
	

	"""
	| customerBook johnLennon |
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	"""! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AK 9/25/2022 17:13:33'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	customerBook suspendCustomerNamed: 'John Lennon'.
	
	self should: [customerBook suspendCustomerNamed: 'John Lennon'] raise: Error description: CustomerBook customerCanNotBeSuspendedErrorMessage.
	self assert: [customerBook numberOfCustomers = 1 & customerBook includesCustomerNamed: 'John Lennon'].
	
	"""
	| customerBook johnLennon |
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
	"""
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

!CustomerBook methodsFor: 'customer management' stamp: 'AK 9/25/2022 17:37:47'!
numberOfAllCustomers
	"""
	| customers |
	customers := OrderedCollection new .
	customers at: 0 put: active size.
	customers at: 1 put: suspended size.
	customers at: 2 put:  active size + suspended size.
	
	^customers.
	"""
	^{active size, suspended size, active size + suspended size}.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AK 9/25/2022 17:04:15'!
removeCustomerNamed: aName 
	
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			]
	].

	1 to: suspended size do: 	
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
