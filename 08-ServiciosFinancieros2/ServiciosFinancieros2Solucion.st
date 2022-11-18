!classDefinition: #PortfolioTest category: 'ServiciosFinancieros2Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros2Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

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


!classDefinition: #ReportTest category: 'ServiciosFinancieros2Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'accountA originatorAccount beneficiaryAccount accountMia accountJuan accountAngeles accountAndres portfolioFamilia portfolioHijos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!ReportTest methodsFor: 'accountSummary tests' stamp: 'Ak 11/18/2022 13:58:56'!
test01AccountSummaryBalanceFromEmptyAccountIsZero

	|accountSummaryReport|
	
	accountSummaryReport := AccountSummaryReport for: accountA.
	
	self assert: (accountSummaryReport reportAsString) equals: 'Balance = 0 * pesos'.! !

!ReportTest methodsFor: 'accountSummary tests' stamp: 'Ak 11/18/2022 13:59:10'!
test02AccountSummaryReportWithAccountWithOneDepositHasDepositAndBalance
	|accountSummaryReport|
	
	Deposit register: 100 * peso on: accountA. 
	
	accountSummaryReport := AccountSummaryReport for: accountA.
	
	self assert: (accountSummaryReport reportAsString) 
	equals: 	('Depósito por 100 * pesos', String newLineString ,'Balance = 100 * pesos').! !

!ReportTest methodsFor: 'accountSummary tests' stamp: 'Ak 11/18/2022 13:56:30'!
test03AccountSummaryReportForEmptyStringRaisesError
	self should: [ AccountSummaryReport for: ''. . ]
               raise: Error
                    withExceptionDo: [ :anError |
                            self assert: Report invalidInputErrorDescription equals: anError messageText ].! !


!ReportTest methodsFor: 'transferNet tests' stamp: 'Ak 11/18/2022 13:59:33'!
test11TransferNetIsZeroWhenTheAccountDoesNotHaveTransfers
	|transferNet|
	
	transferNet := TransferNetReport for: accountA.
	
	self assert: transferNet equals: 0*peso.! !

!ReportTest methodsFor: 'transferNet tests' stamp: 'Ak 11/18/2022 14:03:57'!
test12TransferNetWithOneTransferHasCorrectBalance
	|transferNet|
	
	Transfer amount: 100*peso  from: originatorAccount to: beneficiaryAccount.
	transferNet := TransferNetReport for: beneficiaryAccount.
	
	self assert: transferNet equals: 100*peso.! !

!ReportTest methodsFor: 'transferNet tests' stamp: 'Ak 11/18/2022 14:04:35'!
test13TransferNetWithMultipleTransferHasCorrectBalance
	|transferNet|
	
	Transfer amount: 100*peso  from: originatorAccount to: beneficiaryAccount.
	Transfer amount: 50*peso  from: beneficiaryAccount to: originatorAccount.	
	
	transferNet := TransferNetReport for: beneficiaryAccount.
	
	self assert: transferNet equals: 50*peso.! !

!ReportTest methodsFor: 'transferNet tests' stamp: 'Ak 11/18/2022 14:00:51'!
test14TransferNetIsNotAffectedByDeposit
	|transferNet|
	
	Deposit register: 100*peso on: accountA.
	transferNet := TransferNetReport for: accountA.
	
	self assert: transferNet equals: 0*peso.! !

!ReportTest methodsFor: 'transferNet tests' stamp: 'Ak 11/18/2022 14:00:15'!
test15TransferNetIsNotAffectedByWithdraw
	|transferNet|
	
	Withdraw register: 100*peso on: accountA.
	
	transferNet := TransferNetReport for: accountA.
	
	self assert: transferNet equals: 0*peso.! !

!ReportTest methodsFor: 'transferNet tests' stamp: 'Ak 11/18/2022 14:05:17'!
test16TransferNetIsOnlyAffectedByTransfers
	|transferNet|
	
	Transfer amount: 100*peso  from: originatorAccount to: beneficiaryAccount.
	Transfer amount: 50*peso  from: beneficiaryAccount to: originatorAccount.	
	
	Withdraw register: 100*peso on: beneficiaryAccount.
	
	transferNet := TransferNetReport for: beneficiaryAccount.
	
	self assert: transferNet equals: 50*peso.! !

!ReportTest methodsFor: 'transferNet tests' stamp: 'Ak 11/18/2022 14:00:29'!
test17TransferNetForEmptyStringRaisesError

	self should: [ TransferNetReport for: ''. . ]
               raise: Error
                    withExceptionDo: [ :anError |
                            self assert: Report invalidInputErrorDescription equals: anError messageText ].! !


