create or replace package body {{toLowerCase table_name}} as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  /**
   * Description
   *
   *
   * @example

   * @issue
   *
   * @author {{author}}
   * @created {{date}}
   {{#each columns}}
   * @param p_{{toLowerCase column_name}}:
{{/each}} {{! columns }}
   */
  procedure ins_rec(
    {{#each columns}}
    -- TODO mdsouza: Need to figure out how to only include commas on non-last column
    p_{{toLowerCase column_name}} in {{toLowerCase data_type}},
    {{/each}} {{! columns }}
  )
  as
    l_scope logger_logs.scope%type := gc_scope_prefix || 'ins_rec';
    l_params logger.tab_param;

  begin
    logger.append_param(l_params, 'p_param1_todo', p_param1_todo);
    logger.log('START', l_scope, null, l_params);


    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end ins_rec;

end {{toLowerCase table_name}};
/
