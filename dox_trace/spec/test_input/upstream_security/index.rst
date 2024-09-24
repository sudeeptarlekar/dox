Parent Security
===============

Shown
-----

.. requirement:: SRS_Requirement_yes
    :category: software
    :refs: SMD_Spec_ignoreBackRefs1, SWA_Spec_unique
    :security: yes

.. information:: SRS_Information_no
    :category: software
    :refs: SMD_Spec_ignoreBackRefs1
    :security: no

.. srs:: SRS_Srs_yes
    :refs: SMD_Spec_ignoreBackRefs1, SWA_Spec_unique
    :security: yes

.. spec:: SWA_Spec_notSet
    :refs: SMD_Spec_ignoreBackRefs1, SWA_Spec_unique
    :security: not_set

.. unit:: SMD_Unit_yes
    :refs: SMD_Spec_ignoreBackRefs2
    :security: yes

.. interface:: SWA_Interface_no
    :refs: SMD_Spec_ignoreBackRefs2
    :security: no

.. mod:: SWA_Mod_yes
    :security: yes

Not Shown
---------

.. requirement:: InputRequirement_notSet
    :category: input
    :refs: SMD_Spec_ignoreBackRefs2
    :security: not_set

.. information:: InputInformation_yes
    :category: input
    :refs: SMD_Spec_ignoreBackRefs3
    :security: yes

Parent and Grandparents
-----------------------

.. spec:: SWA_Spec_yesP1
    :refs: SWA_Spec_noP
    :security: yes

.. spec:: SWA_Spec_yesP2
    :refs: SWA_Spec_notSetP
    :security: yes

.. spec:: SWA_Spec_noP
    :refs: SWA_Spec_child
    :security: no

.. spec:: SWA_Spec_notSetP
    :refs: SWA_Spec_child
    :security: not_set

.. spec:: SWA_Spec_child

Dismiss
-------

.. spec:: SWA_Spec_strike
    :refs: SMD_Spec_ignoreBackRefs3
    :security: no
    :status: invalid

.. unit:: SMD_Spec_ignoreBackRefs1

.. unit:: SMD_Spec_ignoreBackRefs2

.. unit:: SMD_Spec_ignoreBackRefs3

Unique
------

.. spec:: SWA_Spec_yesU
    :refs: SWA_Spec_unique
    :security: yes

.. spec:: SWA_Spec_unique

Cal
---

.. spec:: SWA_Spec_Cal1
    :refs: SWA_Spec_Cal
    :cal: CAL_1

.. spec:: SWA_Spec_Qm
    :refs: SWA_Spec_Cal
    :cal: QM

.. spec:: SWA_Spec_no
    :refs: SWA_Spec_Cal
    :security: no
    :cal: not_set

.. spec:: SWA_Spec_Cal