!ReportTest methodsFor: 'portfolioTreePrinterDetailed tests' stamp: 'Ak 11/18/2022 13:53:58'!
test31ComplexPortfolioTreePrinterDetailedreportHasTheCorrectIdentation

	Deposit register: 100 * peso on: accountMia .
	Withdraw register: 50 * peso on: accountMia.
	Deposit register: 200 * peso on: accountJuan .
	Withdraw register: 50 * peso on: accountJuan .
	Transfer amount: 20 * peso from: accountAngeles to: accountAndres .
	
	self assert: (PortfolioTreePrinterDetailedReport for: portfolioFamilia ) 
	equals: 
'Portfolio de la familia
    Cuenta mia
        Depósito por 100 * pesos
        Extracción por 50 * pesos
        Balance = 50 * pesos
    Portfolio de hijos
        Cuenta de Juan
            Depósito por 200 * pesos
            Extracción por 50 * pesos
            Balance = 150 * pesos
        Cuenta de Angeles
            Salida por transferencia de 20 * pesos
            Balance = -20 * pesos
    Balance = 130 * pesos
Balance = 180 * pesos'.
! !

!ReportTest methodsFor: 'portfolioTreePrinterDetailed tests' stamp: 'Ak 11/18/2022 13:53:40'!
test32PortfolioTreePrinterDetailedForEmptyStringRaisesError

	self should: [ PortfolioTreePrinterDetailedReport for: ''. . ]
               raise: Error
                    withExceptionDo: [ :anError |
                            self assert: Report invalidInputErrorDescription equals: anError messageText ].! !


!ReportTest methodsFor: 'portfolioTreePrinter tests' stamp: 'f 11/16/2022 23:13:04'!
test21AccountHasTheCorrectName

	|account|
	
	account := ReceptiveAccount named: 'Cuenta de Franco'.
	
	self assert: account name equals: 'Cuenta de Franco'.! !

!ReportTest methodsFor: 'portfolioTreePrinter tests' stamp: 'f 11/16/2022 23:14:21'!
test22PortfolioHasTheCorrectName

	|account portfolio|
	
	account := ReceptiveAccount named: 'Cuenta de Franco'.
	
	portfolio := Portfolio named: 'Portfolio de Franco' with: account.
	
	self assert: portfolio name equals: 'Portfolio de Franco'.! !

!ReportTest methodsFor: 'portfolioTreePrinter tests' stamp: 'AK 11/18/2022 00:34:39'!
test23InitializeReceptiveAccountHasEmptyName

	|account |
	
	account := ReceptiveAccount new.
	
	self assert: account name equals: ''.! !

!ReportTest methodsFor: 'portfolioTreePrinter tests' stamp: 'AK 11/18/2022 00:34:20'!
test24InitializePortfolioHasEmptyName

	|portfolio|
	portfolio := Portfolio new.
	
	self assert: portfolio name equals: ''.! !

!ReportTest methodsFor: 'portfolioTreePrinter tests' stamp: 'Ak 11/18/2022 13:44:32'!
test25SimplePortfolioTreePrinterReportHasTheCorrectIdentation
	self assert: (PortfolioTreePrinterReport for: portfolioFamilia ) 
	equals: 
'Portfolio de la familia
    Cuenta mia
    Portfolio de hijos
        Cuenta de Juan
        Cuenta de Angeles'.! !

!ReportTest methodsFor: 'portfolioTreePrinter tests' stamp: 'Ak 11/18/2022 13:44:24'!
test26ComplexPortfolioTreePrinterReportHasTheCorrectIdentation
	portfolioFamilia add: accountAndres .
	
	self assert: (PortfolioTreePrinterReport for: portfolioFamilia) 
	equals: 
'Portfolio de la familia
    Cuenta mia
    Portfolio de hijos
        Cuenta de Juan
        Cuenta de Angeles
    Cuenta de Andres'.! !

!ReportTest methodsFor: 'portfolioTreePrinter tests' stamp: 'F 11/18/2022 11:05:23'!
test27PortfolioTreePrinterForEmptyStringRaisesError

	self should: [ PortfolioTreePrinterReport for: ''. . ]
               raise: Error
                    withExceptionDo: [ :anError |
                            self assert: Report invalidInputErrorDescription equals: anError messageText ].! !


