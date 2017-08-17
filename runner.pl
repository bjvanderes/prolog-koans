:- module(runner, [go/0]).

go :- 
	%[runner_goals],
	%runner_goals:goals_go,
	%[runner_list],
	%runner_list:list_go,
	[runner_arithmetic],
	runner_arithmetic:arithmetic_go,
  see(user),
  writeln('This path has been completed. Go forth to new challenges!').
