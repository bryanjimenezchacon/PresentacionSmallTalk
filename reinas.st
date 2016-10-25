Object subclass: #PiezaNula
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'NReinas'!

PiezaNula subclass: #Pieza
    instanceVariableNames: 'fila columna vecino filas'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'NReinas'!
! !

Pieza subclass: #Torre
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'NReinas'!
! !

Torre subclass: #Reina
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'NReinas'!
! !

!PiezaNula methodsFor: 'reinas'!

mover
    ^false
!

amenaza: prueba
    ^false
!

do: aBlock

    | resultado |
    [ resultado := self next. resultado notNil ] whileTrue: [
	aBlock value: resultado
    ]
!

resultado
    ^OrderedCollection new
!

next
    ^self mover
	ifTrue: [ self resultado ]
	ifFalse: [ nil ]
! !

!Pieza class methodsFor: 'prueba'!

prueba: side
    | line n |
    (line := String new: side * 2 + 1)
	atAll: (1 to: side * 2 + 1 by: 2) put: $|;
	atAll: (2 to: side * 2 + 1 by: 2) put: $_.

    n := 0.
    (self tablero: side) do: [ :resultado |
	n := n + 1.
	Transcript
	    space;
	    next: side * 2 - 1 put: $_;
	    nl.

	resultado do: [:x |
    	    line at: x + x put: $*.
    	    Transcript nextPutAll: line; nl.
    	    line at: x + x put: $_.
	].
	Transcript nl.
    ].
    Transcript nl.
    ^n! !

!Pieza class methodsFor: 'instance creation'!

tablero: n
    ^(1 to: n) inject: PiezaNula new into: [ :vecino :columna |
	self new
	    setColumn: columna
	    filas: n
	    vecino: vecino
    ]
! !

!Pieza methodsFor: 'private'!

setColumn: aNumber filas: n vecino: aPieza
    columna := aNumber.
    filas := n.
    vecino := aPieza.
    fila := 0.
    
    self vecino mover.
    ^self
!

avanza
    ^fila = filas
	ifTrue: [ fila := 1. self vecino mover ]
	ifFalse: [ fila := fila + 1. true ].
!

fila
    ^fila
!

columna
    ^columna
!

vecino
    ^vecino
! !

!Pieza methodsFor: 'inherited'!

amenaza: prueba
    self subclassResponsibility
!

mover
    [   self avanza ifFalse: [ ^false ].
	self vecino amenaza: self
    ] whileTrue: [ ].
    ^true
!

resultado
    ^self vecino resultado
	addLast: fila;
	yourself
! !



!Reina methodsFor: 'inherited'!

amenaza: prueba

    | columnaDifference filaDifference |
    columnaDifference := (prueba columna - self columna) abs.
    filaDifference := (prueba fila - self fila) abs.

    filaDifference = 0			ifTrue: [ ^true ].
    filaDifference = columnaDifference	ifTrue: [ ^true ].

    ^self vecino amenaza: prueba
! !

"	Prueba:		"	"Resultado	"


"	^Reina prueba: 3!		"	"0	"
"	^Reina prueba: 4!		"	"2	"
"	^Reina prueba: 8!		"	"92	"

^Reina prueba: 4!
