Heading
=======

.. spec:: SMD_Req_deref1
    :developer: Abc AG
    :status: valid
    :refs: SMD_Req_refderef1, SMD_Req_refderef2, SMD_Second_ref1

.. interface:: SMD_Req_refderef1
    :developer: Abc AG
    :status: valid
    :refs: SMD_Req_refderef2

.. spec:: SMD_Req_refderef2
    :developer: Abc AG
    :status: valid
    :refs: SMD_Req_notset2

.. unit:: SMD_Req_no1
    :developer: Abc AG
    :status: valid

.. spec:: SMD_Req_deref2
    :developer: Abc AG
    :status: valid
    :sources: index.rst, second.rst
    :refs: SMD_Req_notset2

.. spec:: SMD_Req_deref3
    :developer: Abc AG
    :status: valid
    :sources: index.rst

.. spec:: SMD_Req_deref4
    :developer: Abc AG
    :status: valid
    :refs: invalid_ref

Upper Level
-----------

.. spec:: SMD_Level_none
    :developer: Abc AG
    :status: valid

.. spec:: SMD_Level_smd
    :developer: Abc AG
    :status: valid

.. spec:: SMD_Level_swa
    :developer: Abc AG
    :status: valid

.. spec:: SMD_Level_srs
    :developer: Abc AG
    :status: valid

.. spec:: SMD_Level_software
    :developer: Abc AG
    :status: valid

.. spec:: SMD_Level_input
    :developer: Abc AG
    :status: valid

.. spec:: SMD_Level_all
    :developer: Abc AG
    :status: valid

.. spec:: SMD_Parent_smd
    :developer: Abc AG
    :status: valid
    :refs: SMD_Level_smd, SMD_Level_all

.. spec:: SWA_Parent_swa
    :developer: Abc AG
    :status: valid
    :refs: SMD_Level_swa, SMD_Level_all

.. srs:: SRS_Parent_srs
    :developer: Abc AG
    :status: valid
    :refs: SMD_Level_srs, SMD_Level_all

.. requirement:: SRS_Parent_software
    :category: software
    :developer: Abc AG
    :status: valid
    :refs: SMD_Level_software, SMD_Level_all

.. requirement:: Input_Parent_input
    :category: input
    :review_status: accepted
    :status: valid
    :refs: SMD_Level_input, SMD_Level_all


.. toctree::

    second
    third
    report
