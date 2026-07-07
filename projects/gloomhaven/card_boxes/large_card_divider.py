LARGE_CARD_DIVIDERS = [
    "Road Events",
    "City Events",
    "Rift Events",
    "Locked Road Events",
    "Locked City Events",
    "Locked Rift Events",
]

BUILD_PARAMETERS = tuple(
    {
        "output_suffix": label.replace(" ", "_").lower(),
        "output_subdir": "dividers",
        "label": label,
    }
    for label in LARGE_CARD_DIVIDERS
)
