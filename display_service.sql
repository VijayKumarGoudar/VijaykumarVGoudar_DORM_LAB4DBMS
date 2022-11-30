CREATE DEFINER=`root`@`localhost` PROCEDURE `display_service`()
BEGIN
with temp as (
select sup.sup_id, sup.sup_name, avg(rat_ratstars) as rating 
 from order_tb ord 
inner join supplier_pricing sup_price
	on ord.pricing_id = sup_price.pricing_id
inner join supplier sup
	on sup.sup_id = sup_price.supp_id
inner join rating 
	on rating.ord_id = ord.ord_id
group by 1
order by sup.sup_id )
select temp.sup_id, temp.sup_name, temp.rating, 
case when rating = 5 then 'Excellent Service'
	 when rating > 4 then  'Good Service'
     when rating > 2 then 'Average Service'
     else 'Poor Service'
end as Type_of_Service  from temp;
END