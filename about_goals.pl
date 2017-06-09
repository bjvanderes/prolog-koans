:- module(about_goals, [parent/2, equal/2]).

parent(adam, not_steve).
parent(adam, steve).

equal(X,X) :- true.
