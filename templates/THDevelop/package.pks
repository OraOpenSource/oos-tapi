create or replace package body {{toLowerCase table_name}} as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure save_record(
    {{#each columns}}
    pi_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{#unless @last}},{{lineBreak}}{{/unless}}
    {{~/each}} {{! columns }}
  );

  procedure update_record(
    {{#each columns}}
    pi_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{#unless @last}},{{lineBreak}}{{/unless}}
    {{~/each}} {{! columns }}
  );

  procedure delte_record(
     {{#each columns}}{{#ifCond constraint_type '==' 'P'}} pi_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{~/ifCond}} {{~/each}} {{! columns }}
  );

end {{toLowerCase table_name}};
/
