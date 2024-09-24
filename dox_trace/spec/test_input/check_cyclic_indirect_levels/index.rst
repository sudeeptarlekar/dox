Check Cyclic Indirect Levels
============================

.. requirement:: Input_Requirement_Indirect1
    :refs: Input_Requirement_Indirect2
    :category: input

.. requirement:: Input_Requirement_Indirect2
    :refs: Input_Requirement_Indirect3, SRS_Requirement_Indirect4
    :category: input

.. requirement:: Input_Requirement_Indirect3
    :category: input

.. requirement:: SRS_Requirement_Indirect4
    :refs: Input_Requirement_Indirect1
    :category: software



.. spec:: SWA_Spec_Indirect1
    :refs: SWA_Spec_Indirect2

.. spec:: SWA_Spec_Indirect2
    :refs: SWA_Spec_Indirect3, SMD_Spec_Indirect4

.. spec:: SWA_Spec_Indirect3

.. spec:: SMD_Spec_Indirect4
    :refs: SWA_Spec_Indirect1
