import unittest
from dox_style.checks.heading_levels_check import HeadingLevelsCheck, HeadingLevelsFinding


class TrailingWhitespaceTest(unittest.TestCase):
    def test_good_heading_levels(self):
        good_headings = [
            "Heading 1",
            "=========",
            "Heading 1.1",
            "-----------",
            "Heading 1.1.1",
            "+++++++++++++",
            "Heading 1.1.1.1",
            "~~~~~~~~~~~~~~~",
            "Heading 1.1.1.1.1",
            "^^^^^^^^^^^^^^^^^",
            "Heading 1.1.1.1.1.1",
            '"""""""""""""""""""',
            "Heading 1.1.1.1.1.2",
            '"""""""""""""""""""',
            "Heading 1.1.1.1.2",
            "^^^^^^^^^^^^^^^^^",
            "Heading 1.2",
            "-----------",
            "Heading 2",
            "=========",
            "Heading 2.1",
            "-----------",
            "Heading 2.2",
            "-----------",
            "Heading 2.2.1",
            "+++++++++++++",
        ]

        check = HeadingLevelsCheck()
        check.run("goodFile.rst", good_headings)
        self.assertListEqual(check.findings, [])

    def test_bad_heading_levels(self):
        bad_headings = [
            "Heading 1",
            "=========",
            "Heading 1.1",
            "-----------",
            "Heading 1.1.1.1",
            "~~~~~~~~~~~~~~~",
            "Heading 1.1.1.1.1",
            "^^^^^^^^^^^^^^^^^",
            "Heading 1.1.1.1.1.1",
            '"""""""""""""""""""',
            "Heading 1.1.1.1.1.2",
            '"""""""""""""""""""',
            "Heading 1.1.1.1.2",
            "^^^^^^^^^^^^^^^^^",
            "Heading 1.2",
            "-----------",
            "Heading 2",
            "=========",
            "Heading 2.1",
            "-----------",
            "Heading 2.2.1.1.1",
            "^^^^^^^^^^^^^^^^^",
        ]

        findings = [
            HeadingLevelsFinding("badFile.rst", 6, expected_char="+", actual_char="~").as_str(True),
            HeadingLevelsFinding("badFile.rst", 22, expected_char="+", actual_char="^").as_str(
                True
            ),
        ]

        check = HeadingLevelsCheck()
        check.run("badFile.rst", bad_headings)

        actual_findings = [f.as_str(True) for f in check.findings]
        self.assertListEqual(actual_findings, findings)
