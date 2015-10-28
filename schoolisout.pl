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
	subject(KnightSubject), subject(GrossSubject), subject(McEvoySubject), subject(AppletonSubject), subject(ParnellSubject),
	all_different([KnightSubject, GrossSubject, McEvoySubject, AppletonSubject, ParnellSubject]),
	
	% Activy per teacher
	activity(KnightActivity), activity(GrossActivity), activity(McEvoyActivity), activity(AppletonActivity), activity(ParnellActivity),
	all_different([KnightActivity, GrossActivity, McEvoyActivity, AppletonActivity, ParnellActivity]),

	% County per teacher
	county(KnightCounty), county(GrossCounty), county(McEvoyCounty), county(AppletonCounty), county(ParnellCounty),
	all_different([KnightCounty, GrossCounty, McEvoyCounty, AppletonCounty, ParnellCounty]),
	
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
		(
			member([gross, _, cornwall, _], Quadruple),
			\+ member([gross, nudist_colony, cornwall, _], Quadruple)
		)
	),
	
		
	% Second point
	% The science teacher is going body boarding is going to travel to
	% Cornwall or Norfolk
	(
		member([_, body_boarding, cornwall, science], Quadruple);	
		member([_, body_boarding, norfolk, science], Quadruple)
	),	
	
	% Third point
	% Mr McEvoy who is the history teacher is going to Yorkshire or Cumbria
	(
		member([mcevoy, _, yorkshire, history], Quadruple);
		member([mcevoy, _, cumbria, history], Quadruple)	 	
	),
	
	% Forth point
	% If the woman who is going to Hertfordshire is the english teacher
	% then she is Ms.Appleton otherwise she is Ms.Parnell
	% Ms.Parnell is going swimming
	\+ member([knight, _, hertfordshire, _], Quadruple),
	\+ member([mcevoy, _, hertfordshire, _], Quadruple),
	member([parnell, swimming, _, _], Quadruple),
	member([appleton, _, _, english], Quadruple),
	(
		member([appleton, _, hertfordshire, _], Quadruple);
		member([parnell, _, hertfordshire, _], Quadruple)
	),

	% Fifth point
	% The person who is going to Yorkshire isn't the PE teacher
	\+ member([_, _, yorkshire, pe], Quadruple),
	
	% The person who is going to Yorkshire isn't the one who is going to
	% sightseeing 
	\+ member([_, sightseeing, yorkshire, _], Quadruple),
	
	% Sixth point
	\+ member([gross, camping, _, _], Quadruple),
	
	% Seventh point
	(
		member([gross, nudist_colony, _, _], Quadruple);
		member([appleton, nudist_colony, _, _], Quadruple);
		member([parnell, nudist_colony, _, _], Quadruple)
	),
	tell(gross, GrossSubject, GrossCounty, GrossActivity), 
	tell(appleton, AppletonSubject, AppletonCounty, AppletonActivity), 
	tell(parnell, ParnellSubject, ParnellCounty, ParnellActivity), 
	tell(knight, KnightSubject, KnightCounty, KnightActivity), 
	tell(mcevoy, McEvoySubject, McEvoyCounty, McEvoyActivity). 
	

% To be understood (!)
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(T, X, Y, Z) :- write('['), write(T), write(']\t['), write(X), 
			write(']\t['), write(Y), write(']\t['), write(Z),
			write(']'), nl.
	
