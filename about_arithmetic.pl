:- module(about_arithmetic, 
	[is_prime/1, prime_factors/2, prime_factors_multiplicity/2,
	range_prime/3, goldbach_conjecture/2, gcd/3, coprime/2, euler_totient_phi/2,
	phi_improved/2, compare_phi/1, list_goldbach_compositions/3]).

:- use_module(library(lambda)).
:- use_module(about_lists).


is_prime(N) :- SQRT_N is floor(sqrt(N)), \+ has_factors(N, SQRT_N).

has_factors(N, F) :- F > 1, N mod F =:= 0.
has_factors(N, F) :- F > 1, Fm1 is F - 1, has_factors(N, Fm1).



% Make arithmetic function
gcd(A, A, A) :- !.
gcd(1, _, 1) :- !.
gcd(_, 1, 1) :- !.
gcd(L, S, G) :- S > 1, L > S, !, gcd(S, L, G).
gcd(S, L, G) :- S > 1, L > S, !, D is L - S, gcd(S, D, G).

coprime(A, B) :- gcd(A, B, 1).

% Arithmetic
euler_totient_phi(M, Cnt) :- euler_totient_phi_(M, 1, Cnt).
euler_totient_phi_(M, M, 0).
euler_totient_phi_(M, L, Cnt) :- L < M, coprime(L, M), Lp1 is L + 1, euler_totient_phi_(M, Lp1, CntM1), Cnt is CntM1 + 1.
euler_totient_phi_(M, L, Cnt) :- L < M, \+ coprime(L, M), Lp1 is L + 1, euler_totient_phi_(M, Lp1, Cnt).


prime_factors(M, R) :- prime_factors_greater_equal_than(2, M, R).
prime_factors_greater_equal_than(_, 1, []) :- !.
prime_factors_greater_equal_than(2, M, R) :- coprime(2, M), prime_factors_greater_equal_than(3, M, R).
prime_factors_greater_equal_than(2, M, [2 | Rs]) :- gcd(2, M, 2), Mdiv2 is M / 2, prime_factors_greater_equal_than(2, Mdiv2, Rs).

prime_factors_greater_equal_than(L, M, R) :- L > 2, (\+ is_prime(L); coprime(L, M)), Lp2 is L + 2, prime_factors_greater_equal_than(Lp2, M, R).
prime_factors_greater_equal_than(L, M, [L | Rs]) :- L > 2, is_prime(L), gcd(L, M, L), MdivL is M / L, prime_factors_greater_equal_than(L, MdivL, Rs).

prime_factors_multiplicity(M, P) :- prime_factors(M, R), histogram_sorted_by_int_val(R, P).

histogram_sorted_by_int_val([], []).
histogram_sorted_by_int_val([X], [[X, 1]]).
histogram_sorted_by_int_val([X | [X | X1S]], [[X, NX] | Hs]) :- histogram_sorted_by_int_val([X | X1S], [[X, NXm1] | Hs]), NX is NXm1 + 1.
histogram_sorted_by_int_val([X | [X1 | X1S]], [[X, 1] | Hs]) :- X \== X1, histogram_sorted_by_int_val([X1 | X1S], Hs).



% Arithmetic
phi_improved(M, Phi) :- prime_factors_multiplicity(M, P), phi_improved_from_factors(P, Phi).

phi_improved_from_factors([], 1).
phi_improved_from_factors([[P, M] | Ps], Phi) :- Pm1 is P - 1, Mm1 is M -1, PpMm1 is P ^ Mm1, phi_improved_from_factors(Ps, PhiPrev), Phi is Pm1 * PpMm1 * PhiPrev.

compare_phi(M) :- write('totient_phi (P34):'), time(euler_totient_phi(M, NaiveCnt)),
    write('totient_phi (P35):'), time(phi_improved(M, MultiplicativeCnt)),
    NaiveCnt =:= MultiplicativeCnt.

range_prime(L, U, []) :- L > U, !.
range_prime(L, U, [L | Ps]) :- L > 0, L =< U, is_prime(L), !, next_potential_prime(L, LNxt), range_prime(LNxt, U, Ps).
range_prime(L, U, P) :- L > 0, L =< U, next_potential_prime(L, LNxt), range_prime(LNxt, U, P).

next_potential_prime(1, 2) :- !.
next_potential_prime(Current, Nxt) :- Nxt is ((Current + 1) // 2) * 2 + 1.

last_w_prefix([_], [], []).
last_w_prefix(X, XPrefix, Last) :- length(X, LX), nth1(LX, X, Last, XPrefix).

first_and_last_sum_equal_to(E, [X, Y], [X, Y]) :- XpY is X + Y, XpY =:= E.
first_and_last_sum_equal_to(E, [First | R], [First, Last]) :-
    length(R, LR), LR > 1,
    last_w_prefix(R, _, Last),
    FLSum is First + Last,
    FLSum =:= E.
first_and_last_sum_equal_to(E, [First | R], P) :-
    length(R, LR), LR > 1,
    last_w_prefix(R, RPrefix, Last),
    FLSum is First + Last,
    FLSum >= E,
    first_and_last_sum_equal_to(E, [First | RPrefix], P).
first_and_last_sum_equal_to(E, [First | R], P) :-
    length(R, LR), LR > 1,
    last_w_prefix(R, _, Last),
    FLSum is First + Last,
    FLSum < E,
    first_and_last_sum_equal_to(E, R, P).

goldbach_conjecture(4, [2, 2]).
goldbach_conjecture(M, P) :- M > 4, M mod 2 =:= 0, range_prime(3, M, Primes), first_and_last_sum_equal_to(M, Primes, P).

list_goldbach_compositions(L, U, O) :- L > 2, L mod 2 =:= 1, Lp1 is L + 1, list_goldbach_compositions(Lp1, U, O).
list_goldbach_compositions(L, U, O) :- L > 2, U > L, U mod 2 =:= 1, Um1 is U - 1, list_goldbach_compositions(L, Um1, O).
list_goldbach_compositions(L, U, O) :- L > 2, U > L, L mod 2 =:= 0, U mod 2 =:= 0,
    UmLdiv2 is ((U - L) // 2),
    numlist(0, UmLdiv2, RangeL),
    maplist(\X^Y^(Y is L + 2 * X), RangeL, EvenGoldBachRange),
    maplist(\X^findall(P, goldbach_conjecture(X, P)), EvenGoldBachRange, GoldbachCompositions),
    about_lists:flatten_1d(GoldbachCompositions, O).

