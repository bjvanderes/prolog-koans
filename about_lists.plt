:- begin_tests(about_lists).
:- use_module(about_lists).

test(my_first) :-
	my_first(X, [a,b,c]),
	X = a.
test(my_first, [fail]) :- 
	my_first(b, [a,b,c]).

test(my_last,[nondet]) :-
	my_last(X, [a,b,c]),
	X = c.

test(my_penultimate, [nondet]) :-
	my_penultimate(X, [a,b,c,d]),
	X = c.
test(my_penultimate, [fail]) :-
	my_penultimate(d, [a,b,c,d]).

test(my_element_at, [nondet]) :-
	my_element_at(X, [a,b,c,d], 3),
	X = c.
test(my_element_at, [fail]) :-
	my_element_at(d, [a,b,c,d], 3).
test(my_element_at, [fail]) :-
	my_element_at(c, [a,b,c,d], 2).

test(my_number_of, [nondet]) :-
	my_number_of(3, [a,b,c]).

test(my_reverse) :-
	my_reverse([a,b,c,d],[d,c,b,a]).

test(is_palindrome) :-
	is_palindrome([x,a,m,a,x]).
test(is_palindrome, [fail]) :-
	is_palindrome(['a','b','c','d']).

test(my_flatten, [nondet]) :-
  my_flatten([], []).
test(my_flatten, [nondet]) :-
  my_flatten([a, [b, [c,d], e]], [a,b,c,d,e]).

test(my_compress, [nondet]) :-
	my_compress([a,a,a,a,b,b,b,b,c,c,c,c,a,a,d,e,e,e,e],[a,b,c,a,d,e]).

test(my_pack, [nondet]) :-
	my_pack([a,a,a,b,c,c,a,a,d,e,e,e,e],[[a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]).

test(my_encode, [nondet]) :-
	my_encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e],[[4,a],[1,b],[2,c],[2,a],[1,d],[4,e]]).

test(my_encode_modified, [nondet]) :-
	my_encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e],[[4,a],b,[2,c],[2,a],d,[4,e]]).

test(my_encode_reverse, [nondet]) :-
	my_encode_reverse([[4,a],b,[2,c],[2,a],d,[4,e]],[a,a,a,a,b,c,c,a,a,d,e,e,e,e]).

test(my_encode_direct, [nondet]) :-
	my_encode_direct([a,a,a,a,b,c,c,a,a,d,e,e,e,e],[[4,a],b,[2,c],[2,a],d,[4,e]]).

test(my_duplicate) :-
	my_duplicate([a,b,c,c,d],[a,a,b,b,c,c,c,c,d,d]).

test(my_duplicate_for_n, [nondet]) :-
	my_duplicate_for_n([a,b,c],2,[a,a,b,b,c,c]),
	my_duplicate_for_n([a,c,c,b],4,[a,a,a,a,c,c,c,c,c,c,c,c,b,b,b,b]).

test(my_drop, [nondet]) :-
	my_drop([a,b,c,d,e,f,g,h,i,k],3,[a,b,d,e,g,h,k]).

test(my_split, [nondet]) :-
	my_split([a,b,c,d,e,f,g,h,i,k],3,[a,b,c],[d,e,f,g,h,i,k]).

test(my_slice, [nondet]) :-
	my_slice([a,b,c,d,e,f,g,h,i,k],3,7,[c,d,e,f,g]).

test(my_rotate, [nondet]) :-
	my_rotate([a,b,c,d,e,f,g,h],3,[d,e,f,g,h,a,b,c]).

test(remove_at) :-
	remove_at(b,[a,b,c,d],2,[a,c,d]).

test(insert_at, [nondet]) :-
	insert_at(alfa,[a,b,c,d],2,[a,alfa,b,c,d]).

test(range, [nondet]) :-
	range(4,9,[4,5,6,7,8,9]).

test(extract_rnd) :-
	set_random(seed(1)),
    extract_rnd([a,b,c,d,e,f,g,h], 3, [d, h, c]).
test(extract_rnd) :-
	set_random(seed(1)),
    extract_rnd([a], 1, [a]).

test(select_rnd_int) :-
	set_random(seed(1)),
	select_rnd_int(6, 49, [15, 20, 42, 30, 38, 25]).
test(select_rnd_int) :-
	set_random(seed(1)),
	select_rnd_int(0, 49, []).
test(select_rnd_int) :-
	set_random(seed(1)),
    select_rnd_int(49, 49, [15, 20, 42, 30, 38, 25, 12, 13, 46, 19, 35, 37, 11, 48, 34, 17, 21, 28, 1, 9, 32, 43, 10, 22, 40, 27, 49, 5, 8, 26, 31, 18, 2, 4, 23, 36, 41, 39, 29, 3, 45, 44, 47, 24, 16, 33, 6, 7, 14]).

test(rnd_permutation) :-
	set_random(seed(1)), rnd_permutation([a,b,c,d,e,f], [d, c, f, e, a, b]).

test(combination, [nondet]) :-
	combination(3, [a,b,c,d,e,f], [a, b, c]).

test(extract_combination, [nondet]) :-
	extract_combination(3, [a,b,c,d,e,f,g], [a, b, c], [d,e,f,g]).

test(combination) :-
	aggregate_all(count, combination(3, [a,b,c,d,e,f], C), 20).

test(extract_combination) :-
	aggregate_all(count, extract_combination(3, [a,b,c,d,e,f], C, R), 20).

test(group234) :-
	aggregate_all(count, group234([aldo,beat,carla,david,evi,flip,gary,hugo,ida], G2, G3, G4), 1260).

test(group, [nondet]) :-
	group([aldo,beat,carla,david,evi,flip,gary,hugo,ida], [2,2,5], [[aldo,beat],[carla,david],[evi,flip,gary,hugo,ida]]).

test(group) :-
	aggregate_all(count, group([aldo,beat,carla,david,evi,flip,gary,hugo,ida], [2,2,5], X), 756).

test(lsort, [nondet]) :-
	lsort([[a,b,c],[d,e],[f,g,h],[d,e],[i,j,k,l],[m,n],[o]], X), maplist(length, X, [1, 2, 2, 2, 3, 3, 4]).

test(lfsort) :-
	lfsort([[a, b, c], [d, e],[f, g, h], [d, e], [i, j, k, l], [m, n], [o]],  [[i, j, k, l], [o], [a, b, c], [f, g, h], [d, e], [d, e], [m, n]]).


:- end_tests(about_lists).
