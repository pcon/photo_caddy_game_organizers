use <../utilities.scad>

CARD_WIDTH = 64;
CARD_DEPTH = 89;
CARD_HEIGHT = 23;

BOOKLET_WIDTH = 117;
BOOKLET_DEPTH = 91;
BOOKLET_HEIGHT = 2.5;

booklet = [117, 91, 2.5];

two_card_holder(
    CARD_WIDTH,
    CARD_DEPTH,
    CARD_HEIGHT,
    booklet = booklet
);