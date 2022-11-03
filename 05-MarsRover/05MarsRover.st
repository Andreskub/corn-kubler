!classDefinition: #MarsRoverTests category: '05MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'marsRoverFacingNorth marsRoverFacingSouth marsRoverFacingEast marsRoverFacingWest'
	classVariableNames: ''
	poolDictionaries: ''
	category: '05MarsRover'!

!MarsRoverTests methodsFor: 'initialize' stamp: 'AK 11/2/2022 19:46:03'!
setUp

	marsRoverFacingNorth := MarsRover inPostion: 0@0 andFacingDirection: North new.
	marsRoverFacingEast := MarsRover inPostion: 0@0 andFacingDirection: East new.
	marsRoverFacingSouth := MarsRover inPostion: 0@0 andFacingDirection: South new.
	marsRoverFacingWest := MarsRover inPostion: 0@0 andFacingDirection: West new.! !


!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 19:17:51'!
test01MarsRoverItitializeInPositionCorrectly
	
	| marsRover |
	
	marsRover := MarsRover inPostion: 0@0 andFacingDirection: ''.
	
	self assert: (marsRover isInPosition: 0@0).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 19:49:11'!
test02MarsRoverItitializeInPositionAndDirectionCorrectly

	| marsRover |
	
	marsRover := MarsRover inPostion: 0@0 andFacingDirection: North new.
	
	self assert: (marsRover isInPosition: 0@0).
	self assert: (marsRover isFacingDirection: North).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 20:14:27'!
test03MarsRoverRotatesRightCorrectly
	
	| marsRover |

	marsRover := marsRoverFacingNorth executeNavigationCommands: 'r'.
	
	self assert: (marsRover isInPosition: 0@0).
	self assert: (marsRover isFacingDirection: East ).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 20:14:54'!
test04MarsRoverRotatesLeftCorrectly
	
	| marsRover |

	marsRover := marsRoverFacingNorth executeNavigationCommands: 'l'.
	
	self assert: (marsRover isInPosition: 0@0).
	self assert: (marsRover isFacingDirection: West ).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 20:15:40'!
test05MarsRoverMovesForwardCorrectly
	
	| marsRover |

	marsRover := marsRoverFacingNorth executeNavigationCommands: 'f'.
	
	self assert: (marsRover isInPosition: 0@1).
	self assert: (marsRover isFacingDirection: North ).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 20:20:32'!
test06MarsRoverMovesBackwardsCorrectly
	
	| marsRover |

	marsRover := marsRoverFacingNorth executeNavigationCommands: 'b'.
	
	self assert: (marsRover isInPosition: 0@-1).
	self assert: (marsRover isFacingDirection: North ).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 20:22:53'!
test07MarsRoverMovesForwardAndRotatesLeftCorrectly
	
	| marsRover |

	marsRover := marsRoverFacingNorth executeNavigationCommands: 'fl'.
	
	self assert: (marsRover isInPosition: 0@1).
	self assert: (marsRover isFacingDirection: West ).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 20:24:47'!
test08MarsRoverMovesAndRotatesMultipleTimesCorrectly
	
	| marsRover |

	marsRover := marsRoverFacingNorth executeNavigationCommands: 'rfrfflb'.
	
	self assert: (marsRover isInPosition: 0@-2).
	self assert: (marsRover isFacingDirection: East ).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 21:02:14'!
test09InvalidNavigationCommandThrowsError
	
	self should: [ marsRoverFacingNorth executeNavigationCommands: 'rwrfflb' ] 
		raise: Error 
        			withExceptionDo: [ :anError |
            				self assert: SystemNavigation invalidCommandErrorDescription equals: anError messageText ].
! !

!MarsRoverTests methodsFor: 'tests' stamp: 'AK 11/2/2022 20:42:21'!
test10EmptyNavigationCommandDoesNotMoveMarsRover
	
	| marsRover |

	marsRover := marsRoverFacingNorth executeNavigationCommands: ''.
	
	self assert: (marsRover isInPosition: 0@0).
	self assert: (marsRover isFacingDirection: North ).
! !


!classDefinition: #Compass category: '05MarsRover'!
Object subclass: #Compass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05MarsRover'!

!Compass methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:34:15'!
moveBackwards
	^ self subclassResponsibility .! !

!Compass methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:34:07'!
moveForward
	^ self subclassResponsibility .! !

!Compass methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:33:19'!
rotate90DegreesLeft
	^ self subclassResponsibility .! !

!Compass methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:33:09'!
rotate90DegreesRight
	^ self subclassResponsibility .! !


!classDefinition: #East category: '05MarsRover'!
Compass subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05MarsRover'!

!East methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:35:23'!
moveBackwards
	^ (-1@0) .! !

!East methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:37:51'!
moveForward
	^ (1@0) .! !

