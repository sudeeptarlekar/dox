import unittest

from dox_style.checks import Check, Finding


class CheckTest(unittest.TestCase):
    def test_run_raises_not_implemented_error(self):
        check = Check()

        with self.assertRaises(NotImplementedError):
            check.run("index.rst", [])


class ConcreteFinding(Finding):
    NAME = "ConcreteFinding"

    def __init__(self, file, line, some_arg):
        super().__init__(file, line)
        self.some_arg = some_arg

    def msg(self):
        return f"Custom message with {self.some_arg}"


class ConcreteCheck(Check):
    FINDING = ConcreteFinding

    def run(self, file, lines):
        self.add_finding(file, 42, some_arg="foobar")


class ConcreteCheckTest(unittest.TestCase):
    def test_run_adds_finingnot_implemented_error(self):
        lines = ["first", "second", "third"]

        check = ConcreteCheck()
        check.run("index.rst", lines)
        self.assertEqual(len(check.findings), 1)
        self.assertIn("foobar", check.findings[0].as_str())
