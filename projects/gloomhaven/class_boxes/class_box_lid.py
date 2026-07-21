CLASSES = [
    "angry_face",
    "brute",
    "circles",
    "cragheart",
    "cthulhu",
    "eclipse",
    "lightning",
    "mindthief",
    "music_notes",
    "saw",
    "scoundrel",
    "spears",
    "spellweaver",
    "sun",
    "tinkerer",
    "triangles",
    "two_minis",
    "blank",
]

BUILD_PARAMETERS = tuple(
    {
        "output_suffix": label.lower(),
        "output_subdir": "lids",
        "file_name": f"../img/{label}.svg",
    }
    for label in CLASSES
)
