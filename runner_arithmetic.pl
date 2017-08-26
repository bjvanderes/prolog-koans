:- module(runner_arithmetic, [arithmetic_go/0]).

run_koan(X,L) :-
	koan_helper(X,about_arithmetic:L).
	

arithmetic_load :- 
	[runner_helper],
	[about_arithmetic],
	load_test_files(about_arithmetic).

arithmetic_go :- 
	arithmetic_load,
	arithmetic_prime,
	arithmetic_gcd,
	arithmetic_coprime,
	arithmetic_euler_totient_phi,
    arithmetic_prime_factors,
	arithmetic_prime_factors_multiplicity,
	arithmetic_phi_improved,
	arithmetic_range_prime,
	arithmetic_goldbach_conjecture,
	arithmetic_list_goldbach_compositions,
	arithmetic_greatest_common_divisor,
	arithmetic_is_coprime.

arithmetic_prime :-
	run_koan('Can you write a predicate for prime numbers?', is_prime).

arithmetic_gcd :-
	run_koan('Use Euclid\'s algorithm to determine the greatest common divisor of two integers and create a prolog arithmetic function from it', gcd).

arithmetic_coprime :-
	run_koan('Use your gcd function to determine if two integers are coprime.', coprime).

arithmetic_euler_totient_phi :-
	run_koan('Determine all coprime integers of an upper bound.', euler_totient_phi).

arithmetic_prime_factors :-
	run_koan('Can you find all the prime factors given a positive integer?', prime_factors).

arithmetic_prime_factors_multiplicity :- 
	run_koan('Can you find all the prime factors with their multiplicity given a positive integer? (The previous problem may be of use)', prime_factors_multiplicity).

arithmetic_phi_improved :-
   	run_koan('Use the multiplicative formula for Phi and compare with naive version.', phi_improved).

arithmetic_range_prime :-
	run_koan('Can you construct a list of prime numbers from the lower and upper limit of a range?', range_prime).

arithmetic_goldbach_conjecture :-
	run_koan('Given Goldbach\'s conjecture that every positive even number greater than 2 is the sum of two prime numbers, can you find the two prime numbers which sum up to a given even integer?', goldbach_conjecture).

arithmetic_list_goldbach_compositions :-
	run_koan('Use previous goldbach algorithm to generate list', list_goldbach_compositions).

arithmetic_greatest_common_divisor :-
	run_koan('Determine the greatest common divisor between two numbers', greatest_common_divisor).

arithmetic_is_coprime :-
	run_koan('This goal is true if the greatest common divisor of what is passed is 1', is_coprime).
