:- module(about_arithmetic, 
	[is_prime/1, prime_factors/2, prime_factors_multiplicity/2,
	range_prime/3, goldbach_conjecture/2, gcd/3, coprime/2, euler_totient_phi/2,
	phi_improved/2, compare_phi/2, list_goldbach_compositions/2]).


is_prime(N) :- SQRT_N is floor(sqrt(N)), \+ has_factors(N, SQRT_N).

has_factors(N, F) :- F > 1, N mod F =:= 0.
has_factors(N, F) :- F > 1, Fm1 is F - 1, has_factors(N, Fm1).



% Make arithmetic function
gcd(A, A, A) :- !.
gcd(1, _, 1) :- !.
gcd(_, 1, 1) :- !.
gcd(L, S, G) :- S > 1, L > S, gcd(S, L, G).
gcd(S, L, G) :- S > 1, L > S, D is L - S, gcd(S, D, G).

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

prime_factors_multiplicity(_,_) :- false.

% Arithmetic
phi_improved(_, _) :- false.

compare_phi(_, _) :- false.

range_prime(_,_,_) :- false.

goldbach_conjecture(_,_) :- false.

list_goldbach_compositions(_, _) :- false.