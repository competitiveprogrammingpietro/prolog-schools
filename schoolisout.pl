% Teachers
teacher(knight).
teacher(gross).
teacher(mcEvoy).
teacher(appleton).
teacher(parnell).

% Genders
male(knight).
male(mcEvoy).

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
		      [mcEvoy, McEvoyActivity, McEvoyCounty, McEvoySubject],
		      [appleton, AppletonActivity, AppletonCounty, AppletonSubject],
		      [parnell, ParnellActivity, ParnellCounty, ParnellSubject] ],
	tell(X,Y,Z).

% To be understood (!)
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :- write('Ciao').
	
