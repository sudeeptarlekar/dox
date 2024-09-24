Verification Criteria
=====================

.. _available:

Available
---------

.. requirement:: SRS_Requirement_VcSet
    :verification_criteria: Aa: :ref:`available`!
    :category: software

.. requirement:: InputRequirement_VcSet
    :verification_criteria: Bb
    :category: input

.. srs:: SRS_Srs_VcSet
    :verification_criteria: Aa: :ref:`available`!

.. spec:: SWA_Spec_VcSet
    :verification_criteria: Cc

.. unit:: SMD_Unit_VcSet
    :verification_criteria: :raw-html:`Hello<br>world!`

.. interface:: SWA_Interface_VcSet
    :verification_criteria: Dd

.. interface:: SMD_Interface_VcSet
    :verification_criteria: Ee

Empty
-----

.. srs:: SRS_Srs_VcEmpty
    :verification_criteria:

.. requirement:: SRS_Requirement_VcEmptyRaw
    :verification_criteria: :raw-html:``
    :category: software

Default
-------

.. requirement:: SRS_Requirement_VcDefault
    :category: software

.. requirement:: InputRequirement_VcDefault
    :category: input

.. srs:: SRS_Srs_VcDefault

.. spec:: SWA_Spec_VcDefault

.. unit:: SMD_Unit_VcDefault

.. interface:: SWA_Interface_VcDefault

.. interface:: SMD_Interface_VcDefault

Additional
----------

.. requirement:: SRS_Requirement_VcDefaultTool
    :category: software
    :tags: tool

.. requirement:: SRS_Requirement_VcDefaultStruck
    :category: software
    :status: invalid

.. srs:: SRS_Srs_VcDefaultTool
    :tags: tool

.. srs:: SRS_Srs_VcDefaultStruck
    :status: invalid
