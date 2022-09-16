SELECT * FROM "Shark Tank India (Data)"; 

-- Total Episodes 
select Count(Distinct "Episode Number") from "Shark Tank India (Data)";


-- Number of Pitches
select count("Pitch Number") from "Shark Tank India (Data)";


-- Total Offers Accepted 
select sum("Accepted Offer") from "Shark Tank India (Data)"; 


-- Startups who got fund
select "Startup Name","Total Deal Amount"
from "Shark Tank India (Data)" 
where "Accepted Offer">'0';


-- Total Male Presenters
select sum("Male Presenters") from "Shark Tank India (Data)";


-- Total Female Presenters
select sum("Female Presenters") from "Shark Tank India (Data)";


-- Gender Ratio of Presenters
select sum("Male Presenters")/sum("Female Presenters") from "Shark Tank India (Data)"; 


-- Total invested amount (in lakhs)
select sum("Total Deal Amount") from "Shark Tank India (Data)";


-- Average Equity taken
select avg("Total Deal Equity") from "Shark Tank India (Data)"
where "Total Deal Equity">'0';


-- Highest deal taken (in lakhs)
select max("Total Deal Amount") from "Shark Tank India (Data)";


-- Number of Startups having at least women
select sum(a.female_count) Startups_having_atleast_women from
(select "Female Presenters", case when "Female Presenters">'0' then 1 else 0 end as female_count
from "Shark Tank India (Data)") a ;


-- Pitches accepted having atleast one women
select sum(b.female_count) from
(select case when a."Female Presenters">'0' then 1 else 0 end as female_count, a.* from ( 
(select * from "Shark Tank India (Data)" where "Accepted Offer"= '1')) a) b; 


-- Average amount invested per deal 
select avg("Total Deal Amount") from "Shark Tank India (Data)" 
where "Accepted Offer"='1';


-- which average age group of maximum contestants
select "Pitchers Average Age", count("Pitchers Average Age") No_of_cnt from "Shark Tank India (Data)" 
group by "Pitchers Average Age" 
order by No_of_cnt desc;


-- Location (Pitchers City) group of contestants
select "Pitchers City", count("Pitchers City") No_of_cnt from "Shark Tank India (Data)" 
group by "Pitchers City"
order by No_of_cnt desc;


-- which industry group have maximum or minimum startups
select Industry, count(Industry) No_of_startrup from "Shark Tank India (Data)" 
group by Industry 
order by No_of_startrup;


-- startups got fund from two or more sharks
select "Startup Name", "Number of sharks in deal" from "Shark Tank India (Data)"
where "Number of sharks in deal">='2'
order by 2 desc;


-- Making the matrix table of sharks
select n.keyy, n.total_deal_present, n.total_deal, c.total_amount_invested, c.avg_equity_taken from
(select a.keyy, a.total_deal_present, b.total_deal from 
(select 'Ashneer' as keyy, count("Ashneer Investment Amount") total_deal_present from "Shark Tank India (Data)" 
where "Ashneer Investment Amount">='0') a
inner join
(select 'Ashneer' as keyy, count("Ashneer Investment Amount") total_deal from "Shark Tank India (Data)" 
where "Ashneer Investment Amount">'0') b
on a.keyy=b.keyy) n
inner join
(select 'Ashneer' as keyy, sum("Ashneer Investment Amount") total_amount_invested, 
avg("Ashneer Investment Equity") avg_equity_taken from "Shark Tank India (Data)"
where "Ashneer Investment Amount">'0') c 
on n.keyy=c.keyy

UNION

select n.keyy, n.total_deal_present, n.total_deal, c.total_amount_invested, c.avg_equity_taken from
(select a.keyy, a.total_deal_present, b.total_deal from 
(select 'Aman' as keyy, count("Aman Investment Amount") total_deal_present from "Shark Tank India (Data)" 
where "Aman Investment Amount">='0') a
inner join
(select 'Aman' as keyy, count("Aman Investment Amount") total_deal from "Shark Tank India (Data)" 
where "Aman Investment Amount">'0') b
on a.keyy=b.keyy) n
inner join
(select 'Aman' as keyy, sum("Aman Investment Amount") total_amount_invested, 
avg("Aman Investment Equity") avg_equity_taken from "Shark Tank India (Data)"
where "Aman Investment Amount">'0') c 
on n.keyy=c.keyy


-- which is the startup in which the highest amount has been invested in each domain/industry
select a.* from 
(select "Startup Name", Industry,"Total Deal Amount", rank() over(partition by Industry order by "Total Deal Amount" desc) rnk 
from "Shark Tank India (Data)") a
where a.rnk=1;



