import sys
from pathlib import Path

EXTENSION_ROOT = Path("../../../../")
sys.path.extend([str(path.resolve()) for path in EXTENSION_ROOT.glob("*")])

extensions = ["dox_style", "dox_trace", "sphinxcontrib.jquery"]

dox_trace_dim_root = "export_root"

project = "Test Project"

dox_trace_custom_attributes = {
    "custom1": {"directives": ["unit"], "type": "text", "export": "yes"},
    "custom2": {"directives": ["unit"], "type": "text", "export": "no"},
    "custom3": {"directives": ["unit"], "type": "text"},
    "custom_complex_text": {"directives": ["mod"], "type": "text", "export": "yes"},
    "custom_enum": {"directives": ["mod"], "type": "enum", "export": "yes"},
    "custom_refs": {"directives": ["mod"], "type": "refs", "export": "yes"},
}
