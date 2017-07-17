$ ->
  table_list_div = $('.table-list')
  if table_list_div.length > 0
    tr = table_list_div.find('tbody tr').last()
    amount_tr = tr.clone()
    amount_tds = amount_tr.find('td')
    amount_tds.empty().css({'font-weight':'bold'}).not(':last-child').css({'border':'none'})
    amount = table_list_div.data('amount')
    amount_tds.last().text(amount + " р.")
    tr.after(amount_tr)