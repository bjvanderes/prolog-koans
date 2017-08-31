:- begin_tests(about_arithmetic).
:- use_module(about_arithmetic).

test(is_prime) :-
	is_prime(7).
test(is_prime, [fail]) :-
	is_prime(6).

test(gcd) :-
	gcd(36, 63, 9), gcd(63, 36, 9), gcd(7, 7, 7), gcd(33, 88, 11).

test(coprime) :-
	coprime(35, 64), coprime(64, 35).
test(coprime, [fail]) :-
	coprime(36, 63).

test(euler_totient_phi, [nondet]) :-
	euler_totient_phi(10, 4), euler_totient_phi(11, 10), euler_totient_phi(13, 12).

test(prime_factors, [nondet]) :-
	prime_factors(315,[3,3,5,7]).

test(prime_factors_multiplicity, [nondet]) :-
	prime_factors_multiplicity(315,[[3,2],[5,1],[7,1]]).

test(phi_improved, [nondet]) :-
	phi_improved(10, 4).
test(phi_improved, [nondet]) :-
	phi_improved(123, X1), euler_totient_phi(123, X2), X1 =:= X2.

test(range_prime) :-
	range_prime(2,9,[2,3,5,7]).

test(goldbach_conjecture, [nondet]) :-
	goldbach_conjecture(28, [5, 23]).
test(goldbach_conjecture) :-
    aggregate_all(count, goldbach_conjecture(28, _), 2).

test(list_goldbach_compositions, [nondet]) :-
	list_goldbach_compositions(9, 20, [[3, 7], [5, 7], [3, 11], [3, 13], [5, 11], [5, 13], [7, 11], [3, 17], [7, 13]]),
	list_goldbach_compositions(11, 27, [[5, 7], [3, 11], [3, 13], [5, 11], [5, 13], [7, 11], [3, 17], [7, 13], [3, 19], [5, 17], [5, 19], [7, 17], [11, 13], [3, 23], [7, 19]]).

:- end_tests(about_arithmetic).
