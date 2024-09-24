import sys
from pathlib import Path

EXTENSION_ROOT = Path("../../../../")
sys.path.extend([str(path.resolve()) for path in EXTENSION_ROOT.glob("*")])

extensions = ["dox_style", "dox_trace", "sphinxcontrib.jquery"]

dox_trace_dim_root = "export_root"

project = "Test Project"

dox_trace_custom_attributes = {
    "custom1": {"directives": ["unit"], "type": "text"},
    "custom2": {"directives": ["spec"], "type": "text"},
    "custom3": {"directives": ["interface"], "type": "text"},
    "custom4": {"directives": ["mod"], "type": "text"},
    "custom5": {"directives": ["requirement"], "categories": ["software"], "type": "text"},
    "custom6": {"directives": ["information"], "categories": ["software"], "type": "text"},
    "custom7": {
        "directives": ["unit", "spec", "interface", "mod", "requirement", "information", "srs"],
        "categories": ["software"],
        "type": "text",
    },
    "custom8": {"directives": ["unit", "unit", "spec", "unit"], "type": "text"},
    "custom9": {"directives": ["srs"], "type": "text"},
}
