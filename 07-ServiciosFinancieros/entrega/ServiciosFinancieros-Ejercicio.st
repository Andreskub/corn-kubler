!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolioA portfolioB portfolioC accountA accountB accountC accountD'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'Ak 11/10/2022 00:04:13'!
setUp
	
	accountA := ReceptiveAccount new.	Withdraw register: 100*peso on: accountA.
	
	accountB := ReceptiveAccount new.	Deposit register: 50*peso on: accountB.
	
	"""Portfolio with 1 account"""
	portfolioA := Portfolio new.
	portfolioA register: accountA.
	"""Portfolio with 2 accounts"""
	portfolioB := Portfolio new.
	portfolioB register: accountA.
	portfolioB register: accountB.
	
	"""Portfolio with 3 accounts"""
	
	accountC := ReceptiveAccount new.
	Deposit register: 120*peso on: accountC.
	Deposit register: 150*peso on: accountC.
	accountD := ReceptiveAccount new.
	Transfer fromOriginator: accountC toBeneficiary: accountD withValue: 50*peso.
	
	portfolioC := Portfolio new.
	portfolioC register: accountA.
	portfolioC register: accountB.
	portfolioC register: accountC.
	portfolioC register: accountD.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'AK 11/8/2022 21:20:52'!
test01InitializeNewPortfolioHasZeroTransactions

	| emptyPortfolio |
	
	emptyPortfolio := Portfolio new.
	
	self assert: emptyPortfolio isEmpty .

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'AK 11/8/2022 21:21:09'!
test02RegisterAnAccountInPortfolioIsNotEmpty

	self deny: portfolioA isEmpty.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:37:27'!
test03PortfolioBalanceIsTheSameAsItsOnlyAccountRegistered

	self assert: portfolioA balance equals: -100*peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:37:19'!
test04PortfolioBalanceIsTheSameAsItsBothAccountsRegistered

	self assert: portfolioB balance equals: -50*peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:44:19'!
test05PortfolioBalanceIsTheSameAsItsMultipleAccountsRegistered

	self assert: portfolioC balance equals: 220*peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ak 11/10/2022 00:03:37'!
test06PortfolioHasTheSameTransactionsAsItsOnlyAccount
	
	self assert: portfolioA transactions equals: accountA transactions.! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ak 11/10/2022 00:07:44'!
test07PortfolioHasTheSameTransactionsAsItsMultipleAccounts
	
	| allAccountsTransactions |
	
	allAccountsTransactions := OrderedCollection new.
	allAccountsTransactions addAll: accountA transactions .
	allAccountsTransactions addAll: accountB transactions .
	allAccountsTransactions addAll: accountC transactions .
	allAccountsTransactions addAll: accountD transactions .
	
	self assert: portfolioC transactions equals: allAccountsTransactions .! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'accountA accountB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 22:48:30'!
setUp
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:09:09'!
test01TransferingAmountLeavesBalanceDifferentFromZeroInBothAccounts

	Transfer fromOriginator: accountA toBeneficiary: accountB withValue: 50*peso.
	
	self deny: accountA balanceIsZero.
	self deny: accountB balanceIsZero.
! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:18:35'!
test02Transfer50PesoUpdatesBalanceInBothAccounts

	Transfer fromOriginator: accountA toBeneficiary: accountB withValue: 50*peso.
	
	self assert: accountA balance equals: -50*peso.
	self assert: accountB balance equals: 50*peso.
! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:17:55'!
test03Transfer0PesoShouldRaiseError
	
	self should: [ Transfer fromOriginator: accountA toBeneficiary: accountB withValue: 0*peso. ]
       		raise: Error
	        		withExceptionDo: [ :anError |
            				self assert: Transfer invalidTransferAmountErrorDescription equals: anError messageText ].
! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:18:20'!
test04TransferNegativeAmountShouldRaiseError
	
	self should: [ Transfer fromOriginator: accountA toBeneficiary: accountB withValue: -100*peso. ]
       		raise: Error
	        		withExceptionDo: [ :anError |
            				self assert: Transfer invalidTransferAmountErrorDescription equals: anError messageText ].
! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:20:46'!
test05TransferMultipleTimesInOneWayUpdatesBalanceCorrectlyInBothAccounts

	Transfer fromOriginator: accountA toBeneficiary: accountB withValue: 50*peso.
	Transfer fromOriginator: accountA toBeneficiary: accountB withValue: 200*peso.
	
	self assert: accountA balance equals: -250*peso.
	self assert: accountB balance equals: 250*peso.
! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:22:05'!
test06TransferMultipleTimesInBothWaysUpdatesBalanceCorrectlyInBothAccounts

	Transfer fromOriginator: accountA toBeneficiary: accountB withValue: 25*peso.
	Transfer fromOriginator: accountB toBeneficiary: accountA withValue: 100*peso.
	Transfer fromOriginator: accountB toBeneficiary: accountA withValue: 50*peso.
	
	self assert: accountA balance equals: 125*peso.
	self assert: accountB balance equals: -125*peso.
! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/9/2022 23:26:56'!
test07TransferBeneficiaryAccountIsTheSameAsOriginatorAccountShouldRaiseError
	
	self should: [ Transfer fromOriginator: accountA toBeneficiary: accountA withValue: 100*peso. ]
       		raise: Error
	        		withExceptionDo: [ :anError |
            				self assert: Transfer beneficiaryAccountIsTheSameAsOriginatorAccountErrorDescription equals: anError messageText ].

! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AK 11/8/2022 21:10:15'!
registerInBalance: aBalance
	^ self subclassResponsibility .! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'Ak 11/9/2022 22:19:49'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	
	account register: transaction.
	
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'AK 11/8/2022 21:10:38'!
registerInBalance: aBalance
	^ aBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'AK 11/8/2022 20:55:11'!
initializeFor: aValue

	value := aValue. ! !


!Withdraw methodsFor: 'value' stamp: 'AK 11/8/2022 21:10:51'!
registerInBalance: aBalance
	^ aBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'portfolioItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialize' stamp: 'AK 11/8/2022 21:17:02'!
initialize
	portfolioItems := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'Ak 11/9/2022 23:28:13'!
balance
	| auxBalance |
	
	auxBalance := 0*peso.	
	
	portfolioItems do: [ :anAccount | auxBalance := auxBalance + (anAccount balance)		].
	
	^auxBalance .! !

!Portfolio methodsFor: 'main protocol' stamp: 'AK 11/8/2022 21:18:52'!
portfolioItems
	^ portfolioItems .! !

!Portfolio methodsFor: 'main protocol' stamp: 'Ak 11/9/2022 23:28:19'!
register: anAccount
	portfolioItems add: anAccount .! !

!Portfolio methodsFor: 'main protocol' stamp: 'Ak 11/9/2022 23:58:13'!
transactions

	| portfolioTransactions |
	
	portfolioTransactions := OrderedCollection new.
	
	portfolioItems do: [ :aItem |  portfolioTransactions addAll: aItem transactions ].
	
	^ portfolioTransactions ! !


!Portfolio methodsFor: 'testing' stamp: 'AK 11/8/2022 21:20:45'!
isEmpty
	^ portfolioItems isEmpty .! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AK 11/8/2022 20:45:40'!
initialize

	transactions := OrderedCollection new.
	balance := 0*peso.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'Ak 11/9/2022 23:12:42'!
balanceIsZero
	^ self balance = (0*peso).! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AK 11/8/2022 21:37:08'!
balance
	| auxBalance |

	auxBalance := 0*peso.	
	
	transactions do: [ :aTransaction | auxBalance := aTransaction registerInBalance: auxBalance		].

	^auxBalance .! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'Ak 11/9/2022 22:38:22'!
register: aTransaction

	transactions add: aTransaction.
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'Ak 11/9/2022 22:44:07'!
initializeWithOriginator: originatorAccount AndBeneficiary: beneficiaryAccount withValue: anAmount

	| originatorWithdraw beneficiaryDeposit |

	originatorWithdraw := Withdraw register: anAmount on: originatorAccount .
	
	beneficiaryDeposit := Deposit register: anAmount on: beneficiaryAccount .
	
	value := anAmount .
	
	^ self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error descriptions' stamp: 'Ak 11/9/2022 23:24:58'!
beneficiaryAccountIsTheSameAsOriginatorAccountErrorDescription

	^ ' The beneficiary account is the same as the originator account!! '! !

!Transfer class methodsFor: 'error descriptions' stamp: 'Ak 11/9/2022 23:25:02'!
invalidTransferAmountErrorDescription
	
	^ ' Invalid transfer amount!! '.! !


!Transfer class methodsFor: 'instance creation' stamp: 'Ak 11/9/2022 23:24:08'!
fromOriginator: originatorAccount toBeneficiary: beneficiaryAccount withValue: anAmount

	(anAmount  <= (0*peso)) ifTrue: [self error: self invalidTransferAmountErrorDescription].
	(originatorAccount isEqualTo: beneficiaryAccount) ifTrue: [self error: self beneficiaryAccountIsTheSameAsOriginatorAccountErrorDescription].
	
	^self new initializeWithOriginator: originatorAccount AndBeneficiary: beneficiaryAccount withValue: anAmount.
	
	

	! !
