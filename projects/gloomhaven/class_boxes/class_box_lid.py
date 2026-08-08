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

BUILD_PARAMETERS = [
    {
        "output_suffix": label.lower(),
        "output_subdir": "lids",
        "file_name": f"../img/{label}.svg",
        "scale_factor": 3.75 if label == "triangles" else 10,
    }
    for label in CLASSES
]
