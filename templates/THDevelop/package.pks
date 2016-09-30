create or replace package pkg_{{toLowerCase table_name}} as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure save_record(
    {{#each columns}}
    pi_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{#ifCond nullable '==' 'Y'}} default null {{~/ifCond}}{{#unless @last}},{{lineBreak}}{{/unless}}
    {{~/each}} {{! columns }}
  );

  procedure update_record(
    {{#each columns}}
    pi_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{#ifCond nullable '==' 'Y'}} default null {{~/ifCond}}{{#unless @last}},{{lineBreak}}{{/unless}}
    {{~/each}} {{! columns }}
  );

  procedure delte_record(
     {{#each columns}}{{#ifCond constraint_type '==' 'P'}} pi_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{~/ifCond}} {{~/each}} {{! columns }}
  );

end pkg_{{toLowerCase table_name}};
/