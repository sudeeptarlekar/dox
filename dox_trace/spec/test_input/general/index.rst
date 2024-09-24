General
=======

Anchor
------

.. requirement:: SRS_Requirement_Anchor
    :category: software

.. information:: SRS_Information_Anchor
    :category: software

.. srs:: SRS_Srs_Anchor

.. spec:: SWA_Spec_Anchor

.. unit:: SMD_Unit_Anchor

.. interface:: SWA_Interface_Anchor

- :ref:`SRS_Requirement_Anchor`
- :ref:`SRS_Information_Anchor`
- :ref:`SRS_Srs_Anchor`
- :ref:`SWA_Spec_Anchor`
- :ref:`SMD_Unit_Anchor`
- :ref:`SWA_Interface_Anchor`

Stripped and Empty
------------------

.. spec:: SWA_Spec_NotSpecified

.. spec:: SWA_Spec_NoValue
    :status:

.. spec:: SWA_Spec_DoubleSingle
    :status: " '' "

.. spec:: SWA_Spec_SingleDouble
    :status: ' "" '

.. spec:: SWA_Spec_Spaces
    :status: '  '

.. spec:: SWA_Spec_Stripped
    :status: ' valid '

Multi
-----

.. unit:: SMD_Unit_MultiStripAndUnique
    :tags: obd,,  swa,  smd, "",''    ,swa
    :verification_methods: on_target,,  on_target,  off_target, "",''    ,manual
    :sources: conf.py,,  index.rst,  conf.py, "",''    ,Makefile
    :refs: SRS_Requirement_Anchor,,  SRS_Information_Anchor,  SRS_Requirement_Anchor, "",''    ,SMD_Unit_Anchor

.. unit:: SMD_Unit_MultiEmpty
    :tags: ,
    :verification_methods: ,,
    :sources: , , ,
    :refs: "",''

    SubheadingMulti
    +++++++++++++++

    SubheadingMulti2
    ~~~~~~~~~~~~~~~~

Free
----

.. unit:: SMD_Unit_Free
    :verification_criteria: ,,
    :status: ,,
    :developer: ,,
    :tester: ,,
    :asil: ,,
    :cal: ,,
    :review_status: ,,

    .. _anchor1:

    SubheadingFreeUnit
    ++++++++++++++++++

    Some text.

    SubheadingFreeUnit2
    ~~~~~~~~~~~~~~~~~~~

    Some text.

    .. _anchor2:

    SubheadingFreeUnit3
    ~~~~~~~~~~~~~~~~~~~

    .. code-block::

        Some code.

    SubheadingFreeUnit4
    ~~~~~~~~~~~~~~~~~~~

    Some text.

.. requirement:: Requirement_Free
    :category: input
    :feature: "  ,,  "
    :change_request: ',,'
    :comment: ,,
    :miscellaneous: ,,

    Some text.

    Subheading
    ++++++++++

    Some text.

    Subheading2
    ~~~~~~~~~~~

    .. code-block:: c++

        variable = 123;

Newlines Content
----------------

.. unit:: SMD_Unit_BlockBeforeFirstHeading

    Blah

    .. code-block:: c++

        variable = 123;

    SubheadingFreeUnit
    ++++++++++++++++++

Newlines Attribute
------------------

.. srs:: SRS_Requirement_NewLine1
    :custom_complex_text: No newline here

.. srs:: SRS_Requirement_NewLine2
    :custom_complex_text:
        No newline here

.. srs:: SRS_Requirement_NewLine3
    :custom_complex_text: No \
        newline \
        here \
        \

.. srs:: SRS_Requirement_NewLine4
    :custom_complex_text: \
        No newline here

.. srs:: SRS_Requirement_NewLine5
    :custom_complex_text:
        No newline \
        here

.. srs:: SRS_Requirement_NewLine6
    :custom_complex_text: Has
        three
        lines

.. srs:: SRS_Requirement_NewLine7
    :custom_complex_text: Has
        two \
        lines
