% Represent a state as 
% [#Cannibals_in_Left,#Missionaries_in_Left,Boat_Position,#Cannibals_in_Right,#Missionaries_in_Right]
% Start state: 3 cannibals & 3 missionaries & a boat in left side
% start([3,3,left,0,0]).
% Goal state: 3 cannibals & 3 missionaries & a boat in right side
% goal([0,0,right,3,3]).

% Rule to check for valid state
valid(CL,ML,CR,MR) :-
	ML>=0, CL>=0, MR>=0, CR>=0,
	(ML>=CL ; ML=0),
	(MR>=CR ; MR=0).

% Possible moves:

% Two missionaries cross left to right.
move([CL,ML,left,CR,MR],[CL,ML2,right,CR,MR2]):-
	MR2 is MR+2,
	ML2 is ML-2,
	valid(CL,ML2,CR,MR2).

% Two cannibals cross left to right.
move([CL,ML,left,CR,MR],[CL2,ML,right,CR2,MR]):-
	CR2 is CR+2,
	CL2 is CL-2,
	valid(CL2,ML,CR2,MR).

%  One missionary and one cannibal cross left to right.
move([CL,ML,left,CR,MR],[CL2,ML2,right,CR2,MR2]):-
	CR2 is CR+1,
	CL2 is CL-1,
	MR2 is MR+1,
	ML2 is ML-1,
	valid(CL2,ML2,CR2,MR2).

% One missionary crosses left to right.
move([CL,ML,left,CR,MR],[CL,ML2,right,CR,MR2]):-
	MR2 is MR+1,
	ML2 is ML-1,
	valid(CL,ML2,CR,MR2).

% One cannibal crosses left to right.
move([CL,ML,left,CR,MR],[CL2,ML,right,CR2,MR]):-
	CR2 is CR+1,
	CL2 is CL-1,
	valid(CL2,ML,CR2,MR).

% Two missionaries cross right to left.
move([CL,ML,right,CR,MR],[CL,ML2,left,CR,MR2]):-
	MR2 is MR-2,
	ML2 is ML+2,
	valid(CL,ML2,CR,MR2).

% Two cannibals cross right to left.
move([CL,ML,right,CR,MR],[CL2,ML,left,CR2,MR]):-
	CR2 is CR-2,
	CL2 is CL+2,
	valid(CL2,ML,CR2,MR).

%  One missionary and one cannibal cross right to left.
move([CL,ML,right,CR,MR],[CL2,ML2,left,CR2,MR2]):-
	CR2 is CR-1,
	CL2 is CL+1,
	MR2 is MR-1,
	ML2 is ML+1,
	valid(CL2,ML2,CR2,MR2).

% One missionary crosses right to left.
move([CL,ML,right,CR,MR],[CL,ML2,left,CR,MR2]):-
	MR2 is MR-1,
	ML2 is ML+1,
	valid(CL,ML2,CR,MR2).

% One cannibal crosses right to left.
move([CL,ML,right,CR,MR],[CL2,ML,left,CR2,MR]):-
	CR2 is CR-1,
	CL2 is CL+1,
	valid(CL2,ML,CR2,MR).


% Recursive call to solve the problem - move from state S1 to state S2.
path([CL1,ML1,B1,CR1,MR1],[CL2,ML2,B2,CR2,MR2],Visited,MovesList) :- 
	% Move from state S1 to state S3.
	move([CL1,ML1,B1,CR1,MR1],[CL3,ML3,B3,CR3,MR3]), 
	% S3 has not been visited yet.
	not(member([CL3,ML3,B3,CR3,MR3],Visited)),
	% And get path from S3 to S2.
	path([CL3,ML3,B3,CR3,MR3],[CL2,ML2,B2,CR2,MR2],[[CL3,ML3,B3,CR3,MR3]|Visited],[ [[CL3,ML3,B3,CR3,MR3],[CL1,ML1,B1,CR1,MR1]] | MovesList ]).

% If both states same, solution found.
path([CL,ML,B,CR,MR],[CL,ML,B,CR,MR],_,MovesList):- 
	output(MovesList).

% Recursive call to print path.
output([]) :- nl. 
output([[A,B]|MovesList]) :- 
	output(MovesList), 
   	write(B), write(' -> '), write(A), nl.

% Find the path to move from start to goal state.
find :- 
  path([3,3,left,0,0],[0,0,right,3,3],[[3,3,left,0,0]],_).
