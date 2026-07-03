from pathlib import Path
import subprocess


VERSION=1
PARAMETERS=(
    {
        "param_set_name":"2xstandee_1xcard",
        "standee_layer_count": 2,
        "stat_card_depression": 0.75,
    },
    {
        "param_set_name":"3xstandee_3xcard",
        "standee_layer_count": 3,
        "stat_card_depression": 1.9,
    },
    {
        "param_set_name":"5xstandee_bosscards",
        "standee_layer_count": 5,
        "stat_card_depression": 7,
    },
)

output_path = Path("boxes")
output_path.mkdir(parents=True, exist_ok=True)

for config in PARAMETERS:
    print(f"Processing: {config}")
    params = " ".join([f"-D {k}={v}" for k,v in config.items() if k != "param_set_name"])
    print(f"params: {params}")
    command = f"openscad -o ./boxes/monster_box_{config['param_set_name']}.stl --export-format binstl {params} ./monster_box_v{VERSION}.scad"
    print(f"command: {command}")
    subprocess.check_call(
        command,
    )
