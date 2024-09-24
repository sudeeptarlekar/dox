import unittest
from dox_style.checks.utils import is_heading, is_index, get_module


class TrailingWhitespaceTest(unittest.TestCase):
    def test_heading_regex(self):
        self.assertTrue(is_heading("====="))
        self.assertTrue(is_heading("-"))
        self.assertTrue(is_heading("''''''"))
        self.assertTrue(is_heading("`````````"))
        self.assertTrue(is_heading(":::::::::"))
        self.assertTrue(is_heading('"""""'))
        self.assertTrue(is_heading("~~~~~"))
        self.assertTrue(is_heading("^^^^^"))
        self.assertTrue(is_heading("______"))
        self.assertTrue(is_heading("*****"))
        self.assertTrue(is_heading("+++++++++"))
        self.assertTrue(is_heading("#########"))
        self.assertTrue(is_heading("<<<<<<<<<"))
        self.assertTrue(is_heading(">>>>>>>>>"))
        self.assertFalse(is_heading("==-=="))
        self.assertFalse(is_heading("><><><"))
        self.assertFalse(is_heading("----- Lorem Ipsum"))
        self.assertFalse(is_heading("Lorem Ipsum #######"))

    def test_module_name(self):
        self.assertTrue(is_index("/path/to/lib/ModuleName/doc/index.rst"))
        self.assertFalse(is_index("/path/to/lib/ModuleName/doc/subdir/index.rst"))
        self.assertFalse(is_index("/path/to/lib/ModuleName/doc/subchapter.rst"))

        self.assertEqual(get_module("/path/to/lib/ModuleName/doc/index.rst"), "ModuleName")
        self.assertEqual(get_module("/path/to/lib/ModuleName/doc/subdir/index.rst"), None)
        self.assertEqual(get_module("/path/to/lib/ModuleName/doc/subchapter.rst"), None)
