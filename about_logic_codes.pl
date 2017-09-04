:- module(about_logic_codes,[and/2, or/2, nand/2, nor/2, xor/2, impl/2, equ/2,
op(900, fy, not), op(910, yfx, and), op(910, yfx, nand), op(920, yfx, or), op(920, yfx, nor),
op(930, yfx, impl), op(930, yfx, equ), op(930, yfx, xor), permute_truth_vals/3, table/3,
gray/2, huffman_tree/2, huffman_codes_from_tree/3, huffman/2]).


and(A, B) :- A, B.

or(A, _) :- A, !.
or(_, B) :- B.

nand(A, B) :- not(and(A, B)).

nor(A, B) :- not(or(A, B)).

xor(A, B) :- and(nand(A, B), or(A, B)).

impl(A, B) :- or(not(A), B).

equ(A, B) :- and(impl(A, B), impl(B, A)).



bind(true).
bind(fail).

permute_truth_vals([], Expr, [true]) :- Expr.
permute_truth_vals([], Expr, [fail]) :- not(Expr).
permute_truth_vals([Var | Vars], Expr, [Var | Sols]) :- bind(Var), permute_truth_vals(Vars, Expr, Sols).

table(Var, Expr, Table) :- aggregate_all(bag(Sol), permute_truth_vals(Var, Expr, Sol), Table).

:- dynamic lookup_gray/2.

gray(0, ['']) :- !.
gray(N, C) :- N > 0,
    lookup_gray(N, C), !.
gray(N, C) :- N > 0, Nm1 is N - 1,
    gray(Nm1, Cm1),
    maplist(atom_concat('0'), Cm1, Cm1Prepend0),
    reverse(Cm1, ReverseCm1),
    maplist(atom_concat('1'), ReverseCm1, ReverseCm1Prepend1),
    append(Cm1Prepend0, ReverseCm1Prepend1, C),
    asserta(lookup_gray(N, C)).

huffman_tree([Frq], Frq) :- !.
huffman_tree(Frq, T) :- sort(2, @<, Frq, [fr(V1, F1), fr(V2, F2) |FrqSs]),
    F1pF2 is F1 + F2,
    huffman_tree([fr(br(fr(V1, F1), fr(V2, F2)), F1pF2) | FrqSs], T).

huffman_codes_from_tree(fr(br(L, R), _), Hc, PrependCode) :-
    atom_concat(PrependCode, '0', PrependCodeL),
    huffman_codes_from_tree(L, HcL, PrependCodeL),
    atom_concat(PrependCode, '1', PrependCodeR),
    huffman_codes_from_tree(R, HcR, PrependCodeR),
    append(HcL, HcR, Hc),
    !.
huffman_codes_from_tree(fr(V, _), [hc(V, PrependCode)], PrependCode).

huffman(Frq, HcL) :- huffman_tree(Frq, HT), huffman_codes_from_tree(HT, HcL, '').

