import sys
from pathlib import Path

EXTENSION_ROOT = Path("../../../../")
sys.path.extend([str(path.resolve()) for path in EXTENSION_ROOT.glob("*")])

extensions = ["dox_style", "dox_trace", "sphinxcontrib.jquery"]

dox_trace_dim_root = "export_root"

project = "Test Project"

dox_trace_custom_attributes = {
    "custom1": {"directives": ["requirement"], "categories": ["software", "input"], "type": "text"},
    "custom2": {
        "directives": ["requirement", "information"],
        "categories": ["software"],
        "type": "text",
    },
    "custom3": {"directives": ["unit"], "categories": ["software"], "type": "text"},
    "custom4": {
        "directives": ["requirement"],
        "categories": ["system", "software", "input"],
        "type": "text",
    },
}
