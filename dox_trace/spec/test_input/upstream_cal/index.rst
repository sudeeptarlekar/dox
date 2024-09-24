Parent Security
===============

Shown
-----

.. requirement:: SRS_Requirement_Cal1
    :category: software
    :refs: SMD_Spec_ignoreBackRefs1, SWA_Spec_unique
    :cal: CAL_1

.. information:: SRS_Information_Qm
    :category: software
    :refs: SMD_Spec_ignoreBackRefs1
    :cal: QM

.. srs:: SRS_Srs_Cal2
    :refs: SWA_Spec_unique
    :cal: CAL_2

.. spec:: SWA_Spec_notSet
    :refs: SMD_Spec_ignoreBackRefs1, SWA_Spec_unique
    :cal: not_set

.. unit:: SMD_Unit_Cal3
    :refs: SMD_Spec_ignoreBackRefs2
    :cal: CAL_3

.. interface:: SWA_Interface_Qm
    :refs: SMD_Spec_ignoreBackRefs2
    :cal: QM

.. mod:: SWA_Mod_Cal2
    :cal: CAL_2

Not Shown
---------

.. requirement:: InputRequirement_notSet
    :category: input
    :refs: SMD_Spec_ignoreBackRefs2
    :cal: not_set

.. information:: InputInformation_Cal1
    :category: input
    :refs: SMD_Spec_ignoreBackRefs3
    :cal: CAL_1

Parent and Grandparents
-----------------------

.. spec:: SWA_Spec_Cal1P1
    :refs: SWA_Spec_QmP
    :cal: CAL_1

.. spec:: SWA_Spec_Cal1P2
    :refs: SWA_Spec_notSetP
    :cal: CAL_1

.. spec:: SWA_Spec_QmP
    :refs: SWA_Spec_child
    :cal: QM

.. spec:: SWA_Spec_notSetP
    :refs: SWA_Spec_child
    :cal: not_set

.. spec:: SWA_Spec_child

Dismiss
-------

.. spec:: SWA_Spec_strike
    :refs: SMD_Spec_ignoreBackRefs3
    :security: no
    :status: invalid

.. unit:: SMD_Spec_ignoreBackRefs1
    :refs: SRS_Srs_Cal2

.. unit:: SMD_Spec_ignoreBackRefs2

.. unit:: SMD_Spec_ignoreBackRefs3

Unique
------

.. spec:: SWA_Spec_yesU
    :refs: SWA_Spec_unique
    :cal: CAL_1

.. spec:: SWA_Spec_unique

Security
--------

.. spec:: SWA_Spec_SecYes
    :refs: SWA_Spec_Cal
    :security: yes

.. spec:: SWA_Spec_SecNo
    :refs: SWA_Spec_Cal
    :security: no

.. spec:: SWA_Spec_SecNotSet
    :refs: SWA_Spec_Cal
    :cal: QM
    :security: not_set

.. spec:: SWA_Spec_Cal