!East methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:39:38'!
rotate90DegreesLeft
	^ North new.! !

!East methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:41:35'!
rotate90DegreesRight
	^ South new.! !


!classDefinition: #North category: '05MarsRover'!
Compass subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05MarsRover'!

!North methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:36:28'!
moveBackwards
	^ (0@-1) .! !

!North methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:38:17'!
moveForward
	^ (0@1) .! !

!North methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:39:51'!
rotate90DegreesLeft
	^ West new.! !

!North methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:41:51'!
rotate90DegreesRight
	^ East new.! !


!classDefinition: #South category: '05MarsRover'!
Compass subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05MarsRover'!

!South methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:36:53'!
moveBackwards
	^ (0@1) .! !

!South methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:38:31'!
moveForward
	^ (0@-1) .! !

!South methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:40:01'!
rotate90DegreesLeft
	^ East new.! !

!South methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:42:04'!
rotate90DegreesRight
	^ West new.! !


!classDefinition: #West category: '05MarsRover'!
Compass subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '05MarsRover'!

!West methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:37:21'!
moveBackwards
	^ (1@0) .! !

!West methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:38:51'!
moveForward
	^ (-1@0) .! !

!West methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:40:12'!
rotate90DegreesLeft
	^ South new.! !

!West methodsFor: 'navigation' stamp: 'AK 11/2/2022 19:42:19'!
rotate90DegreesRight
	^ North new.! !


!classDefinition: #MarsRover category: '05MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction systemNavigation'
	classVariableNames: ''
	poolDictionaries: ''
	category: '05MarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'AK 11/2/2022 20:50:48'!
inPostion: aPosition andDirection: aDirection

	position := aPosition .
	
	direction := aDirection .
	
	systemNavigation := SystemNavigation new.

	! !


!MarsRover methodsFor: 'testing' stamp: 'AK 11/2/2022 19:50:06'!
isFacingDirection: aDirection

	^ direction isKindOf: aDirection .
	! !

!MarsRover methodsFor: 'testing' stamp: 'AK 11/2/2022 19:15:52'!
isInPosition: aPosition
	
	^ position = aPosition.! !


!MarsRover methodsFor: 'navigation' stamp: 'AK 11/2/2022 20:55:33'!
executeNavigationCommands: aStringOfCommands
	
	systemNavigation processNavigationCommands: aStringOfCommands forMarsRover: self.! !

!MarsRover methodsFor: 'navigation' stamp: 'AK 11/2/2022 20:58:33'!
moveBackwards
	position := position + (direction moveBackwards) .
! !

!MarsRover methodsFor: 'navigation' stamp: 'AK 11/2/2022 20:58:09'!
moveForward
	position := position + (direction moveForward) .
! !

!MarsRover methodsFor: 'navigation' stamp: 'AK 11/2/2022 20:57:46'!
rotateLeft
	direction := direction rotate90DegreesLeft .
! !

!MarsRover methodsFor: 'navigation' stamp: 'AK 11/2/2022 20:57:30'!
rotateRight
	direction := direction rotate90DegreesRight.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: '05MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AK 11/2/2022 19:10:53'!
inPostion: aPosition andFacingDirection: aDirection

	^MarsRover new inPostion: aPosition andDirection: aDirection.! !


!classDefinition: #SystemNavigation category: '05MarsRover'!
Object subclass: #SystemNavigation
	instanceVariableNames: 'validCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: '05MarsRover'!

!SystemNavigation methodsFor: 'initialize' stamp: 'AK 11/2/2022 20:51:10'!
initialize

	validCommands := {'r'. 'l'. 'f'. 'b'}.! !


!SystemNavigation methodsFor: 'navigation' stamp: 'AK 11/2/2022 21:01:33'!
isValidCommand: aCommand

	^ validCommands includes: aCommand .! !

!SystemNavigation methodsFor: 'navigation' stamp: 'AK 11/2/2022 20:59:41'!
processNavigationCommands: aStringOfCommands forMarsRover: aMarsRover

	| command |
	
	aStringOfCommands do: [ :aCharacter |
		command := String with: aCharacter.
		
		(self isValidCommand: command) ifFalse: [self error: SystemNavigation invalidCommandErrorDescription].
		
		command = 'r' ifTrue: [ aMarsRover rotateRight ].
		command = 'l' ifTrue: [ aMarsRover rotateLeft ].
		command = 'f' ifTrue: [ aMarsRover moveForward ].
		command = 'b' ifTrue: [ aMarsRover moveBackwards ].
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemNavigation class' category: '05MarsRover'!
SystemNavigation class
	instanceVariableNames: ''!

!SystemNavigation class methodsFor: 'error descriptions' stamp: 'AK 11/2/2022 20:54:12'!
invalidCommandErrorDescription

	^ 'invalid input command!!' . ! !
