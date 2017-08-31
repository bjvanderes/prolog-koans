:- module(about_logic_codes,[and/2, or/2, nand/2, nor/2, xor/2, impl/2, equ/2,
op(900, fy, not), op(910, yfx, and), op(910, yfx, nand), op(920, yfx, or), op(920, yfx, nor),
op(930, yfx, impl), op(930, yfx, equ), op(930, yfx, xor), permute_truth_vals/3, table/3,
gray/2]).


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
