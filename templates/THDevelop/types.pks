CREATE OR REPLACE TYPE T_{{toUpperCase table_name}} AS OBJECT
  (
   {{#each columns}}
    {{toUpperCase column_name}} {{toUpperCase data_type}}{{#ifCond data_type '!=' 'TIMESTAMP(6)'}}{{#ifCond data_length '!=' 0}}({{data_length}}){{~/ifCond}}{{~/ifCond}}{{#unless @last}},{{lineBreak}}{{/unless}}
   {{~/each}} {{! columns }}

  );
/