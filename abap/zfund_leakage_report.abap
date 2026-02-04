REPORT zfund_leakage_report.

INCLUDE zfund_types.
INCLUDE zfund_rules.

DATA: it_alloc TYPE STANDARD TABLE OF ty_allocation,
      it_util  TYPE STANDARD TABLE OF ty_utilization,
      it_res   TYPE STANDARD TABLE OF ty_result,
      wa_res   TYPE ty_result.

PARAMETERS: p_year TYPE string DEFAULT '2024'.

START-OF-SELECTION.

*--- Sample Allocation Data (Mock Govt Data)
  it_alloc = VALUE #(
    ( dept_id = 'HEALTH' sector = 'Medical' fiscal_year = p_year alloc_amt = '1000000' )
    ( dept_id = 'EDU'    sector = 'Education' fiscal_year = p_year alloc_amt = '800000' )
  ).

*--- Sample Utilization Data
  it_util = VALUE #(
    ( dept_id = 'HEALTH' post_date = sy-datum util_amt = '950000' )
    ( dept_id = 'EDU'    post_date = sy-datum util_amt = '900000' )
  ).

*--- Processing Logic
  LOOP AT it_alloc INTO DATA(wa_alloc).
    CLEAR wa_res.
    wa_res-dept_id   = wa_alloc-dept_id.
    wa_res-alloc_amt = wa_alloc-alloc_amt.

    LOOP AT it_util INTO DATA(wa_util)
      WHERE dept_id = wa_alloc-dept_id.
      wa_res-util_amt += wa_util-util_amt.
    ENDLOOP.

    wa_res-util_percent =
      ( wa_res-util_amt / wa_res-alloc_amt ) * 100.

    PERFORM evaluate_risk
      USING wa_res-alloc_amt wa_res-util_amt
      CHANGING wa_res-risk_status.

    APPEND wa_res TO it_res.
  ENDLOOP.

*--- ALV Output
  cl_salv_table=>factory(
    IMPORTING r_salv_table = DATA(lo_alv)
    CHANGING  t_table      = it_res ).

  lo_alv->display( ).
