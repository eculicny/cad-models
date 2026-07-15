# TODO parameterize size
MULTI_NAMES = [
    "Archer",
    "Guard",
]

SINGLE_NAMES = [
    "Ancient Artillery",
    "Cave Bear",
    "Cultist",
    "Deep Terror",
    "Earth Demon",
    "Flame Demon",
    "Frost Demon",
    "Giant Viper",
    "Harrower Infester",
    "Hound",
    "Living Bones",
    "Living Corpse",
    "Living Spirit",
    "Lurker",
    "Night Demon",
    "Ooze",
    "Rending Drake",
    "Savaas Icestorm",
    "Savaas Lavaflow",
    "Spitting Drake",
    "Stone Golem",
    "Sun Demon",
    "Wind Demon",
    "Aesther Ashblade",
    "Valrath Savage",
    "Valrath Tracker",
    # Multi-group monsters in 2x standee boxes
    "Imp",
    "Scout",
    "Shaman",
]

BUILD_PARAMETERS = (
    [
        {
            "output_suffix": label.replace(" ", "_").lower(),
            "output_subdir": "name_plates",
            "monster_name": label,
            "name_plate_width": 10.85,
        }
        for label in MULTI_NAMES
    ]
    + [
        {
            "output_suffix": label.replace(" ", "_").lower(),
            "output_subdir": "name_plates",
            "monster_name": label,
            "name_plate_width": 7.2,
        }
        for label in SINGLE_NAMES
    ]
    + [
        {
            "output_suffix": "boss",
            "output_subdir": "name_plates",
            "monster_name": "Boss",
            "name_plate_width": 20.95,
        }
    ]
)
