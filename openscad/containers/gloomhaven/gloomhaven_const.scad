/* Measurements (mm) & Constants for Gloomhaven objects */

CARD_THICKNESS = .3;
CARDBOARD_THICKNESS = 2.5;
TOKEN_THICKNESS = CARDBOARD_THICKNESS;

// ~2 padding added to actual measurements
SMALL_CARD_LENGTH = 46;
SMALL_CARD_WIDTH = 70;
LARGE_CARD_LENGTH = 90;
LARGE_CARD_WIDTH = 65;
CLASS_STAT_CARD_LENGTH = 147;
CLASS_STAT_CARD_WIDTH = 96;


MONSTER_STAT_CARD_LENGTH = 102;
MONSTER_STAT_CARD_WIDTH = MONSTER_STAT_CARD_LENGTH;
MONSTER_ABILITY_CARD_LENGTH = SMALL_CARD_LENGTH;
MONSTER_ABILITY_CARD_WIDTH = SMALL_CARD_WIDTH;


MODIFIER_DECK_COUNT = 20;
CLASS_MODIFIER_DECK_COUNT = 18; // cragheart
CLASS_ACTION_DECK_COUNT = 35; // cragheart + 5

SUMMON_LARGE_DIAMETER = 30;
SUMMON_SMALL_DIAMETER = 13;
SUMMON_COUNT = 16;

HP_SMALL_DIAMETER = 14;
HP_SMALL_COUNT = 28;
HP_MEDIUM_DIAMETER = 18;
HP_MEDIUM_COUNT = 12;
HP_LARGE_DIAMETER = 24;
HP_LARGE_COUNT = 6;

ALPHANUMERIC_DIAMETER = 21;
ALPHANUMERIC_COUNT = 10;
NUMBER_COUNT = 12;

GOLD_1_DIAMETER = 21;
GOLD_1_COUNT = 40;
GOLD_5_DIAMETER = 30;
GOLD_5_SIDE = 12;
GOLD_5_COUNT = 10;

TREASURE_CHEST_LENGTH = 30;
TREASURE_CHEST_WIDTH = 19;
TREASURE_CHEST_COUNT = 6;

ELEMENT_DIAMETER = 20;
ELEMENT_COUNT = 6;

/********** CONSTANTS **********/

MATERIAL_THICKNESS = 3;
SLOT_HEIGHT = 2;
SLOT_OFFSET = 1; // offset of slot downwards from top of box

LID_SCALE = .95; // linear_extrude scale for the angled lid and slot
RADIUS_EXT = 2; // radius of curved exterior box corners
//RADIUS_INT = 4; // radius of interior box corners

/* Label Constants */
ANCIENT_ARTILLERY = "Ancient Artillery";
ARCHER = "Archer";
BOSS = "Boss";
CAVE_BEAR = "Cave Bear";
CULTIST = "Cultist";
DEEP_TERROR = "Deep Terror";
DEMON_EARTH = "Earth Demon";
DEMON_FIRE = "Fire Demon";
DEMON_FROST = "Forst Demon";
DEMON_NIGHT = "Night Demon";
DEMON_SUN = "Sun Demon";
DEMON_WIND = "Wind Demon";
DRAKE_RENDING = "Rending Drake";
DRAKE_SPITTING = "Spitting Drake";
GUARD = "Guard";
GIANT_VIPER = "Giant Viper";
HARROWER_INFESTER = "Harrower Infester";
HOUND = "Hound";
IMP = "Imp";
LIVING_BONES = "Living Bones";
LIVING_CORPSE = "Living Corpse";
LIVING_SPIRIT = "Living Spirit";
LURKER = "Lurker";
OOZE = "Ooze";
SAVVAS_ICESTORM = "Savvas Icestorm";
SAVVAS_LAVAFLOW = "Savvas Lavaflow";
SCOUT = "Scout";
SHAMAN = "Shaman";
STONE_GOLEM = "Stone Golem";

ANCIENT_ARTILLERY_SCOUT = str(ANCIENT_ARTILLERY, " & ", SCOUT);
CAVE_BEAR_HOUND = str(CAVE_BEAR, " & ", HOUND);
CULTIST_LIVING_SPIRIT = str(CULTIST, " & ", LIVING_SPIRIT);
DEEP_TERROR_GIANT_VIPER = str(DEEP_TERROR, " & ", GIANT_VIPER);
HARROWER_INFESTER_LURKER = str(HARROWER_INFESTER, " & ", LURKER);
LIVING_BONES_CORPSE = str(LIVING_BONES, " & ", LIVING_CORPSE);
DEMON_EARTH_PAREN = "Demon (Earth)";
DEMON_NIGHT_SUN = "Demon (Night & Sun)";
DEMON_FLAME_FROST = "Demon (Flame & Frost)";
DEMON_WIND_PAREN = "Demon (Wind)";
DRAKES = "Drakes (Rending & Spitting)";
SAVVAS = "Savvas (Icestorm & Lavaflow)";