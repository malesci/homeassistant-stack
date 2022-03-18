print('CRON')

cron = obj.get('CRON')
if cron == Nil then 
  obj.set('CRON', '0')
else
  obj.set('CRON', tostring(cron + 1))

  print(cron)
end