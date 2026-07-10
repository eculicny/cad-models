ITEM_CARD_DIVIDERS = [
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
    "Random Scenarios",
    "Random Dungeon",
    "Random Items",
    "Available",
    "Battle Goals",
    "Player 1 Modifiers",
    "Player 2 Modifiers",
    "Player 3 Modifiers",
    "Player 4 Modifiers",
]

BUILD_PARAMETERS = tuple(
    {
        "output_suffix": label.replace(" ", "_").lower(),
        "output_subdir": "dividers",
        "label": label,
    }
    for label in ITEM_CARD_DIVIDERS
)