!ReportTest methodsFor: 'setUp' stamp: 'Ak 11/18/2022 14:03:29'!
setUp

	accountA := ReceptiveAccount new.
	originatorAccount := ReceptiveAccount new.
	beneficiaryAccount := ReceptiveAccount new.

	accountMia := ReceptiveAccount named: 'Cuenta mia'.
	accountJuan := ReceptiveAccount named: 'Cuenta de Juan'.
	accountAngeles := ReceptiveAccount named: 'Cuenta de Angeles'.
	accountAndres := ReceptiveAccount named: 'Cuenta de Andres'.
	
	portfolioHijos := Portfolio named: 'Portfolio de hijos' with: accountJuan with: accountAngeles .
	portfolioFamilia := Portfolio named: 'Portfolio de la familia'  with: accountMia  with: portfolioHijos .! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros2Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'originatorAccount beneficiaryAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/18/2022 14:07:20'!
setUp

	originatorAccount := ReceptiveAccount new.
	beneficiaryAccount := ReceptiveAccount new.! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/18/2022 14:08:28'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount
	
	Deposit register: 10 * peso on: originatorAccount .
	Deposit register: 10 * peso on: beneficiaryAccount .
	
	Transfer amount: 2 * peso from: originatorAccount to: beneficiaryAccount .
	
	self assert: 8 * peso equals: originatorAccount balance.
	self assert: 12 * peso equals: beneficiaryAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/18/2022 14:09:13'!
test02ATransferKnowsItsValue

	| transfer |
	
	Deposit register: 10 * peso on: originatorAccount.
	Deposit register: 10 * peso on: beneficiaryAccount.
	
	transfer := Transfer amount: 2 * peso from: originatorAccount to: beneficiaryAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/18/2022 14:10:02'!
test03DepositLegKnowsItsWithdrawCounterpart

	| transfer |
	
	Deposit register: 10 * peso on: originatorAccount .
	Deposit register: 10 * peso on: beneficiaryAccount.
	
	transfer := Transfer amount: 2 * peso from: originatorAccount to: beneficiaryAccount .
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/18/2022 14:11:02'!
test04WithdrawLegKnowsItsDepositCounterpart

	| transfer |
	
	Deposit register: 10 * peso on: originatorAccount .
	Deposit register: 10 * peso on: beneficiaryAccount.
	
	transfer := Transfer amount: 2 * peso from: originatorAccount to: beneficiaryAccount .
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/18/2022 14:11:46'!
test05OriginAndDestinationAccountsCannotBeTheSame

	Deposit register: 10 * peso on: originatorAccount.
	
	self should: [ Transfer amount: 2 * peso from: originatorAccount to: originatorAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originatorAccount balance.
		].
! !

!TransferTest methodsFor: 'tests' stamp: 'Ak 11/18/2022 14:12:39'!
test06CannotTransferAZeroAmount
	
	
	Deposit register: 10 * peso on: originatorAccount .
	Deposit register: 5 * peso on: beneficiaryAccount.
	
	self should: [ Transfer amount: 0 from: originatorAccount to: beneficiaryAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originatorAccount balance.
		].
! !


!classDefinition: #Account category: 'ServiciosFinancieros2Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'f 11/16/2022 22:50:40'!
processTree
	
	^self subclassResponsibility .! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros2Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'f 11/16/2022 20:32:44'!
initialize

	^self initializeWithName: '' with: nil  with: nil.! !

!Portfolio methodsFor: 'initialization' stamp: 'f 11/16/2022 22:37:24'!
initializeWithName: aName with: anAccount with: anotherAccount

	
	accounts := OrderedCollection new.
	name := aName.
	
	anAccount ifNotNil: [self add: anAccount ].
	anotherAccount ifNotNil: [self add: anotherAccount ].! !


!Portfolio methodsFor: 'main protocol' stamp: 'f 11/16/2022 22:21:23'!
accounts
	^accounts copy.! !

!Portfolio methodsFor: 'main protocol' stamp: 'f 11/15/2022 21:10:13'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'f 11/16/2022 20:23:31'!
name

	^name copy.! !

!Portfolio methodsFor: 'main protocol' stamp: 'AK 11/17/2022 22:56:57'!
processTree

	|portfolioTree auxCollection|
	
	portfolioTree := OrderedCollection new.
	
	self accounts do:[ :anAccount | 
		auxCollection := (anAccount processTree).
		auxCollection do: [ :aName |
				portfolioTree addLast: ('    ',aName).
			].
		].
	
	portfolioTree addFirst: (self name).
	
	^portfolioTree 
	! !

