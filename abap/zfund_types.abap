TYPES: BEGIN OF ty_allocation,
         dept_id     TYPE string,
         sector      TYPE string,
         fiscal_year TYPE string,
         alloc_amt   TYPE p DECIMALS 2,
       END OF ty_allocation.

TYPES: BEGIN OF ty_utilization,
         dept_id   TYPE string,
         post_date TYPE d,
         util_amt  TYPE p DECIMALS 2,
       END OF ty_utilization.

TYPES: BEGIN OF ty_result,
         dept_id        TYPE string,
         alloc_amt      TYPE p DECIMALS 2,
         util_amt       TYPE p DECIMALS 2,
         util_percent   TYPE p DECIMALS 2,
         risk_status    TYPE string,
       END OF ty_result.
