from pathlib import Path
import subprocess

ITEM_CARD_DIVIDERS = [
    "Road Events",
    "City Events",
    "Rift Events",
    "Locked Road Events",
    "Locked City Events",
    "Locked Rift Events",
];

VERSION=1
SCAD_FILE = f"./large_card_divider.scad"
OUTPUT_DIRECTORY = f"./dividers"
OUTPUT_FILE_STEM = "large_card_divider"
PARAMETERS = (
        {
            "param_set_name": l.replace(" ","_").lower(),
            "label": l
        } for l in ITEM_CARD_DIVIDERS
)


output_path = Path(OUTPUT_DIRECTORY)
output_path.mkdir(parents=True, exist_ok=True)

def openscad_quote(s: object) -> str:
    if isinstance(s, str):
        return f'"\\"{s}\\""'
    return s

for config in PARAMETERS:
    print(f"Processing: {config}")
    params = " ".join([f"-D {k}={openscad_quote(v)}" for k,v in config.items() if k != "param_set_name"])
    print(f"params: {params}")
    command = f"openscad -o {OUTPUT_DIRECTORY}/{OUTPUT_FILE_STEM}_{config['param_set_name']}.stl --export-format binstl {params} {SCAD_FILE}"
    print(f"command: {command}")
    subprocess.check_call(
        command,
    )
