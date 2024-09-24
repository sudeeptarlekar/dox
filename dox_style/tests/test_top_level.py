import unittest
from dox_style.checks.top_level_casing_check import TopLevelCasingCheck, TopLevelCasingFinding
from dox_style.checks.top_level_heading_check import (
    TopLevelHeadingCheck,
    TopLevelHeadingFinding,
)
from dox_style.checks.top_level_length_check import TopLevelLengthCheck, TopLevelLengthFinding
from dox_style.checks.top_level_modulename_check import (
    TopLevelModuleNameCheck,
    TopLevelModuleNameFinding,
)


class TopLevelModuleCasingTest(unittest.TestCase):
    def test_correct_casing(self):
        test_string = ["MyModule", "========", "Lorem ipsum"]

        check = TopLevelCasingCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)
        self.assertListEqual(check.findings, [])

    def test_incorrect_casing(self):
        test_string = ["Mymodule", "========", "Lorem ipsum"]

        check = TopLevelCasingCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)

        asserted_result = [TopLevelCasingFinding("/path/to/MyModule/doc/index.rst", 1).as_str(True)]
        findings = [x.as_str(True) for x in check.findings]

        self.assertListEqual(findings, asserted_result)

    def test_module_not_in_heading(self):
        test_string = ["Some other top heading", "======================", "Lorem ipsum"]

        check = TopLevelCasingCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)
        self.assertListEqual(check.findings, [])

    def test_not_root_file(self):
        test_string = ["Some other top heading", "======================", "Lorem ipsum"]

        check = TopLevelCasingCheck()
        check.run("/path/to/MyModule/doc/subchapter/index.rst", test_string)
        self.assertListEqual(check.findings, [])


class TopLevelHeadingTest(unittest.TestCase):
    def test_correct_heading(self):
        test_string = ["Heading", "======="]

        check = TopLevelHeadingCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)
        self.assertListEqual(check.findings, [])

    def test_no_heading(self):
        test_string = ["This file has no heading", "42", "Lorem ipsum"]

        check = TopLevelHeadingCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)

        asserted_result = [
            TopLevelHeadingFinding("/path/to/MyModule/doc/index.rst", 1).as_str(True)
        ]
        findings = [x.as_str(True) for x in check.findings]

        self.assertListEqual(findings, asserted_result)

    def test_no_heading_underline_too_short(self):
        test_string = ["Not a Heading", "==="]

        check = TopLevelHeadingCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)
        self.assertListEqual(check.findings, [])

    def test_heading_in_no_root_file(self):
        test_string = ["Heading", "======="]

        check = TopLevelHeadingCheck()
        check.run("/path/to/MyModule/doc/subchapter/index.rst", test_string)
        self.assertListEqual(check.findings, [])


class TopLevelLengthTest(unittest.TestCase):
    def test_correct_heading(self):
        test_string = ["Heading", "======="]

        check = TopLevelLengthCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)
        self.assertListEqual(check.findings, [])

    def test_incorrect_length(self):
        test_string = [
            "MyModule: this title is longer than 40 characters.",
            "==================================================",
        ]

        check = TopLevelLengthCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)

        asserted_result = [
            TopLevelLengthFinding("/path/to/MyModule/doc/index.rst", 1, 40, 50).as_str(True)
        ]
        findings = [x.as_str(True) for x in check.findings]

        self.assertListEqual(findings, asserted_result)

    def test_heading_length_in_no_root_file(self):
        test_string = [
            "Subchapter: This title is longer than 40 characters.",
            "====================================================",
        ]

        check = TopLevelLengthCheck()
        check.run("/path/to/MyModule/doc/subchapter/index.rst", test_string)
        self.assertListEqual(check.findings, [])


class TopLevelModuleNameTest(unittest.TestCase):
    def test_correct_heading(self):
        test_string = ["MyModule", "======="]

        check = TopLevelModuleNameCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)
        self.assertListEqual(check.findings, [])

    def test_heading_with_wrong_casing(self):
        test_string = ["MymOdule", "======="]

        check = TopLevelModuleNameCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)
        self.assertListEqual(check.findings, [])

    def test_heading_without_modulename(self):
        test_string = ["Heading", "======="]

        check = TopLevelModuleNameCheck()
        check.run("/path/to/MyModule/doc/index.rst", test_string)

        asserted_result = [
            TopLevelModuleNameFinding("/path/to/MyModule/doc/index.rst", 1, "MyModule").as_str(True)
        ]
        findings = [x.as_str(True) for x in check.findings]

        self.assertListEqual(findings, asserted_result)

    def test_heading_in_no_root_file(self):
        test_string = ["Heading", "======="]

        check = TopLevelModuleNameCheck()
        check.run("/path/to/MyModule/doc/subchapter/index.rst", test_string)
        self.assertListEqual(check.findings, [])