!Portfolio methodsFor: 'main protocol' stamp: 'AK 11/18/2022 00:16:24'!
processTreeDetailed

	|portfolioTree auxCollection |
	
	portfolioTree := OrderedCollection new.
	
	self accounts do:[ :anAccount | 
		auxCollection := (anAccount processTreeDetailed ).
		auxCollection do: [ :aName |
				portfolioTree addLast: ('    ',aName).
			].
		].
	
	portfolioTree addFirst: (self name).
	portfolioTree addLast: ('Balance = ', (self balance) asString ).
	
	^portfolioTree 
	! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'LL 7/1/2021 03:21:12'!
add: accountToAdd
	
	accounts add: accountToAdd.
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros2Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'f 11/16/2022 20:22:08'!
named: aName with: anAccount

	^self new initializeWithName: aName with: 	anAccount with: nil.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'f 11/16/2022 20:21:33'!
named: aName with: anAccount with: anotherAccount

	^self new initializeWithName: aName with: 	anAccount with: 	anotherAccount .! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros2Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'f 11/16/2022 20:06:19'!
initialize

	self initializeWithName: ''.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'f 11/16/2022 20:04:34'!
initializeWithName: aName

	super initialize.
	transactions := OrderedCollection new.
	name := aName
	! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'f 11/15/2022 21:12:16'!
balance

	^transactions 
		inject: (0 * peso)
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'f 11/16/2022 20:08:06'!
name

	^name copy.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AK 11/17/2022 22:37:16'!
processTree

	^{self name}.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AK 11/17/2022 23:47:57'!
processTreeDetailed

	| treeIntenalCollection accountSummaryReport |
	
	treeIntenalCollection := OrderedCollection new.
	treeIntenalCollection addLast: (self name).

	accountSummaryReport := AccountSummaryReport for: self.
	
	(accountSummaryReport report) do: [ :aLine | 
			treeIntenalCollection addLast: ('    ',aLine ).
		].
	
	^ treeIntenalCollection.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros2Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'f 11/16/2022 20:07:08'!
named: aName

	^self new initializeWithName: aName 

	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros2Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private' stamp: 'f 11/15/2022 20:49:56'!
processLineFor: aReport
	
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros2Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros2Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'private' stamp: 'f 11/15/2022 20:52:04'!
processLineFor: anAccount
	
	^ anAccount processDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros2Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros2Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros2Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros2Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'private' stamp: 'f 11/15/2022 20:54:01'!
processLineFor: anAccount

	^ anAccount processTransferDepositLeg: self.! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros2Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'private' stamp: 'f 11/15/2022 20:54:27'!
processLineFor: anAccount

	^ anAccount processTransferWithdrawLeg: self.! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros2Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'private' stamp: 'f 11/15/2022 20:54:45'!
processLineFor: anAccount

	^ anAccount processWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros2Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'ServiciosFinancieros2Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!Report methodsFor: 'main protocol' stamp: 'AK 11/17/2022 23:06:11'!
linesAsString: aCollectionOfLines

	^aCollectionOfLines collect: [ :aLine | aLine ] 
	andFold: [ :acumulatedOutput :newLine | 
		acumulatedOutput , String newLineString , newLine
		] 
	ifEmpty: [''].! !


!Report methodsFor: 'initialization' stamp: 'f 11/16/2022 19:12:16'!
initializeWith: anAccount
	
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros2Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'F 11/18/2022 10:54:38'!
for: anAccount
	(anAccount isKindOf: Account) ifFalse: [self error: self invalidInputErrorDescription].
	 
	^ self new initializeWith: anAccount.! !


!Report class methodsFor: 'error descriptions' stamp: 'F 11/18/2022 10:53:22'!
invalidInputErrorDescription
	^'Reports are only for receptive accounts and portfolios'! !


!classDefinition: #AccountSummaryReport category: 'ServiciosFinancieros2Solucion'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!AccountSummaryReport methodsFor: 'initialization' stamp: 'Ak 11/18/2022 14:39:43'!
initializeWith: anAccount
	report := OrderedCollection new.	
	self processReportFor: anAccount .

	! !


!AccountSummaryReport methodsFor: 'main protocol' stamp: 'f 11/15/2022 21:02:24'!
processDeposit: aDeposit

	^'Depósito por ', aDeposit value asString.! !

!AccountSummaryReport methodsFor: 'main protocol' stamp: 'f 11/15/2022 21:01:37'!
processTransferDepositLeg: aTransferDepositLeg

	^'Entrada por transferencia de ', aTransferDepositLeg value asString.! !

