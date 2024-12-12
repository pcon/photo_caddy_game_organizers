use <../utilities.scad>

CARD_WIDTH = 57;
CARD_DEPTH = 89;
CARD_HEIGHT = 22;

BOOKLET_WIDTH = 93;
BOOKLET_DEPTH = 65;
BOOKLET_HEIGHT = 3.75;

booklet = [BOOKLET_WIDTH, BOOKLET_DEPTH, BOOKLET_HEIGHT];

two_card_holder(
    CARD_WIDTH,
    CARD_DEPTH,
    CARD_HEIGHT,
    booklet = booklet
);