FORM evaluate_risk
  USING    p_alloc TYPE p
           p_util  TYPE p
  CHANGING p_risk  TYPE string.

  DATA: lv_percent TYPE p DECIMALS 2.

  IF p_alloc = 0.
    p_risk = 'NO DATA'.
    RETURN.
  ENDIF.

  lv_percent = ( p_util / p_alloc ) * 100.

  IF lv_percent > 100.
    p_risk = 'HIGH RISK'.
  ELSEIF lv_percent > 70.
    p_risk = 'MEDIUM RISK'.
  ELSE.
    p_risk = 'LOW RISK'.
  ENDIF.

ENDFORM.
