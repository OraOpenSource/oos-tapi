create or replace package body {{toLowerCase table_name}} as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  /**
   * Description
   *
   *
   * @example
   *
   * @issue
   *
   * @author {{author}}
   * @created {{date}}
   *
{{javaDocParams columns 3}}
   */
  procedure ins_rec(
    {{#each columns}}
    p_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{#unless @last}},{{lineBreak}}{{/unless}}
    {{~/each}} {{! columns }}
  )
  as
    l_scope logger_logs.scope%type := gc_scope_prefix || 'ins_rec';
    l_params logger.tab_param;

  begin
    {{#each columns}}
    logger.append_param(l_params, 'p_{{toLowerCase column_name}}', p_{{toLowerCase column_name}});
    {{/each}}
    logger.log('START', l_scope, null, l_params);

    insert into {{table_name}} ...

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end ins_rec;

end {{toLowerCase table_name}};
/
