:- begin_tests(about_binary_trees).
:- use_module(about_binary_trees).

test(is_tree) :-
    is_tree(t(a,t(b,nil,nil),nil)).
test(is_tree, [fail]) :-
    is_tree(t(a,t(b,nil,nil))).

:- end_tests(about_binary_trees).