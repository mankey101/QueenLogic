/*
* Mayank Hooda
* CS16BTECH11022
* 8 Queens Problem
*/
:-initialization(start).

% Generates the permutations and checks their validity i.e. that two queens do not cut eachother , diagonally or horizontally(and vertically).
solve(X,Y,P):-
    L = [1,2,3,4,5,6,7,8],
    permute(L,P), present(X,Y,P) ,
    check(L,P,S,D),
    difference(S),
    difference(D).

%Checks if there is a queen at posiiton (X,Y) on the board.
present(1,X,[X|T]).
present(X,Y,[A|B]):-
    X>0 , X1 is X-1 , present(X1,Y,B).

% Permutation generator using deleting elements then adding them up
permute([],[]).
permute([X|Y],Z) :- permute(Y,W), delete_elem(X,Z,W).   

%Deletes a particular element from a list
delete_elem(X,[X|R],R).
delete_elem(X,[F|R],[F|S]) :- delete_elem(X,R,S).

%Checks whether queens cut each other by checking if sum or difference of column and row of any two queens are equal
check([],[],[],[]).
check([X1|X],[Y1|Y],[S1|S],[D1|D]) :-
     S1 is X1 +Y1,
     D1 is X1 - Y1,
     check(X,Y,S,D).

 
difference([X|Y]) :-  \+member(X,Y), difference(Y).
difference([X]).

%Base case for the queen , if there at (8,8).
writeList(0, P) :-
    present(8,8,P)->write('1 ');write('0 ').

%Recursively starts from (1,1) and goes on checking if there is a square at (x,y) prints 1 if present 0 else.
writeList(N,P):-
    N>0, X1 is N-1, Y9 is 63-N, Y8 is mod(Y9, 8), Y is Y8+1, X2 is truncate(N/8),X is 8-X2 ,(N=:=63->T is 0;T is mod(Y,8)),
    (T=:=1 -> nl,nl; isZero(0,[0])),
    (present(Y,X,P)->write('1 '),writeList(X1,P); write('0 '), writeList(X1,P)). 

%main function reads the given position of the queen , solves the correct positions of other queens and prints them out recursively.
%Any poisiton of queen not in range of the board throws the 'IMPOSSIBLE' on stdout (e.g. 1.5 2 or 9 1)
start:-
    read_number(X) , read_number(Y),
    solve(X,Y,P)->writeList(63,P),nl ; write('IMPOSSIBLE'),nl.

%Just a true statement , used to nullify any effect caused by the else.
isZero(0, [0]).
