professions([smith,baker,carpenter,tailor]). % list of professions
/* S = Smith's profession				B = Baker's profession
   C = Carpenter's profession			T = Taylor's profession
   Son_S = Smith son's profession		Son_B = Baker son's profession
   Son_C = Carpenter son's profession	Son_T = Taylor son's profession
*/
different(X,X):-!,fail.
different(X,Y).

find_professions([S,B,C,T],[Son_S,Son_B,Son_C,Son_T]):-
	professions(L),
	member(S,L),different(S,smith),
	member(B,L),different(B,baker),
	member(C,L),different(C,carpenter),
	member(T,L),different(T,tailor),

/* The sons do not have the same profession as their name shows */
    member(Son_S,L),different(Son_S,smith),
	member(Son_B,L),different(Son_B,baker),
	member(Son_C,L),different(Son_C,carpenter),
	member(Son_T,L),different(Son_T,tailor),


	/* The sons do not have the same profession as their fathers either */
	different(S,Son_S),
	different(B,Son_B),
	different(C,Son_C),
	different(T,Son_T),

	B=Son_C,		% Baker has the same profession as Carpenter's son.
	Son_S=baker,	% Smith's son is a baker

    write("Smith" -> S),nl,
	write("Baker" -> B),nl,
	write("Carpenter" -> C),nl,
	write("Tailor" -> T),nl,
	write("Son_Of Smith" -> Son_S),nl,
	write("Son_Of Baker" -> Son_B),nl,
	write("Son_Of Carpenter" -> Son_C),nl,
	write("Son_Of Tailor" -> Son_T).