!AccountSummaryReport methodsFor: 'main protocol' stamp: 'f 11/15/2022 21:03:32'!
processTransferWithdrawLeg: aTransferWithdrawLeg

	^'Salida por transferencia de ', aTransferWithdrawLeg value asString.! !

!AccountSummaryReport methodsFor: 'main protocol' stamp: 'f 11/15/2022 21:03:01'!
processWithdraw: aWithdraw

	^'Extracción por ', aWithdraw value asString.! !

!AccountSummaryReport methodsFor: 'main protocol' stamp: 'AK 11/17/2022 23:37:27'!
report
	^ report copy.! !

!AccountSummaryReport methodsFor: 'main protocol' stamp: 'AK 11/17/2022 23:41:11'!
reportAsString
	^ self linesAsString: report.! !


!AccountSummaryReport methodsFor: 'private' stamp: 'Ak 11/18/2022 14:39:43'!
processReportFor: anAccount

	anAccount transactions do:[ :aTransaction | 
		report addLast: (aTransaction processLineFor: self).
	].

	report addLast: ('Balance = ' , anAccount balance asString).
! !


!classDefinition: #PortfolioTreePrinterDetailedReport category: 'ServiciosFinancieros2Solucion'!
Report subclass: #PortfolioTreePrinterDetailedReport
	instanceVariableNames: 'tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!PortfolioTreePrinterDetailedReport methodsFor: 'private' stamp: 'Ak 11/18/2022 14:40:47'!
processReportFor: anAccount

	| auxCollection |
	
	anAccount accounts do:[ :anAccount1 | 
		auxCollection := (anAccount1 processTreeDetailed).
		auxCollection do: [ :aName |
				tree addLast: ('    ',aName).
			].
		].
	
	tree addFirst:(anAccount name).
	tree addLast: ('Balance = ', (anAccount balance) asString ).
	
	! !


!PortfolioTreePrinterDetailedReport methodsFor: 'initialization' stamp: 'Ak 11/18/2022 14:40:47'!
initializeWith: anAccount
	tree := OrderedCollection new.
	self processReportFor: anAccount.
	
	^self linesAsString: tree.
	! !


!classDefinition: #PortfolioTreePrinterReport category: 'ServiciosFinancieros2Solucion'!
Report subclass: #PortfolioTreePrinterReport
	instanceVariableNames: 'tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!PortfolioTreePrinterReport methodsFor: 'private' stamp: 'Ak 11/18/2022 14:40:47'!
processReportFor: anAccount

	| auxCollection |
	
	anAccount accounts do:[ :anAccount1 | 
		auxCollection := (anAccount1 processTree).
		auxCollection do: [ :aName |
				tree addLast: ('    ',aName).
			].
		].

	tree addFirst:(anAccount name).
	
! !


!PortfolioTreePrinterReport methodsFor: 'initialization' stamp: 'Ak 11/18/2022 14:40:47'!
initializeWith: anAccount
	tree := OrderedCollection new.
	self processReportFor: anAccount.
	
	^self linesAsString: tree.
	! !


!classDefinition: #TransferNetReport category: 'ServiciosFinancieros2Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'transferNetBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!TransferNetReport methodsFor: 'initialization' stamp: 'Ak 11/18/2022 14:38:38'!
initializeWith: anAccount

	transferNetBalance := 0*peso.
	
	self processReportFor: anAccount .
	
	^transferNetBalance.! !


!TransferNetReport methodsFor: 'main protocol' stamp: 'f 11/16/2022 19:25:17'!
processDeposit: aDeposit

	^transferNetBalance.

	! !

!TransferNetReport methodsFor: 'main protocol' stamp: 'f 11/16/2022 19:26:11'!
processTransferDepositLeg: aTransferDepositLeg

	^aTransferDepositLeg affectBalance: transferNetBalance .
! !

!TransferNetReport methodsFor: 'main protocol' stamp: 'f 11/16/2022 19:26:27'!
processTransferWithdrawLeg: aTransferWithdrawLeg

	^aTransferWithdrawLeg affectBalance: transferNetBalance  .
! !

!TransferNetReport methodsFor: 'main protocol' stamp: 'f 11/16/2022 19:25:26'!
processWithdraw: aWithdraw

	^transferNetBalance.
! !


!TransferNetReport methodsFor: 'private' stamp: 'Ak 11/18/2022 14:38:38'!
processReportFor: anAccount

	anAccount transactions do: [ :aTransaction |
		transferNetBalance := aTransaction processLineFor: self
	].! !


!classDefinition: #Transfer category: 'ServiciosFinancieros2Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros2Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
