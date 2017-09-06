:- module(runner_binary_trees, [binary_trees_go/0]).

run_koan(X,L) :-
	koan_helper(X, about_binary_trees:L).

binary_trees_load :-
	[runner_helper],
	[about_binary_trees],
	load_test_files(about_binary_trees).

binary_trees_go :- binary_trees_load,
    binary_trees_is_tree.

binary_trees_is_tree :- run_koan('Test whether the input is a tree as defined per official 99 problems', is_tree).