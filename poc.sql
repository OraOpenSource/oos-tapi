set sqlformat json
set feedback off
set serveroutput on

exec dbms_output.put_line('%%%START%%%');

select
  ut.table_name,
  cursor(
    select
      utc.column_name,
      utc.data_type,
      utc.nullable
      -- TODO mdsouza: utc.hidden_column and utc.virtual_column
    --  ,utc.*
    from
      user_tab_cols utc,
      (
        select
          uc.table_name,
          ucc.column_name,
          ucc.position
        from
          user_constraints uc,
          user_cons_columns ucc
        where 1=1
          and uc.constraint_type = 'P'
          and uc.constraint_name = ucc.constraint_name
      ) uc
    where 1=1
      and utc.table_name = ut.table_name
      --
      and utc.table_name = uc.table_name(+)
      and utc.column_name = uc.column_name(+)
    order by uc.position nulls last, utc.column_id
  ) columns
from
  user_tables ut
where 1=1
  and ut.table_name in ('DEMO_ORDER_ITEMS', 'EMP')
;

exec dbms_output.put_line('%%%END%%%');
