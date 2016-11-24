set sqlformat json
set feedback off
set serveroutput on
set verify off

exec dbms_output.put_line('%%%START%%%');

select
  ut.table_name,
  cursor(
    select
      utc.column_name,
      utc.data_type,
      utc.nullable,
      uc.constraint_type,
      case when utc.data_type = 'VARCHAR2' then to_char(utc.char_length )
           when utc.data_type = 'NUMBER' and (utc.data_precision is not null or utc.data_scale is not null)
              then to_char(case when utc.data_precision is null then 0 else utc.data_precision end) || ',' || to_char(case when utc.data_scale is null then 0 else utc.data_scale end)
           when utc.data_type like 'TIMESTAMP%' then null
           else '0' end  as data_length
      -- TODO mdsouza: utc.hidden_column and utc.virtual_column
    --  ,utc.*
    from
      user_tab_cols utc,
      (
        select
          uc.table_name,
          ucc.column_name,
          ucc.position,
          uc.constraint_type
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
  and ut.table_name in (&1)
;

exec dbms_output.put_line('%%%END%%%');
