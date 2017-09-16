:- module(about_binary_trees,
	[is_tree/1, cbal_tree/2, symmetric_tree/1, mirrored_tree/2, construct_unbalanced_binary_tree/2,
	test_symmetric_unbalanced_binary_tree/1, sym_cbal_trees/2, hbal_tree/2]).

is_tree(nil).
is_tree(t(_, STL, STR)) :- is_tree(STL), is_tree(STR).

cbal_tree(0, nil).
cbal_tree(1, t('x', nil, nil)).
cbal_tree(NrNodes, t('x', STL, STR)) :-
    NrNodes > 1,
    NrNodesM1 is NrNodes - 1,
    NrNodesSTL is NrNodesM1 // 2,
    NrNodesSTR is NrNodesM1 - NrNodesSTL,
    cbal_tree(NrNodesSTL, STL),
    cbal_tree(NrNodesSTR, STR).
cbal_tree(NrNodes, t('x', STL, STR)) :-
    NrNodes > 1,
    NrNodes mod 2 =:= 0,
    NrNodesM1 is NrNodes - 1,
    NrNodesSTL is (NrNodesM1 // 2) + 1,
    NrNodesSTR is NrNodesM1 - NrNodesSTL,
    cbal_tree(NrNodesSTL, STL),
    cbal_tree(NrNodesSTR, STR).

mirrored_tree(nil, nil).
mirrored_tree(t(_, TSTL, TSTR), t(_, MSTL, MSTR)) :- mirrored_tree(TSTL, MSTR), mirrored_tree(TSTR, MSTL).

symmetric_tree(nil).
symmetric_tree(t(_, STL, STR)) :- mirrored_tree(STL, STR).

add(X, nil, t(X, nil, nil)) :- !.
add(X, t(R, TSTL, TSTR), t(R, NewTSTL, TSTR)) :- X @< R, !, add(X, TSTL, NewTSTL).
add(X, t(R, TSTL, TSTR), t(R, TSTL, NewTSTR)) :- X @> R, !, add(X, TSTR, NewTSTR).

construct_in_reverse([], nil).
construct_in_reverse([X | Xs], T) :- construct_in_reverse(Xs, TPrev), add(X, TPrev, T).

construct_unbalanced_binary_tree(L, T) :- reverse(L, LReverse), construct_in_reverse(LReverse, T).

test_symmetric_unbalanced_binary_tree(L) :- construct_unbalanced_binary_tree(L, T), symmetric_tree(T).

sym_cbal_trees(NrNodes, TList) :- aggregate_all(bag(T), (cbal_tree(NrNodes, T), symmetric_tree(T)), TList).

hbal_tree(0, nil) :- !.
hbal_tree(1, t(x, nil, nil)) :- !.
hbal_tree(H, t(x, STL, STR)) :- H > 1,
    Hm1 is H - 1, Hm2 is H - 2,
    distr(Hm1, Hm2, HSTL, HSTR),
    hbal_tree(HSTL, STL), hbal_tree(HSTR, STR).

distr(D1,_,D1,D1).
distr(D1,D2,D1,D2).
distr(D1,D2,D2,D1).

min_nodes(0, 0) :- !.
min_nodes(1, 1) :- !.
min_nodes(H, N) :- H > 1,
    Hm1 is H - 1, Hm2 is H - 2,
    min_nodes(Hm1, NHm1), min_nodes(Hm2, NHm2),
    N is NHm1 + NHm2 + 1.

max_height(N, H)