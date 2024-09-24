import os
import unittest

from tempfile import NamedTemporaryFile
from dox_style.checks import Finding


class FindingTest(unittest.TestCase):
    def test_takes_filename_and_line(self):
        finding = Finding(file="index.rst", line=42)
        self.assertEqual(finding.file, "index.rst")
        self.assertEqual(finding.line, 42)

    def test_as_str_is_a_descriptive_string(self):
        finding = Finding(file="index.rst", line=42)
        string = finding.as_str()
        self.assertIn(Finding.NAME, string)

    def test_contains_excerpt_from_file(self):
        with self.subTest("middle"):
            try:
                with NamedTemporaryFile(delete=False) as tmp_file:
                    tmp_file.write("first_line\nsecond_line\nthird_line".encode())
                finding = Finding(file=tmp_file.name, line=2)
                string = finding.as_str(show_excerpt=1)
                self.assertIn("first_line", string)
                self.assertIn("second_line", string)
                self.assertIn("third_line", string)
            finally:
                os.remove(tmp_file.name)

        with self.subTest("first"):
            try:
                with NamedTemporaryFile(delete=False) as tmp_file:
                    tmp_file.write("first_line\nsecond_line\nthird_line".encode())
                finding = Finding(file=tmp_file.name, line=1)
                string = finding.as_str(show_excerpt=1)
                self.assertIn("first_line", string)
                self.assertIn("second_line", string)
                self.assertNotIn("third_line", string)
            finally:
                os.remove(tmp_file.name)

        with self.subTest("last"):
            try:
                with NamedTemporaryFile(delete=False) as tmp_file:
                    tmp_file.write("first_line\nsecond_line\nthird_line".encode())
                finding = Finding(file=tmp_file.name, line=3)
                string = finding.as_str(show_excerpt=1)
                self.assertNotIn("first_line", string)
                self.assertIn("second_line", string)
                self.assertIn("third_line", string)
            finally:
                os.remove(tmp_file.name)

    def test_excerpt_contains_filename_if_file_not_found(self):
        finding = Finding(file="non-existent", line=2)
        string = finding.as_str(show_excerpt=1)
        self.assertIn("non-existent", string)

    def test_excerpt_contains_filename_if_line_not_found(self):
        try:
            with NamedTemporaryFile(delete=False) as tmp_file:
                tmp_file.write("first line\nsecond_line\nthird_line".encode())
            finding = Finding(file=tmp_file.name, line=999)
            string = finding.as_str(show_excerpt=1)
            self.assertIn(tmp_file.name, string)
        finally:
            os.remove(tmp_file.name)


class ConcreteFinding(Finding):
    NAME = "ConcreteFinding"

    def __init__(self, file, line, some_arg):
        super().__init__(file, line)
        self.some_arg = some_arg

    def msg(self):
        return f"Custom message with {self.some_arg}"


class ConcreteFindingTest(unittest.TestCase):
    def test_concrete_test_finding(self):
        finding = ConcreteFinding(file="index.rst", line=42, some_arg="foobar")
        string = finding.as_str()
        self.assertIn(ConcreteFinding.NAME, string)
        self.assertIn("foobar", string)
