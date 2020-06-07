use <.\boxes\CardBox.scad>

// card measurements
//modifier_card_width = 68; // mm
//modifier_card_height = 44; // mm
//modifier_card_thickness = .32; // mm better estimate // same as item cards and monster actions
//card_count = 265;

modifier_card_width = 10; // mm
modifier_card_height = 5; // mm
modifier_card_thickness = .32; // mm better estimate // same as item cards and monster actions
card_count = 20;

// other params
wall_thickness = 3; // mm
interior_padding = 2; // mm
lid_pct = .4; // % total height
overlap = .75; // % of lid height
divider_slots = []; // % locations from origin (?)
$fn = 100;

x = modifier_card_width + interior_padding + 2 * wall_thickness;
z = modifier_card_height + interior_padding + 2 * wall_thickness;
y = card_count * modifier_card_thickness + 2 * wall_thickness;



// box
cardBox(x,y,z,wall_thickness,lid_pct,overlap,divider_slots);

// lid
color("red")
	
	translate([0,-1.5*y,0])
	cardBoxSpacedLid(x,y,z,wall_thickness,lid_pct);