create or replace package body demo_order_items as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  /**
   * Description
   *
   *
   * @example

   * @issue
   *
   * @author OOS TAPI
   * @created TODO DD-MON-YYYY
   * @param p_order_item_id:
   * @param p_order_id:
   * @param p_product_id:
   * @param p_unit_price:
   * @param p_quantity:
 
   */
  procedure ins_rec(
    -- TODO mdsouza: Need to figure out how to only include commas on non-last column
    p_order_item_id in number,
        -- TODO mdsouza: Need to figure out how to only include commas on non-last column
    p_order_id in number,
        -- TODO mdsouza: Need to figure out how to only include commas on non-last column
    p_product_id in number,
        -- TODO mdsouza: Need to figure out how to only include commas on non-last column
    p_unit_price in number,
        -- TODO mdsouza: Need to figure out how to only include commas on non-last column
    p_quantity in number,
     
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

end demo_order_items;
/
