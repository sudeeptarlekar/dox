import sys
from pathlib import Path
from datetime import datetime

EXTENSION_ROOT = Path("../../..")
sys.path = [str(path.resolve()) for path in EXTENSION_ROOT.glob("dox_*")] + sys.path

project = "dox_style"
author = "Accenture"
copyright = (
    f"{datetime.now().year} Accenture. All rights reserved. "
    f"Accenture proprietary and confidential material"
)

global __version__
exec(open(f"../../{project}/version.py", "r").read(), globals())
version = __version__

html_context = {"document_status_default": "Released", "data_classification_default": None}

extensions = [
    "sphinxcontrib.jquery",
    "dox_style",
    "dox_util",
]
