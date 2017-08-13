:- module(about_lists, 
	[my_first/2, my_last/2, my_penultimate/2, my_element_at/3,
	my_number_of/2, my_reverse/2, is_palindrome/1, my_flatten/2,
	my_compress/2, my_pack/2, my_encode/2, my_encode_modified/2,
	my_encode_reverse/2, my_encode_direct/2, my_duplicate/2,
	my_duplicate_for_n/3, my_drop/3, my_split/4, my_slice/4,
	my_rotate/3, remove_at/4, insert_at/4, range/3, extract_rnd/3,
	select_rnd_int/3, rnd_permutation/2, combination/3, extract_combination/4,
	group234/4, group/3, lsort/2, lfsort/2]).

my_first(X, [X|_]) :- true.

my_last(X, [X]).
my_last(X,[_|T]) :- my_last(X, T).

my_penultimate(X, [X, _]).
my_penultimate(X, [_, Y|Ys]) :- my_penultimate(X, [Y|Ys]).

my_element_at(X,[X|_],1).
my_element_at(X,[_|T],N) :- N > 1, NM1 is N - 1, my_element_at(X, T, NM1).

my_number_of(0,[]).
my_number_of(N,[_|T]) :- my_number_of(NM1, T), N is NM1 + 1.


my_reverse(X, R) :- my_rev(X, R, []).

my_rev([], X, X).
my_rev([XH|XT], R, Acc) :- my_rev(XT, R, [XH|Acc]).


is_palindrome(X) :- my_reverse(X,X).

my_flatten(X,[X]) :- \+ is_list(X).
my_flatten([],[]).
my_flatten([X|Xs],Zs) :- my_flatten(X,Y), my_flatten(Xs,Ys), append(Y,Ys,Zs).

/*
* my_flt([], F, F).
* my_flt([[XSH|XST]|XT], F, Acc) :- append(XST, XT, FT), append(Acc, [XSH] , AppendAcc), my_flt(FT, F, AppendAcc).
* my_flt([XH|XT], F, Acc) :- append(Acc, [XH], AppendAcc), my_flt(XT, F, AppendAcc).
*/

my_compress([], []).
my_compress([X], [X]).
my_compress([X | [X | XsT]], Y) :- my_compress([X | XsT], Y).
my_compress([X | Y], [X | Yc]) :- my_compress(Y, Yc).


my_pack([],[]).
my_pack([X], [[X]]).
my_pack([X | [X | Ys]], [[X, X | Xp] | Yp]) :- my_pack([X | Ys], [[X | Xp] | Yp]).
my_pack([X | [Y | Ys]], [[X] | Yp]) :- X \== Y, my_pack([Y | Ys], Yp).

my_encode(X, E) :- my_pack(X, P), encode_packed_list(P, E).
encode_packed_list([], []).
encode_packed_list([[P2 | P2s] | P1s], [[LP1, P2] | Es]) :- length([P2 | P2s], LP1), encode_packed_list(P1s, Es).

my_encode_modified(X, EM) :- my_encode(X, E), single_elements_flat(E, EM).
single_elements_flat([], []).
single_elements_flat([[1, X2s] | X1s], [X2s | Fs]) :- single_elements_flat(X1s, Fs).
single_elements_flat([X1 | X1s], [X1 | Fs]) :- single_elements_flat(X1s, Fs).

my_encode_reverse([], []).
my_encode_reverse([V | Es], [V | Ds]) :- \+ is_list(V), my_encode_reverse(Es, Ds).
my_encode_reverse([[N, V] | Es], D) :- constant_list(N, V, L), my_encode_reverse(Es, Ds), append(L, Ds, D).
constant_list(0, _, []).
constant_list(N, V, [V | Ls]) :- N > 0, Nm1 is N - 1, constant_list(Nm1, V, Ls).

my_encode_direct_m([], []).
my_encode_direct_m([X], [[1, X]]).
my_encode_direct_m([X | [X | X1s]], [[Np1, X] | Es]) :- my_encode_direct_m([X | X1s], [[N, X] | Es]), Np1 is N + 1.
my_encode_direct_m([X | [Y | X1s]], [[1, X] | Es]) :- X \== Y, my_encode_direct_m([Y | X1s], Es).

my_encode_direct(X, E) :- my_encode_direct_m(X, EM), single_elements_flat(EM, E).

my_duplicate([], []).
my_duplicate([X | Xs], [X, X | Ds]) :- my_duplicate(Xs, Ds).

my_duplicate_for_n_first_solution([], _, []).
my_duplicate_for_n_first_solution([X | Xs], N, D) :- constant_list(N, X, DV), my_duplicate_for_n(Xs, N, Ds), append(DV, Ds, D).

my_duplicate_for_n(L, N, D) :- my_duplicate_for_n(L, N, D, N).
my_duplicate_for_n([], _, [], _).
my_duplicate_for_n([_ | Ls], N, D, 0) :- my_duplicate_for_n(Ls, N, D, N).
my_duplicate_for_n([L | Ls], N, [L | Ds], K) :- K > 0, Km1 is K - 1, my_duplicate_for_n([L | Ls], N, Ds, Km1).

my_drop(L, K, D) :- my_drop_trav(L, K, D, K).
my_drop_trav_mod([], _, [], _).
my_drop_trav_mod([_ | Xs], K, Ds, N) :- M is mod(N, K), M =:= 0, Np1 is N+1, my_drop_trav_mod(Xs, K, Ds, Np1).
my_drop_trav_mod([X | Xs], K, [X | Ds], N) :- M is mod(N, K), M > 0, Np1 is N +1, my_drop_trav_mod(Xs, K, Ds, Np1).

