:- module(about_binary_trees,
	[is_tree/1]).

is_tree(nil).
is_tree(t(_, STL, STR)) :- is_tree(STL), is_tree(STR).
