:- module(runner_binary_trees, [binary_trees_go/0]).

run_koan(X,L) :-
	koan_helper(X, about_binary_trees:L).

binary_trees_load :-
	[runner_helper],
	[about_binary_trees],
	load_test_files(about_binary_trees).

binary_trees_go :- binary_trees_load,
    binary_trees_is_tree,
    binary_trees_cbal_tree,
    binary_trees_symmetric_tree,
    binary_trees_construct_unbalanced_binary_tree,
    binary_trees_test_symmetric_unbalanced_binary_tree,
    binary_trees_sym_cbal_trees.

binary_trees_is_tree :- run_koan('Test whether the input is a tree as defined per official 99 problems', is_tree).

binary_trees_cbal_tree :- run_koan('Create a predicate that generates completely balanced trees for a given nr of nodes', cbal_tree).

binary_trees_symmetric_tree :- run_koan('Test whether a tree is symmetric. Hint: Test whether sub trees are mirror images.', symmetric_tree).

binary_trees_construct_unbalanced_binary_tree :- run_koan('Construct a binary tree naively by adding subsequent elements from list.', construct_unbalanced_binary_tree).

binary_trees_test_symmetric_unbalanced_binary_tree :- run_koan('Use test_symmetric from previous exercise to to test whether a list generates a symmetric unbalanced binary tree.', test_symmetric_unbalanced_binary_tree).

binary_trees_sym_cbal_trees :- run_koan('\c
    Apply the generate-and-test paradigm to construct all symmetric, completely balanced binary trees with a given number of nodes.\c
    \nHow many such trees are there with 57 nodes? Investigate about how many solutions there are for a given number of nodes? What if the number is even? Write an appropriate predicate.'
    , sym_cbal_trees).