my_drop_trav([], _, [], _).
my_drop_trav([_ | Xs], N, Ds, 1) :- my_drop_trav(Xs, N, Ds, N).
my_drop_trav([X | Xs], N, [X | Ds], K) :- K > 1, Km1 is K - 1, my_drop_trav(Xs, N, Ds, Km1).

my_split(X, 0, [], X).
my_split([X | Xs], N, [X | Hs], T) :- N > 0, Nm1 is N - 1, my_split(Xs, Nm1, Hs, T).

my_slice([X | _], 1, 1, [X]).
my_slice([X | Xs], 1, Ei, [X | Rs]) :- Ei > 1, EiM1 is Ei - 1, my_slice(Xs, 1, EiM1, Rs).
my_slice([_ | Xs], Si, Ei, R) :- Si > 0, SiM1 is Si - 1, Ei > 1, EiM1 is Ei - 1, my_slice(Xs, SiM1, EiM1, R).

my_rotate_direct(X, 0, X).
my_rotate_direct([X | Xs], N, RN) :- N > 0, Nm1 is N - 1, append(Xs, [X], R1), my_rotate(R1, Nm1, RN).

my_rotate(X, 0, X).
my_rotate(X, N, RN) :- length(X, NX), NmodNX is N mod NX, my_split(X, NmodNX, XH, XT), append(XT, XH, RN).

remove_at_split(_, X, 0, X).
remove_at_split(E, L, NE, R) :- NE > 0, NEm1 is NE - 1, my_split(L, NEm1, LH, [E | LTs]), append(LH, LTs, R).

remove_at(X, [X | Xs], 1, Xs) :- !.
remove_at(E, [Y | Xs], NE, [Y | Rs]) :- NE > 1, NEm1 is NE - 1, remove_at(E, Xs, NEm1, Rs).

insert_at(E, L, NE, R) :- remove_at(E, R, NE, L).

range(N, N, [N]) :- !.
range(S, E, [S | Rs]) :- S < E, Sp1 is S + 1, range(Sp1, E, Rs).

extract_rnd(_, 0, []) :- !.
extract_rnd(L, N, [RndE | Rs]) :- N > 0, Nm1 is N - 1,
    length(L, NL),
    Rnd is random(NL) + 1,
    remove_at(RndE, L, Rnd, NxtL),
    extract_rnd(NxtL, Nm1, Rs).

select_rnd_int(X, N, Res) :- range(1, N, RL), extract_rnd(RL, X, Res).


rnd_permutation(L, R) :- length(L, NL), extract_rnd(L, NL, R).

combination(0, _, []).
combination(N, [L | Ls], [L | Cs]) :- N > 0, Nm1 is N - 1, combination(Nm1, Ls, Cs).
combination(N, [_ | Ls], C) :- N > 0, combination(N, Ls, C).

extract_combination(0, L, [], L).
extract_combination(N, [L | Ls], [L | Cs], Rest) :- N > 0, Nm1 is N - 1, extract_combination(Nm1, Ls, Cs, Rest).
extract_combination(N, [L | Ls], C, [L | RestTail]) :- N > 0, extract_combination(N, Ls, C, RestTail).

group234(L, G1, G2, G3) :- extract_combination(2, L, G1, L1), extract_combination(3, L1, G2, L2), extract_combination(4, L2, G3, _).

group(_, [], _).
group(L, [S | Ss], [G | Gs]) :- extract_combination(S, L, G, Ls), group(Ls, Ss, Gs).

lsort([], []) :- !.
lsort([X], [X]) :- !.
lsort([X, Y], [X, Y]) :- length(X, NX), length(Y, NY), NX < NY.
lsort([X, Y], [Y, X]) :- length(X, NX), length(Y, NY), NX >= NY.
lsort([X | Xs], S) :-
    length(X, NX),
    partition_lengths(NX, Xs, L, G),
    lsort(L, SL),
    lsort(G, SG),
    append(SL, [X | SG], S).


partition_lengths(_, [], [], []) :- !.
partition_lengths(N, [X | Xs], L, [X | Gs]) :- length(X, NX), NX >= N, partition_lengths(N, Xs, L, Gs).
partition_lengths(N, [X | Xs], [X | Ls], G) :- length(X, NX), NX < N, partition_lengths(N, Xs, Ls, G).


lfsort(X, F) :- group_by_length(X, G), lsort(G, S), flatten_1d(S, F).

group_by_length(X, G) :- lsort(X, S), group_sorted_by_length(S, G).

group_sorted_by_length([X], [[X]]).
group_sorted_by_length([S | [S1 | S1s]], [[S | GS1s] | GSs]) :- length(S, NS), length(S1, NS1), NS == NS1, group_sorted_by_length([S1 | S1s], [GS1s | GSs]).
group_sorted_by_length([S | [S1 | S1s]], [[S] | GSs]) :- length(S, NS), length(S1, NS1), NS \== NS1, group_sorted_by_length([S1 | S1s], GSs).

flatten_1d([], []).
flatten_1d([[X1] | Xs], [X1 | F]) :- flatten_1d(Xs, F).
flatten_1d([[X1 | X1S] | Xs], [X1 | F]) :- flatten_1d([X1S | Xs], F).

#group_into_by_length(X, [[X]]).
#group_into_by_length(X, [[X, G1 | _] | _]) :- length(X, NX), length(G1, NG1), NX == NG1.
#group_into_by_length(X, [[G1 | _] | Gs]) :- length(X, NX), length(G1, NG1), NX \== NG1, group_into_by_length(X, Gs).