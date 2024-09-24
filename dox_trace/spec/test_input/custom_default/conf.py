import sys
from pathlib import Path

EXTENSION_ROOT = Path("../../../../")
sys.path.extend([str(path.resolve()) for path in EXTENSION_ROOT.glob("*")])

extensions = ["dox_style", "dox_trace", "sphinxcontrib.jquery"]

dox_trace_dim_root = "export_root"

project = "Test Project"

dox_trace_custom_attributes = {
    "custom1": {"directives": ["spec"], "type": "text"},
    "custom2": {"directives": ["spec"], "type": "text", "default": ""},
    "custom3": {"directives": ["spec"], "type": "text", "default": "d3"},
    "custom4": {"directives": ["spec"], "type": "enum"},
    "custom5": {"directives": ["spec"], "type": "enum", "default": []},
    "custom6": {"directives": ["spec"], "type": "enum", "default": ["d6", "d7", "d6"]},
    "custom7": {"directives": ["spec"], "type": "refs"},
    "custom8": {"directives": ["spec"], "type": "refs", "default": []},
    "custom9": {"directives": ["spec"], "type": "refs", "default": ["SMD_Custom_R1"]},
}
