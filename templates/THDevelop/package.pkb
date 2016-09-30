create or replace package body pkg_{{toLowerCase table_name}} as

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
   {{#each columns}}
   * @param p_{{toLowerCase column_name}}:
{{~#unless @last}}{{lineBreak}}{{/unless}}
{{~/each}} {{! columns }}
   */
  procedure save_record(
    {{#each columns}}
    pi_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{#ifCond nullable '==' 'Y'}} default null {{~/ifCond}}{{#unless @last}},{{lineBreak}}{{/unless}}
    {{~/each}} {{! columns }}
  )
  as
    l_scope logger_logs.scope%type := gc_scope_prefix || 'save_record';
    l_params logger.tab_param;

  begin
    {{#each columns}}
    logger.append_param(l_params, 'pi_{{toLowerCase column_name}}', pi_{{toLowerCase column_name}});
    {{/each}}
    logger.log('START', l_scope, null, l_params);

    insert into {{table_name}}
      (
        {{#each columns}}
        {{toLowerCase column_name}} {{#unless @last}},{{lineBreak}}{{/unless}}
        {{~/each}} {{! columns }}
      )
      values
      (
        {{#each columns}}
        pi_{{toLowerCase column_name}} {{#unless @last}},{{lineBreak}}{{/unless}}
        {{~/each}} {{! columns }}
      );


    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end save_record;

  procedure update_record(
    {{#each columns}}
    pi_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{#ifCond nullable '==' 'Y'}} default null {{~/ifCond}}{{#unless @last}},{{lineBreak}}{{/unless}}
    {{~/each}} {{! columns }}
  )
  as
    l_scope logger_logs.scope%type := gc_scope_prefix || 'update_record';
    l_params logger.tab_param;

  begin
    {{#each columns}}
    logger.append_param(l_params, 'pi_{{toLowerCase column_name}}', pi_{{toLowerCase column_name}});
    {{/each}}
    logger.log('START', l_scope, null, l_params);

    update {{table_name}}
    set 
    {{#each columns}}{{#ifCond constraint_type '==' null}}{{toLowerCase column_name}} = pi_{{toLowerCase column_name}}{{#unless @last}},{{lineBreak}}{{/unless}}{{~/ifCond}}
    {{~/each}}{{! columns }}
    where{{#each columns}}{{#ifCond constraint_type '==' 'P'}} {{toLowerCase column_name}} = pi_{{toLowerCase column_name}}; {{~/ifCond}} {{~/each}} {{! columns }}     
          
    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end update_record;

  procedure delte_record(
    {{#each columns}}{{#ifCond constraint_type '==' 'P'}} pi_{{toLowerCase column_name}} in {{toLowerCase data_type}}{{~/ifCond}} {{~/each}} {{! columns }}   
  )
  as
    l_scope logger_logs.scope%type := gc_scope_prefix || 'delte_record';
    l_params logger.tab_param;

  begin
    {{#each columns}}{{#ifCond constraint_type '==' 'P'}}
    logger.append_param(l_params, 'pi_{{toLowerCase column_name}}', pi_{{toLowerCase column_name}});
    {{~/ifCond}}{{/each}}
    logger.log('START', l_scope, null, l_params);
    
  delete from {{table_name}}
  where{{#each columns}}{{#ifCond constraint_type '==' 'P'}} {{toLowerCase column_name}} = pi_{{toLowerCase column_name}}; {{~/ifCond}} {{~/each}} {{! columns }}

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end delte_record;
end pkg_{{toLowerCase table_name}};
/
