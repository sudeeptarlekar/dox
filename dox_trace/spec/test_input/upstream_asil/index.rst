Parent Asil
===========

Shown
-----

.. requirement:: SRS_Requirement_A
    :category: software
    :refs: SMD_Spec_ignoreBackRefs, SWA_Spec_unique
    :asil: ASIL_A

.. information:: SRS_Information_B
    :category: software
    :refs: SMD_Spec_ignoreBackRefs
    :asil: ASIL_B

.. srs:: SRS_Srs_A
    :refs: SMD_Spec_ignoreBackRefs, SWA_Spec_unique
    :asil: ASIL_A

.. spec:: SWA_Spec_C
    :refs: SWA_Spec_unique
    :asil: ASIL_C

.. unit:: SMD_Unit_D
    :refs: SMD_Spec_ignoreBackRefs
    :asil: ASIL_D

.. interface:: SWA_Interface_AA
    :refs: SMD_Spec_ignoreBackRefs
    :asil: ASIL_A(A)

.. mod:: SWA_Mod_A
    :asil: ASIL_A

Not Shown
---------

.. requirement:: InputRequirement_AB
    :category: input
    :refs: SMD_Spec_ignoreBackRefs
    :asil: ASIL_A(B)

.. information:: InputInformation_AC
    :category: input
    :refs: SMD_Spec_ignoreBackRefs
    :asil: ASIL_A(C)

Parent and Grandparents
-----------------------

.. spec:: SWA_Spec_AD
    :refs: SWA_Spec_BC
    :asil: ASIL_A(D)

.. spec:: SWA_Spec_BB
    :refs: SWA_Spec_BD
    :asil: ASIL_B(B)

.. spec:: SWA_Spec_BC
    :refs: SWA_Spec_child
    :asil: ASIL_B(C)

.. spec:: SWA_Spec_BD
    :refs: SWA_Spec_child
    :asil: ASIL_B(D)

.. spec:: SWA_Spec_child

Dismiss
-------

.. spec:: SWA_Spec_strike
    :refs: SMD_Spec_ignoreBackRefs
    :asil: ASIL_C(D)
    :status: invalid

.. unit:: SMD_Spec_ignoreBackRefs
    :refs: SWA_Spec_C

Unique
------

.. spec:: SWA_Spec_A2
    :refs: SWA_Spec_unique
    :asil: ASIL_A

.. spec:: SWA_Spec_unique
