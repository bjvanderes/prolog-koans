:- begin_tests(about_binary_trees).
:- use_module(about_binary_trees).

test(is_tree) :-
    is_tree(t(a,t(b,nil,nil),nil)).
test(is_tree, [fail]) :-
    is_tree(t(a,t(b,nil,nil))).

test(cbal_tree) :-
    aggregate_all(bag(Sol), cbal_tree(1, Sol), [t('x', nil, nil)]).
test(cbal_tree) :-
    aggregate_all(bag(Sol), cbal_tree(4, Sol), [t(x, t(x, nil, nil), t(x, nil, t(x, nil, nil))), t(x, t(x, nil, nil), t(x, t(x, nil, nil), nil)), t(x, t(x, nil, t(x, nil, nil)), t(x, nil, nil)), t(x, t(x, t(x, nil, nil), nil), t(x, nil, nil))]).

test(symmetric_tree) :-
    symmetric_tree(t('x', nil, nil)),
    symmetric_tree(t('x', t('a', t('b', nil, nil), nil), t('b', nil, t('z', nil, nil)))),
    symmetric_tree(t('x', t('x', nil, t('x', nil, t('x', nil, t('x', nil, t('x', nil, t('x', nil, t('x', nil, nil))))))), t('x', t('x', t('x', t('x', t('x', t('x', t('x', nil, nil), nil), nil), nil), nil), nil), nil))).
test(symmetric_tree, [fail]) :-
    symmetric_tree(t('x', t('x', nil, nil), nil)),
    symmetric_tree(t(x, t(x, t(x, nil, nil), t(x, nil, nil)), t(x, t(x, nil, nil), t(x, nil, t(x, nil, nil))))).

test(construct_unbalanced_binary_tree) :-
    construct_unbalanced_binary_tree([3,2,5,7,1], t(3, t(2, t(1, nil, nil), nil), t(5, nil, t(7, nil, nil)))),
    construct_unbalanced_binary_tree([5,3,18,1,4,12,21], t(5, t(3, t(1, nil, nil), t(4, nil, nil)), t(18, t(12, nil, nil), t(21, nil, nil)))),
    construct_unbalanced_binary_tree([1,2,3,4,5], t(1, nil, t(2, nil, t(3, nil, t(4, nil, t(5, nil, nil)))))).

test(test_symmetric_unbalanced_binary_tree) :-
    test_symmetric_unbalanced_binary_tree([5,3,18,1,4,12,21]).
test(test_symmetric_unbalanced_binary_tree, [fail]) :-
    test_symmetric_unbalanced_binary_tree([3,2,5,7,4]).

test(sym_cbal_trees) :-
    sym_cbal_trees(5, [t(x, t(x, nil, t(x, nil, nil)), t(x, t(x, nil, nil), nil)), t(x, t(x, t(x, nil, nil), nil), t(x, nil, t(x, nil, nil)))]),
    sym_cbal_trees(7, [t(x, t(x, t(x, nil, nil), t(x, nil, nil)), t(x, t(x, nil, nil), t(x, nil, nil)))]).

test(sym_cbal_trees) :-
    forall(between(1, 10, R), (Rx2 is R * 2, sym_cbal_trees(Rx2, []))).

test(sym_cbal_trees) :-
    sym_cbal_trees(57, TList), length(TList, 256).

test(hbal_tree) :-
    aggregate_all(bag(T), hbal_tree(2, T), [t(x, t(x, nil, nil), t(x, nil, nil)), t(x, t(x, nil, nil), nil), t(x, nil, t(x, nil, nil))]).

test(hbal_tree) :-
    aggregate_all(count, hbal_tree(4, T), 315).

:- end_tests(about_binary_trees).