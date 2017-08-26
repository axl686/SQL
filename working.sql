select 
test.orders.email as 'почта'
,front2.b_user.NAME as 'имя'
,test.orders.personal_gender as 'пол'
,test.AGE.BIRTHDATE as 'день рождения'

,case when exists (
	select test.fordes_final.user_id 
	from test.fordes_final
	where test.orders.user_id = test.fordes_final.user_id 
	and test.fordes_final.category = 'Украшения')
	then 'yes' else 'no' 
end 'Украшения'
    
,case when exists (
	select test.fordes_final.user_id 
	from test.fordes_final
	where test.orders.user_id = test.fordes_final.user_id 
	and test.fordes_final.category = 'Дом')
	then 'yes' else 'no' 
end 'Дом'
 
,case when exists (
	select test.fordes_final.user_id 
	from test.fordes_final
	where test.orders.user_id = test.fordes_final.user_id 
	and test.fordes_final.category = 'Кухня')
	then 'yes' else 'no' 
end 'Кухня'

from test.orders

	left join test.AGE on test.orders.user_id = test.AGE.user_id

	left join test.fordes_final	on test.AGE.user_id = test.fordes_final.user_id

	left join test.blacklist on test.fordes_final.user_id = test.blacklist.USER_ID
    
    left join front2.b_user on test.blacklist.USER_ID = front2.b_user.ID
where test.orders.email 
	regexp '[a-zA-Z0-9_\-]+@[a-zA-Z0-9_\-]+\.+[com|ru]'

and test.orders.user_id not in (
		select test.orders.user_id
		from test.orders
		where test.orders.user_id = test.blacklist.USER_ID)
;