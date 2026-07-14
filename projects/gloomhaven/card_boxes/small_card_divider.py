ITEM_CARD_DIVIDERS = [
    "Available",
    "Locked",
    "Prosperity 1",
    "Prosperity 2",
    "Prosperity 3",
    "Prosperity 4",
    "Prosperity 5",
    "Prosperity 6",
    "Prosperity 7",
    "Prosperity 8",
    "Prosperity 9",
    "Random Items",
    "Other Items",
    "Random Scenarios",
    "Random Dungeons",
    "Battle Goals",
    "Player 1 Modifiers",
    "Player 2 Modifiers",
    "Player 3 Modifiers",
    "Player 4 Modifiers",
    "-1 Modifiers",
    "Removed",
]

BUILD_PARAMETERS = tuple(
    {
        "output_suffix": label.replace(" ", "_").lower(),
        "output_subdir": "dividers",
        "label": label,
    }
    for label in ITEM_CARD_DIVIDERS
)
