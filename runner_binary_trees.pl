:- module(runner_binary_trees, [binary_trees_go/0]).

run_koan(X,L) :-
	koan_helper(X, about_binary_trees:L).

binary_trees_load :-
	[runner_helper],
	[about_binary_trees],
	load_test_files(about_binary_trees).

binary_trees_go :- binary_trees_load.

% logic_and :- run_koan('Define a predicate which succeeds only if both arguments succeed (and)', and).