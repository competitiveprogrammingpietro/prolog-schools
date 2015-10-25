% Teachers
teacher(knight).
teacher(gross).
teacher(mcEvoy).
teacher(appleton).
teacher(parnell).

% Genders
male(knight).
male(mcevoy).

% Female
female(gross).
female(appleton).
female(parnell).

% Subjects
subject(math).
subject(science).
subject(history).
subject(english).
subject(pe).

% Activity
activity(nudist_colony).
activity(body_boarding).
activity(swimming).
activity(sightseeing).
activity(camping).

%County
county(cornwall).
county(norfolk).
county(hertfordshire).
county(yorkshire).
county(suffolk).
county(cumbria).


solve :-
	% Subject per teacher
	subject(KnightSubject),subject(GrossSubject),subject(McEvoySubject),subject(AppletonSubject),subject(ParnellSubject),
	all_different([KnightSubject,GrossSubject,McEvoySubject,AppletonSubject,ParnellSubject]),
	
	% Activy per teacher
	activity(KnightActivity),activity(GrossActivity),activity(McEvoyActivity),activity(AppletonActivity),activity(ParnellActivity),
	all_different([KnightActivity,GrossActivity,McEvoyActivity,AppletonActivity,ParnellActivity]),

	% County per teacher
	county(KnightCounty),county(GrossCounty),county(McEvoyCounty),county(AppletonCounty),county(ParnellCounty),
	all_different([KnightCounty,GrossCounty,McEvoyCounty,AppletonCounty,ParnellCounty]),
	
	Quadruple = [ [knight, KnightActivity, KnightCounty, KnightSubject],
		      [gross, GrossActivity, GrossCounty, GrossSubject],
		      [mcevoy, McEvoyActivity, McEvoyCounty, McEvoySubject],
		      [appleton, AppletonActivity, AppletonCounty, AppletonSubject],
		      [parnell, ParnellActivity, ParnellCounty, ParnellSubject] ],
	
	% First point
	% Mr. Gross teaches either math of science
	(	member([gross, _, _, math], Quadruple);
		member([gross, _, _, science], Quadruple)
	),
	
	% If Ms.Gross is going to a nudist colony then she is going
	% to Suffolk otherwise she is going to Cornwall
	(
		member([gross, nudist_colony, suffolk, _], Quadruple);
		member([gross, _, cornwall, _], Quadruple)
	),
	
	% Second point
	% The science teacher is going to body boarding
	member([_, body_boarding, _, science], Quadruple),

	% The science teacher is going to travel to Cornwall or Norfolk
	member([_, _, cornwall, science], Quadruple),	
	member([_, _, norfolk, science], Quadruple),	
	
	% Third point
	% Mr McEvoy is the history teacher
	member([mcevoy, _, _, history], Quadruple),

	% Mr. MvEvoy is going to Yorkshire or Cumbria
	(
		member([mcEeoy, _, yorkshire, _], Quadruple);
		member([mcEeoy, _, cumbria, _], Quadruple)
		 	
	),

	% Forth point
	% If THE woman whis is the english teacher (triple check)
	%KnightSubject \+ english,
	%McEvoySubject \+ english,
	
	% Ms.Parnell is going swimming
	member([parnell, _, swimming, _], Quadruple),

	% If the woman who is going to Hertfordshire is the english teacher
	% then she is Ms.Appleton otherwise she is Ms.Parnell
	
	% Fifth point
	% The person who is going to Yorkshire isn't the PE teacher
	\+ member([_, yorkshire, _, pe], Quadruple),
	
	% The person who is going to Yorkshire isn't the one who is going to
	% sightseeing 
	\+ member([_, yorkshire, sightseeing, _], Quadruple),
	
	% Sixth point
	\+ member([gross, _, camping, _], Quadruple),
	
	% Seventh point
	member([female(_), _, nudist_colony, _], Quadruple),	
	
	tell(gross, GrossSubject, GrossCounty, GrossActivity). 
	

% To be understood (!)
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(T, X, Y, Z) :- write('Professor: '), write(T), write('who teaches :'), write(X), 
			write(' is going to: '), write(Y), write('to :'), write(Z).
	
