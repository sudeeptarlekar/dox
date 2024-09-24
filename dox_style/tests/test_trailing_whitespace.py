import unittest
from dox_style.checks.trailing_whitespace_check import (
    TrailingWhitespacesCheck,
    TrailingWhitespacesFinding,
)


class TrailingWhitespaceTest(unittest.TestCase):
    def test_whitespaces(self):
        test_string = [
            "",
            "Lorem ipsum dolor sit amet,    ",
            "consectetur adipiscing elit,",
            "    ",
            "sed do eiusmod tempor incididunt ut labore et dolore",
            "magna aliqua.",
        ]

        asserted_result = [
            TrailingWhitespacesFinding("index.rst", 2).as_str(True),
            TrailingWhitespacesFinding("index.rst", 4).as_str(True),
        ]

        check = TrailingWhitespacesCheck()
        check.run("index.rst", test_string)
        findings = [x.as_str(True) for x in check.findings]
        self.assertListEqual(findings, asserted_result)
