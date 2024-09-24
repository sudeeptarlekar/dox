import unittest
from dox_style.checks.underline_length_check import (
    UnderlineLengthFinding,
    UnderlineLengthCheck,
)


class UnderlineLengthTest(unittest.TestCase):
    def test_underline_lengths(self):
        headings = [
            "Heading 1",
            "=========",
            "Heading 1.1",
            "-----------",
            "Heading 1.1.1",
            "++++++++++++++",
            "Lorem ipsum dolor sit amet",
            "42",
            "Heading 1.1.1.1",
            "~~~~~~~~~~~~~~",
            "Heading 1.1.1.1.1",
            "^^^^^^^^^^^^^^^^^",
            "Heading 2",
            "=========",
        ]

        asserted_result = [
            UnderlineLengthFinding("index.rst", 6).as_str(True),
            UnderlineLengthFinding("index.rst", 10).as_str(True),
        ]

        check = UnderlineLengthCheck()
        check.run("index.rst", headings)
        findings = [x.as_str(True) for x in check.findings]
        self.assertListEqual(findings, asserted_result)
