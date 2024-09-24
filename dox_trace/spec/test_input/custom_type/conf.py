import sys
from pathlib import Path

EXTENSION_ROOT = Path("../../../../")
sys.path.extend([str(path.resolve()) for path in EXTENSION_ROOT.glob("*")])

extensions = ["dox_style", "dox_trace", "sphinxcontrib.jquery"]

dox_trace_dim_root = "export_root"

project = "Test Project"

dox_trace_custom_attributes = {
    "custom_complex_text": {"directives": ["spec"], "type": "text"},
    "custom2": {"directives": ["spec"], "type": "enum"},
    "custom3": {"directives": ["spec"], "type": "refs"},
}
