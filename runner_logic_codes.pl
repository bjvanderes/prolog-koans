:- module(runner_logic_codes, [logic_go/0]).

run_koan(X,L) :-
	koan_helper(X, about_logic_codes:L).

logic_load :-
	[runner_helper],
	[about_logic_codes],
	load_test_files(about_logic_codes).

logic_go :-
	logic_load,
	logic_and,
	logic_or,
	logic_nand,
	logic_nor,
	logic_xor,
	logic_impl,
	logic_equ,
	logic_table,
	logic_gray,
	logic_huffman.

logic_and :-
	run_koan('Define a predicate which succeeds only if both arguments succeed (and)', and).
	
logic_or :-
	run_koan('Define a predicate which succeeds if either argument succeeds (or)', or).

logic_nand :- run_koan('Define the nand predicate', nand).

logic_nor :- run_koan('Define the nor predicate', nor).

logic_xor :- run_koan('Define the xor predicate', xor).

logic_impl :- run_koan('Define the impl predicate', impl).

logic_equ :- run_koan('Define the equ predicate for logical equivalence', equ).

logic_table :- run_koan('Make sure the logical predicates are defined as operators (lookup: op(...) with precedence similar to Java. Create the logic table for `Var1 Var2...VarX Expr`.', table).

logic_gray :- run_koan('Construct Gray codes and memoize to improve performance (Hint: assert, asserta, assertz)', gray).

logic_huffman :- run_koan('Learn more about huffman codes. Take list of frequencies per symbol [fr(Symbol, Frequency)] and generate list of huffman codes [hc(Symbol, Huffman-Code)]', huffman).