# TODO Verify actual names
# TODO parameterize size
# TODO verify multi size boxes
MULTI_NAMES = [
    "Archer",
    "Guard",
    "Imps",
]

SINGLE_NAMES = [
    "Ancient Artillery",
    "Cave Bear",
    "Cultist",
    "Tentacle",
    "Earth Demon",
    "Fire Demon",
    "Frost Demon",
    "Giant Viper",
    "Harrower",
    "Hound",
    "Shaman",
    "Living Bones",
    "Living Corpse",
    "Living Shadow(?)",
    "Mirelurk (def not the name)",
    "Night Demon",
    "Ooze",
    "Rending Drake",
    "Savaas Frost",
    "Savaas Fire",
    "Spitting Drake",
    "Stone Golem",
    "Sun Demon",
    "Scout",
    "Wind Demon",
    "FC Monster 1",
    "FC Monster 2",
    "FC Monster 3",
]

BUILD_PARAMETERS = (
    [
        {
            "output_suffix": label.replace(" ", "_").lower(),
            "output_subdir": "name_plates",
            "monster_name": label,
            # "plate_width": ?
        }
        for label in MULTI_NAMES
    ]
    + [
        {
            "output_suffix": label.replace(" ", "_").lower(),
            "output_subdir": "name_plates",
            "monster_name": label,
            # "plate_width": ?
        }
        for label in SINGLE_NAMES
    ]
    + [
        {
            "output_suffix": "bosses",
            "output_subdir": "name_plates",
            "monster_name": "Bosses",
            # "plate_width": ?
        }
    ]
)
