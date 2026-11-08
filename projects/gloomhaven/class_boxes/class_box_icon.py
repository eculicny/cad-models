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
        "output_subdir": "icons",
        "file_name": f"../img/{label}.svg",
        "scale_factor": 0.55
        if label == "triangles"
        else 1.7
        if label in ("spears", "brute", "scoundrel")
        else 1.8,
        "y_offset": -1.4 if label == "triangles" else 0,
    }
    for label in CLASSES
]
