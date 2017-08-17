:- module(about_arithmetic, 
	[is_prime/1, prime_factors/2, prime_factors_multiplicity/2,
	range_prime/3, goldbach_conjecture/2, gcd/3, coprime/2, euler_totient_phi/2,
	phi_improved/2, compare_phi/2, list_goldbach_compositions/2]).


is_prime(N) :- SQRT_N is floor(sqrt(N)), \+ has_factors(N, SQRT_N).

has_factors(N, F) :- F > 1, N mod F =:= 0.
has_factors(N, F) :- F > 1, Fm1 is F - 1, has_factors(N, Fm1).



% Make arithmetic function
gcd(A, A, A).
gcd(1, _, 1).
gcd(L, S, G) :- L > S, S > 1, gcd(S, L, G).
gcd(S, L, G) :- L > S, S > 1, D is L - S, gcd(S, D, G).

coprime(A, B) :- gcd(A, B) =:= 1.

% Arithmetic
euler_totient_phi(M, Cnt) :- euler_totient_phi_(M, 1, Cnt).
euler_totient_phi_(M, M, 0).
euler_totient_phi_(M, L, Cnt) :- L < M, coprime(L, M), Lp1 is L + 1, euler_totient_phi_(M, Lp1, CntM1), Cnt is CntM1 + 1.
euler_totient_phi_(M, L, Cnt) :- L < M, \+ coprime(L, M), Lp1 is L + 1, euler_totient_phi_(M, Lp1, Cnt).


prime_factors(_,_) :- false.

prime_factors_multiplicity(_,_) :- false.

% Arithmetic
phi_improved(_, _) :- false.

compare_phi(_, _) :- false.

range_prime(_,_,_) :- false.

goldbach_conjecture(_,_) :- false.

list_goldbach_compositions(_, _) :- false.