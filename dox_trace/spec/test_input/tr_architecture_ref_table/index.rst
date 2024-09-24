Heading
=======

.. spec:: SWA_Req_deref1
    :developer: Abc AG
    :status: valid
    :refs: SWA_Req_refderef1, SWA_Req_refderef2, SWA_Second_ref1

.. interface:: SWA_Req_refderef1
    :developer: Abc AG
    :status: valid
    :refs: SWA_Req_refderef2

.. spec:: SWA_Req_refderef2
    :developer: Abc AG
    :status: valid
    :refs: SWA_Req_notset2

.. mod:: SWA_Req_no1
    :developer: Abc AG
    :status: valid

.. spec:: SWA_Req_deref2
    :developer: Abc AG
    :status: valid
    :sources: index.rst, second.rst
    :refs: SWA_Req_notset2

.. spec:: SWA_Req_deref3
    :developer: Abc AG
    :status: valid
    :sources: index.rst

.. mod:: SWA_Req_deref4
    :developer: Abc AG
    :status: valid
    :location: abc

.. mod:: SWA_Req_deref5
    :developer: Abc AG
    :status: valid
    :location: efg

Upper Level
-----------

.. spec:: SWA_Level_none
    :developer: Abc AG
    :status: valid

.. spec:: SWA_Level_swa
    :developer: Abc AG
    :status: valid

.. spec:: SWA_Level_srs
    :developer: Abc AG
    :status: valid

.. spec:: SWA_Level_software
    :developer: Abc AG
    :status: valid

.. spec:: SWA_Level_input
    :developer: Abc AG
    :status: valid

.. spec:: SWA_Level_all
    :developer: Abc AG
    :status: valid

.. spec:: SWA_Parent_swa
    :developer: Abc AG
    :status: valid
    :refs: SWA_Level_swa, SWA_Level_all

.. srs:: SRS_Parent_srs
    :developer: Abc AG
    :status: valid
    :refs: SWA_Level_srs, SWA_Level_all

.. requirement:: SRS_Parent_software
    :category: software
    :developer: Abc AG
    :status: valid
    :refs: SWA_Level_software, SWA_Level_all

.. requirement:: Input_Parent_input
    :category: input
    :review_status: accepted
    :status: valid
    :refs: SWA_Level_input, SWA_Level_all


.. toctree::

    second
    third
    report
    abc/doc/index
