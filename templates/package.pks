create or replace package body {{toLowerCase table_name}} as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure ins_rec(
    {{#each columns}}
    p_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{#unless @last}},{{lineBreak}}{{/unless}}
    {{~/each}} {{! columns }}
  );

end {{toLowerCase table_name}};
/
