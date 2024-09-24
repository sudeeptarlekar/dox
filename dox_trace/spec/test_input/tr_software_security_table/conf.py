import sys
from pathlib import Path

EXTENSION_ROOT = Path("../../../../")
sys.path.extend([str(path.resolve()) for path in EXTENSION_ROOT.glob("*")])

extensions = ["dox_style", "dox_trace", "sphinxcontrib.jquery"]

dox_trace_dim_root = "export_root"
dox_trace_properties_file = "properties.yaml"

dox_trace_security_backward = True
