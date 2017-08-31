:- begin_tests(about_logic_codes).
:- use_module(about_logic_codes).

test(and) :- and(true,true).

test(and, [fail]) :- and(true,false).
test(and, [fail]) :- and(false,false).
test(and, [fail]) :- and(false,true).

test(or) :- 
	or(true, false),
	or(true, true),
	or(false, true).
test(or, [fail]) :- or(false, false).	

test(nand) :- 
	nand(false, false),
	nand(true, false),
	nand(false, true).

test(nand, [fail]) :-
	nand(true, true).

test(nor) :- nor(false, false).

test(nor, [fail]) :-
	nor(true, false),
	nor(true, true),
	nor(false, true).

test(xor) :-
	xor(false, true),
	xor(true, false).

test(xor, [fail]) :- xor(true, true).
test(xor, [fail]) :- xor(false, false).

test(impl) :- 
	impl(true, true),
	impl(false, false),
	impl(false, true).

test(impl, [fail]) :- impl(true, false).

test(equ) :- 
	equ(true, true),
	equ(false, false).

test(equ, [fail]) :- equ(true, false).
test(equ, [fail]) :- equ(false, true).

test(table) :-
    table([A,B], and(A,or(A,B)), [[true, true, true],
                                  [true, fail, true],
                                  [fail, true, fail],
                                  [fail, fail, fail]]).
test(table) :-
    table([A,B,C], A and (B or C) equ A and B or A and C, [[true, true, true, true],
                                                               [true, true, fail, true],
                                                               [true, fail, true, true],
                                                               [true, fail, fail, true],
                                                               [fail, true, true, true],
                                                               [fail, true, fail, true],
                                                               [fail, fail, true, true],
                                                               [fail, fail, fail, true]]).

test(gray) :-
    gray(0, ['']),
    gray(1, ['0', '1']),
    gray(5, ['00000', '00001', '00011', '00010', '00110', '00111', '00101', '00100', '01100', '01101', '01111', '01110', '01010', '01011', '01001', '01000', '11000', '11001', '11011', '11010', '11110', '11111', '11101', '11100', '10100', '10101', '10111', '10110', '10010', '10011', '10001', '10000']).

test(gray) :-
    gray(13, C),
    statistics(inferences, InfStart),
    gray(13, C),
    statistics(inferences, InfEnd),
    Inf is InfEnd - InfStart,
    Inf < 100.



:- end_tests(about_logic_codes).
