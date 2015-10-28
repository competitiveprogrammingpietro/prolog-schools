% People
person(ida).
person(jeremy).
person(hugh).
person(stella).
person(leroy).

% Rose types
rose(golden_sunset).
rose(cottage_beauty).
rose(pink_paradise).
rose(sweet_dreams).
rose(mountain_bloom).

% Event types
event(senior_proms).
event(wedding).
event(charity_auction).
event(anniversary).
event(retirement).

% Additional items
item(place_cards).
item(candles).
item(streamers).
item(balloons).
item(gourmet_chocolate).


solve :-

	% Each person a different type of rose
	rose(IdaRose), rose(JeremyRose), rose(HughRose), rose(StellaRose), rose(LeroyRose),
	all_different([IdaRose, JeremyRose, HughRose, StellaRose, LeroyRose]),
	
	% Each person a different event type
	event(IdaEvent), event(JeremyEvent), event(HughEvent), event(StellaEvent), event(LeroyEvent),
	all_different([IdaEvent, JeremyEvent, HughEvent, StellaEvent, LeroyEvent]),

	% Each person a different additional item type
	item(IdaItem), item(JeremyItem), item(HughItem), item(StellaItem), item(LeroyItem),
	all_different([IdaItem, JeremyItem, HughItem, StellaItem, LeroyItem]),

	Quadruple = [ [ida, IdaRose, IdaEvent, IdaEvent],
			[jeremy, JeremyRose, JeremyEvent, JeremyItem],
			[hugh, HughRose, HughEvent, HughItem],
			[stella, StellaRose, StellaEvent, StellaItem],
			[leroy, LeroyRose, LeroyEvent, LeroyItem]],
	
	% First point
		% Jeremy made a purchase for the senior prom
		member([jeremy, _, senior_proms, _], Quadruple),
	
		% Stella did not choose flowers for a wedding
		\+ member([stella, _, wedding, _], Quadruple),
	
		% Stella picked the Cottage Beauty
		member([stella, cottage_beauty, _, _], Quadruple),

	% Second point
		% Hush selected the Pink Paradise blooms
		member([hugh, pink_paradise, _, _], Quadruple),
		
		% Hush did not choose flowers for either te charity
		% auction or the wedding
		\+ member([hush, _, charity_auction, _], Quadruple),
		\+ member([hush, _, wedding, _], Quadruple),
	
	% Third point
		% The customer whic picked roses for an anniversary party also
		% bought streamers
		member([_, _, anniversary, streamers], Quadruple),
		
		% The one shopping for a wedding chose the balloons
		member([_, _, wedding, balloons], Quadruple),
	
	% Fourth point 
		% The customer who bought the Sweet Dreams variery also bought
		% gourmet chocolate
		member([_, sweet_dreams, _, gourmet_chocolate], Quadruple),

		% Jeremy did not pick the Mountain Bloom
		\+ member([jeremy, mountain_bloom, _, _], Quadruple),

	% Fifth 
		% Leroy was shopping for the retirement banquet
		member([leroy, _, retirement, _], Quadruple),

		% The customer in charge of decorating the senior proms also bought
		% candles
		member([_, _, senior_proms, candles], Quadruple),

	tell(ida, IdaRose, IdaEvent, IdaItem), 
	tell(jeremy, JeremyRose, JeremyEvent, JeremyItem), 
	tell(hugh, HughRose, HughEvent, HughItem), 
	tell(stella, StellaRose, StellaEvent, StellaItem), 
	tell(leroy, LeroyRose, LeroyEvent, LeroyItem).

all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(T, X, Y, Z) :- write('['), write(T), write(']\t['), write(X), 
			write(']\t['), write(Y), write(']\t['), write(Z),
			write(']'), nl.


