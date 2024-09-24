Backward References
===================

1 to N
------

.. requirement:: InputRequirement_Parent
    :category: input
    :refs: SRS_Requirement_BackwardRefsShown,
           SRS_Information_BackwardRefsShown,
           InputRequirement_BackwardRefsShown,
           InputInformation_BackwardRefsShown,
           SRS_Srs_BackwardRefsShown,
           SWA_Spec_BackwardRefsShown,
           SMD_Unit_BackwardRefsShown,
           SWA_Interface_BackwardRefsShown

.. requirement:: SRS_Requirement_BackwardRefsShown
    :category: software

.. information:: SRS_Information_BackwardRefsShown
    :category: software

.. requirement:: InputRequirement_BackwardRefsShown
    :category: input

.. information:: InputInformation_BackwardRefsShown
    :category: input

.. srs:: SRS_Srs_BackwardRefsShown

.. spec:: SWA_Spec_BackwardRefsShown

.. unit:: SMD_Unit_BackwardRefsShown

.. interface:: SWA_Interface_BackwardRefsShown

N to 1
------

.. requirement:: SRS_Requirement_Ref
    :category: software
    :refs: SMD_Unit_All

.. information:: SRS_Information_Ref
    :category: software
    :refs: SMD_Unit_All

.. requirement:: InputRequirement_Ref
    :category: input
    :refs: SMD_Unit_All

.. information:: InputInformation_Ref
    :category: input
    :refs: SMD_Unit_All

.. srs:: SRS_Srs_Ref

.. spec:: SWA_Spec_Ref

.. unit:: SMD_Unit_Ref
    :refs: SMD_Unit_All

.. interface:: SWA_Interface_Ref
    :refs: SMD_Unit_All

.. unit:: SMD_Unit_All
    :refs: SRS_Srs_Ref, SWA_Spec_Ref

Default
-------

.. requirement:: SRS_Requirement_RefsDefault
    :category: software

.. information:: SRS_Information_RefsDefault
    :category: software

.. requirement:: InputRequirement_RefsDefault
    :category: input

.. information:: InputInformation_RefsDefault
    :category: input

.. srs:: SRS_Srs_RefsDefault

.. mod:: SWA_Mod_RefsDefault

.. spec:: SWA_Spec_RefsDefault

.. unit:: SMD_Unit_RefsDefault

.. interface:: SWA_Interface_RefsDefault

.. interface:: SMD_Interface_RefsDefault


Unique
------

.. interface:: SWA_Interface_UniqueParent
    :refs: SWA_Spec_Unique, SWA_Spec_Unique

.. spec:: SWA_Spec_UniqueParent
    :refs: SWA_Spec_Unique, SWA_Spec_Unique

.. spec:: SWA_Spec_Unique

Round Trip
----------

.. spec:: SWA_Spec_RoundTrip
    :refs: SMD_Spec_RoundTrip

.. spec:: SMD_Spec_RoundTrip
    :refs: SWA_Spec_RoundTrip

Special
-------

.. srs:: SRS_Srs_Tool
    :tags: tool

.. srs:: SRS_srs_Invalid
    :status: invalid
