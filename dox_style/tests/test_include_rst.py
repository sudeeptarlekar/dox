import unittest
from dox_style.checks.include_rst_check import IncludeRstCheck, IncludeRstFinding


class IncludeRstTest(unittest.TestCase):
    def test_includes(self):
        bad_headings = [
            ".. include:: x.rst",
            "..include:: x.rst",
            ". . include:: x.rst",
            ".. include: : x.rst",
            ".. include:: x.rstX",
            "..  include ::   x.rst",
        ]

        findings = [
            IncludeRstFinding("badFile.rst", 1).as_str(True),
            IncludeRstFinding("badFile.rst", 6).as_str(True),
        ]

        check = IncludeRstCheck()
        check.run("badFile.rst", bad_headings)

        actual_findings = [f.as_str(True) for f in check.findings]
        self.assertListEqual(actual_findings, findings)
