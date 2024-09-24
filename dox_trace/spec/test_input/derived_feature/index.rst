Derived Feature
===============

Shown
-----

.. requirement:: SRS_Requirement_Shown
    :category: software

.. spec:: SWA_Spec_Shown

.. unit:: SMD_Unit_Shown

.. interface:: SWA_Interface_Shown

.. srs:: SRS_Srs_Shown

Not Shown
---------

.. requirement:: InputRequirement_NotShown
    :category: input

.. information:: InputInformation_NotShown
    :category: input

.. information:: SRS_Information_NotShown
    :category: software

.. mod:: SWA_Mod_NotShown

Parent and Grandparents
-----------------------

.. requirement:: Requirement_H
    :category: input
    :refs: Requirement_J
    :feature: H

.. requirement:: Requirement_I
    :category: input
    :refs: Requirement_K
    :feature: I

.. requirement:: Requirement_J
    :category: input
    :refs: SRS_Requirement_child
    :feature: J

.. requirement:: Requirement_K
    :category: input
    :refs: SRS_Requirement_child
    :feature: K

.. requirement:: Requirement_L
    :category: input
    :refs: SRS_Req_Parent
    :feature: L

.. requirement:: SRS_Req_Parent
    :refs: SRS_Requirement_child
    :category: software

.. requirement:: SRS_Requirement_child
    :category: software

Dismiss
-------

.. requirement:: Requirement_A
    :refs: Requirement_C, SWA_Spec_unique
    :feature: A
    :category: input

.. requirement:: Requirement_B
    :refs: SWA_Spec_strike, SRS_information_notStruck, SWA_Spec_unique
    :feature: B
    :category: input

.. requirement:: Requirement_C
    :refs: SWA_Spec_ignoreBackRefs
    :feature: C
    :status: invalid
    :category: input

.. spec:: SWA_Spec_strike
    :refs: SWA_Spec_ignoreBackRefs
    :status: invalid

.. information:: SRS_information_notStruck
    :refs: SWA_Spec_ignoreBackRefs
    :category: software

.. spec:: SWA_Spec_ignoreBackRefs

Unique
------

.. requirement:: Requirement_B2
    :refs: SWA_Spec_unique
    :feature: B
    :category: input

.. spec:: SWA_Spec_unique

Multiline
---------

.. requirement:: Requirement_M1
    :refs: SWA_Spec_multi
    :feature: :raw-html:`X<br>Y`
    :category: input

.. requirement:: Requirement_M2
    :refs: SWA_Spec_multi
    :feature: :raw-html:`X`
    :category: input

.. spec:: SWA_Spec_multi
