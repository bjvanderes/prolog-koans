:- begin_tests(about_arithmetic).
:- use_module(about_arithmetic).

test(is_prime) :-
	is_prime(7).
test(is_prime, [fail]) :-
	is_prime(6).

test(gcd, [nondet]) :-
	gcd(36, 63, 9), gcd(63, 36, G), gcd(7, 7, 7), gcd(33, 88, 11).
test(gcd) :-
	G is gcd(36, 63), G =:= 9.

test(coprime) :-
	coprime(35, 64), coprime(64, 35).
test(coprime, [fail]) :-
	coprime(36, 63).

test(euler_totient_phi, [nondet]) :-
	euler_totient_phi(10, 4), euler_totient_phi(11, 10), euler_totient_phi(13, 12).

test(prime_factors) :-
	prime_factors(315,[3,3,5,7]).

test(prime_factors_multiplicity) :-
	prime_factors_multiplicity(315,[[3,2],[5,1],[7,1]]).

test(range_prime) :-
	range_prime(2,9,[2,3,5,7]).

test(goldbach_conjecture) :-
	goldbach_conjecture(28, [5, 23]).

:- end_tests(about_arithmetic).
