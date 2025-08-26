:- ensure_loaded(brainteaser).
/*
It's lunchtime in the canteen.
Troy ordered after Kelly who didn't order soup.
The curry order was placed before Sharon's, but not before the baguette.
Kirsten didn't order last but did order one of the soup or lasagne, the latter
of which was ordered before the baguette.
Who ordered what for lunch and in what order?
*/

solution1914(First, Second, Third, Fourth) :-
    Canteen = [First, Second, Third, Fourth],

    First = FirstP-FirstM,
    Second = SecondP-SecondM,
    Third = ThirdP-ThirdM,
    Fourth = FourthP-FourthM,

    People = [kelly, kirsten, sharon, troy],
    Meals = [baguette, curry, lasagne, soup],

    permutation(People, [FirstP, SecondP, ThirdP, FourthP]),
    permutation(Meals, [FirstM, SecondM, ThirdM, FourthM]),

    % Troy ordered after Kelly...
    before(kelly, troy, _, _, Canteen),

    % ...who didn't order soup.
    not_ordered_by(kelly, soup, Canteen),

    % The curry order was placed before Sharon's...
    before(_, sharon, curry, _, Canteen),

    % ...but not before the baguette
    before(_, _, baguette, curry, Canteen),

    % Kirsten didn't order last...
    not_in_position(kirsten, _, 3, Canteen),

    % ...but did order one of the soup or lasagne...
    % NB this doesn't scale to a broader menu
    not_ordered_by(kirsten, baguette, Canteen),
    not_ordered_by(kirsten, curry, Canteen),

    % the latter of which was ordered before the baguette
    before(_, _, lasagne, baguette, Canteen),

    true.


not_ordered_by(Person, Meal, Canteen) :-
    \+ member(Person-Meal, Canteen).

% todo: generalise, unit test, retrofit to karaoke
not_in_position(Person, Meal, Avoid, Canteen) :-
    nth0(Where, Canteen, Person-Meal),
    Where \== Avoid.

before(PersonA, PersonB, MealA, MealB, Canteen) :-
    nth0(IndexA, Canteen, PersonA-MealA),
    nth0(IndexB, Canteen, PersonB-MealB),
    IndexA < IndexB.
