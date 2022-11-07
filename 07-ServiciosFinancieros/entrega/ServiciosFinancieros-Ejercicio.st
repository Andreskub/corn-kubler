!classDefinition: #AccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #AccountTest
	instanceVariableNames: 'accountA accountB accountC'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTest methodsFor: 'tests' stamp: 'F 11/7/2022 19:10:57'!
test01AccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: accountA balance
! !

!AccountTest methodsFor: 'tests' stamp: 'F 11/7/2022 19:10:42'!
test02DepositIncreasesBalanceOnTransactionValue 


	Deposit registerAmount:  100 * peso  withOriginator: accountA andBeneficiary: accountB .
		
	self assert: 100 * peso equals: accountB balance
! !

!AccountTest methodsFor: 'tests' stamp: 'F 11/7/2022 19:29:55'!
test03WithdrawDecreasesBalanceOnTransactionValue 


	Deposit registerAmount: 100 * peso  withOriginator: accountA andBeneficiary: accountB.
	Withdraw registerAmount: 50 * peso withOriginator: accountA andBeneficiary: accountB.
		
	self assert: 50 * peso equals: accountB balance
! !

!AccountTest methodsFor: 'tests' stamp: 'F 11/7/2022 19:32:34'!
test04WithdrawValueMustBePositive 

	| withdrawValue |
	
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw registerAmount: withdrawValue withOriginator: accountA andBeneficiary: accountB) value.
! !

!AccountTest methodsFor: 'tests' stamp: 'F 11/7/2022 19:33:53'!
test05AccountKnowsRegisteredTransactions 

	| deposit withdraw |
	
	deposit := Deposit registerAmount: 100 * peso  withOriginator: accountA andBeneficiary: accountB.
	withdraw := Withdraw registerAmount: 50 * peso withOriginator: accountA andBeneficiary: accountB.

	self assert: (accountB hasRegistered: deposit).
	self assert: (accountB hasRegistered: withdraw).
! !

!AccountTest methodsFor: 'tests' stamp: 'F 11/7/2022 19:42:53'!
test06AccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit :=  Deposit register: 100*peso fromOriginator: accountA toBeneficiary: accountB.
	withdraw := Withdraw register: 50*peso fromOriginator: accountA toBeneficiary: accountB .
		
	self deny: (accountB hasRegistered: deposit).
	self deny: (accountB hasRegistered: withdraw).
! !

!AccountTest methodsFor: 'tests' stamp: 'F 11/7/2022 19:43:58'!
test07AccountKnowsItsTransactions 

	| deposit |
	
	deposit := Deposit registerAmount: 50 * peso  withOriginator: accountA andBeneficiary: accountB.
		
	self assert: 1 equals: accountB transactions size.
	self assert: (accountB transactions includes: deposit).
! !


!AccountTest methodsFor: 'setup' stamp: 'F 11/7/2022 19:40:31'!
setUp
	

	accountA := Account new.
	accountB := Account new.
	accountC := Account new

	! !


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: 'transactions balance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'initialization' stamp: 'F 11/7/2022 18:37:53'!
initialize

	transactions := OrderedCollection new.
	balance := 0*peso.! !


!Account methodsFor: 'main protocol' stamp: 'F 11/7/2022 18:43:04'!
balance

	^ balance.

! !

!Account methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!Account methodsFor: 'main protocol' stamp: 'F 11/7/2022 18:40:54'!
register: aTransaction
	
	balance :=aTransaction registerInBalance: balance.
	transactions add: aTransaction 
	
! !

!Account methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'originator beneficiary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'operations' stamp: 'F 11/7/2022 18:41:14'!
registerInBalance: aBalance
	^self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'initialization' stamp: 'F 11/7/2022 19:20:19'!
register: aValue fromOriginator: anOriginator toBeneficiary: aBeneficiary   

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'F 11/7/2022 19:23:25'!
registerAmount: anAmount withOriginator: anOriginator andBeneficiary: aBeneficiary   

	| transaction |
	

	transaction := self register: anAmount fromOriginator: anOriginator toBeneficiary: aBeneficiary.
	
	aBeneficiary register: transaction.
		
	^ transaction
	"""^self register: anAmount fromOriginator: anOriginator toBeneficiary: aBeneficiary . """! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'F 11/7/2022 19:26:06'!
initializeFor: aValue with: anOrigintor and: aBeneficiary
	
	originator := anOrigintor .
	beneficiary := aBeneficiary .
	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'F 11/7/2022 18:42:11'!
registerInBalance: aBalance
	^ aBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'F 11/7/2022 19:25:01'!
register: anAmount fromOriginator: anOriginator toBeneficiary: aBeneficiary

	^ self new initializeFor: anAmount with: anOriginator and: aBeneficiary.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'F 11/7/2022 19:27:38'!
initializeFor: aValue with: anOrigintor and: aBeneficiary
	
	originator := anOrigintor .
	beneficiary := aBeneficiary .
	value := aValue ! !

!Withdraw methodsFor: 'initialization' stamp: 'F 11/7/2022 19:20:04'!
register: aValue fromOriginator: anOriginator toBeneficiary: aBeneficiary   

	| transaction |
	
	originator := anOriginator .
	beneficiary  := aBeneficiary .
	
	transaction := self for: aValue.
	
	aBeneficiary register: transaction.
		
	^ transaction! !


!Withdraw methodsFor: 'value' stamp: 'F 11/7/2022 18:42:30'!
registerInBalance: aBalance
	^aBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'F 11/7/2022 18:20:48'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'F 11/7/2022 19:27:55'!
register: anAmount fromOriginator: anOriginator toBeneficiary: aBeneficiary

	^ self new initializeFor: anAmount with: anOriginator and: aBeneficiary.! !
