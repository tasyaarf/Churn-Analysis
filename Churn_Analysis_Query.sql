create table customer_churn_data (
Customer_ID varchar,
	Gender varchar,
	Age int,
	Married varchar,
	State varchar,
	Number_of_Referrals int,
	Tenure_in_Months numeric,
	Value_Deal varchar,
	Phone_Service varchar,
	Multiple_Lines varchar,
	Internet_Service varchar,
	Internet_Type varchar,
	Online_Security varchar,
	Online_Backup varchar,
	Device_Protection_Plan varchar,
	Premium_Support varchar,
	Streaming_TV varchar,
	Streaming_Movies varchar,
	Streaming_Music varchar,
	Unlimited_Data varchar,
	Contract varchar,
	Paperless_Billing varchar,
	Payment_Method varchar,
	Monthly_Charge numeric,
	Total_Charges numeric,
	Total_Refunds numeric,
	Total_Extra_Data_Charges numeric,
	Total_Long_Distance_Charges numeric,
	Total_Revenue numeric,
	Customer_Status varchar, 
	Churn_Category varchar,
	Churn_Reason varchar);
copy customer_churn_data from 'C:\Program Files\PostgreSQL\16\Customer_Data.csv' CSV header ;
select * from customer_churn_data;

--CLEAN & TRANSFORM--

--check the null value--
select sum(case 
	when customer_id is null 
	then 1 
	else 0
   end ) as customer_id_null_count
from customer_churn_data; -- no null value

select distinct gender from customer_churn_data;
select distinct age from customer_churn_data;
select distinct married from customer_churn_data;
select distinct state from customer_churn_data;
select distinct number_of_referrals from customer_churn_data;
select distinct tenure_in_months from customer_churn_data;
select distinct value_deal from customer_churn_data; -- null value detected
update customer_churn_data
set value_deal = 'None'
where value_deal is null;

select distinct phone_service from customer_churn_data;
select distinct multiple_lines from customer_churn_data; -- null value detected
update customer_churn_data
set multiple_lines = 'No'
where multiple_lines is null;

select distinct internet_service from customer_churn_data;
select distinct internet_type from customer_churn_data;
update customer_churn_data
set internet_type = 'None'
where internet_type is null;

select distinct online_security from customer_churn_data; -- null value detected
update customer_churn_data
set online_security = 'No'
where online_security is null;

select distinct online_backup from customer_churn_data;-- null value detected
update customer_churn_data
set online_backup = 'No'
where online_backup is null;

select distinct device_protection_plan from customer_churn_data;-- null value detected
update customer_churn_data
set device_protection_plan = 'No'
where device_protection_plan is null;

select distinct premium_support from customer_churn_data;-- null value detected
update customer_churn_data
set premium_support = 'No'
where premium_support is null;

select distinct streaming_tv from customer_churn_data; -- null value detected
update customer_churn_data
set streaming_tv = 'No'
where streaming_tv is null;

select distinct streaming_movies from customer_churn_data;-- null value detected
update customer_churn_data
set streaming_movies = 'No'
where streaming_movies is null;

select distinct streaming_music from customer_churn_data; -- null value detected
update customer_churn_data
set streaming_music = 'No'
where streaming_music is null;

select distinct unlimited_data from customer_churn_data;-- null value detected
update customer_churn_data
set unlimited_data = 'No'
where unlimited_data is null;

select distinct contract from customer_churn_data;
select distinct paperless_billing from customer_churn_data;
select distinct payment_method from customer_churn_data;
select distinct monthly_charge from customer_churn_data;
select distinct total_charges from customer_churn_data;
select distinct total_refunds from customer_churn_data;
select distinct total_extra_data_charges from customer_churn_data;
select distinct total_long_distance_charges from customer_churn_data;
select distinct total_revenue from customer_churn_data;
select distinct customer_status from customer_churn_data;
select distinct churn_category from customer_churn_data;-- null data detected
update customer_churn_data
set churn_category = 'Others'
where churn_category is null;

select distinct churn_reason from customer_churn_data; -- null data detected
update customer_churn_data
set churn_reason = 'Others'
where churn_reason is null;

select * from customer_churn_data;

--remove duplicate--
with ranked_rows as (select *, row_number()over (
	partition by customer_id order by customer_id) as row_num 
	from customer_churn_data)
select * from ranked_rows
	where row_num > 0; -- no duplicate data detected
	
--CALCULATION--
--total customer--
select count (distinct customer_id) as total_customer 
from customer_churn_data;

--the number of new joiners--
select count (distinct customer_id) as total_customer 
from customer_churn_data
where customer_status = 'Joined';

--the number of total churn--
select count (distinct customer_id) as total_customer 
from customer_churn_data
where customer_status = 'Churned';

-- churn rate--
with churn_analysis as
	(select count (distinct customer_id) as total_customer, 
	 count(distinct case when customer_status = 'Churned' then customer_id end) as churned_customer 
	from customer_churn_data)
select 
	total_customer, churned_customer, 
	case 
		when total_customer > 0 then (churned_customer * 100.0 / total_customer)
		else 0
		end as churn_rate
	from churn_analysis;

-- total churn by gender ---
select gender, 
	 count(distinct case when customer_status = 'Churned' then customer_id end) as churned_customer 
	from customer_churn_data group by gender;

-- total customer and churn rate by age group --
with customer_data as (
	select
		case
			when age <= 19 then '<20'
			when age between 20 and 34 then '20-35'
			when age between 35 and 49 then '35-50'
			when age >=50 then '50++'
		end as age_group,
		case 
			when customer_status = 'Churned' then customer_id
			else null
		end as churned_customer_id,
		case
			when customer_status is not null then customer_id
			else null
		end as total_customer_id
from customer_churn_data)
select age_group, 
		count(distinct churned_customer_id) as churned_num,
		count(distinct total_customer_id) as total_num, 
	case
		when count(distinct total_customer_id) >0 then 
		(count(distinct churned_customer_id)*100.0/count(distinct total_customer_id) )
		else 0
		end as churn_rate
	from customer_data
	group by age_group
	order by age_group;

-- churn rate by payment_method --
with customer_data as (
	select
		case 
			when payment_method is not null then payment_method
			else null
			end as payment_type,
		case 
			when customer_status = 'Churned' then customer_id
			else null
			end as churned_customer_id,
		case 
			when customer_status is not null then customer_id
			else null
			end as total_customer_id
from customer_churn_data)
select 
	distinct payment_type,
	count (distinct churned_customer_id) as churned_num,
	count (distinct total_customer_id) as total_num,
	case 
		when count (distinct total_customer_id) > 0 then 
		(count (distinct churned_customer_id)*100.0/count (distinct total_customer_id))
		else 0
		end as churn_rate
from customer_data
group by payment_type
order by payment_type;
		
-- churn rate by contract --

with customer_data as (
	select
		case 
			when contract is not null then contract
			else null
			end as contract_type,
		case 
			when customer_status = 'Churned' then customer_id
			else null
			end as churned_customer_id,
		case 
			when customer_status is not null then customer_id
			else null
			end as total_customer_id
from customer_churn_data)
select 
	distinct contract_type,
	count (distinct churned_customer_id) as churned_num,
	count (distinct total_customer_id) as total_num,
	case 
		when count (distinct total_customer_id) > 0 then 
		(count (distinct churned_customer_id)*100.0/count (distinct total_customer_id))
		else 0
		end as churn_rate
from customer_data
group by contract_type
order by contract_type;
		
-- total customer and churn rate by tenure group --
			
with customer_data as (
	select
		case
			when tenure_in_months <= 5 then '<6'
			when tenure_in_months between 6 and 11 then '6-12'
			when tenure_in_months between 12 and 17 then '12-18'
			when tenure_in_months between 18 and 23 then '18-24'
			when tenure_in_months >= 24 then '24++'
		end as tenure_group,
		case 
			when customer_status = 'Churned' then customer_id
			else null
		end as churned_customer_id,
		case
			when customer_status is not null then customer_id
			else null
		end as total_customer_id
from customer_churn_data)
select tenure_group, 
		count(distinct churned_customer_id) as churned_num,
		count(distinct total_customer_id) as total_num, 
	case
		when count(distinct total_customer_id) >0 then 
		(count(distinct churned_customer_id)*100.0/count(distinct total_customer_id) )
		else 0
		end as churn_rate
	from customer_data
	group by tenure_group
	order by tenure_group;

-- churn rate by state (Top 5) --
with customer_data as (
	select
		case 
			when state is not null then state
			else null
			end as state_name,
		case 
			when customer_status = 'Churned' then customer_id
			else null
			end as churned_customer_id,
		case 
			when customer_status is not null then customer_id
			else null
			end as total_customer_id
from customer_churn_data)
select 
	distinct state_name,
	count (distinct churned_customer_id) as churned_num,
	count (distinct total_customer_id) as total_num,
	case 
		when count (distinct total_customer_id) > 0 then 
		(count (distinct churned_customer_id)*100.0/count (distinct total_customer_id))
		else 0
		end as churn_rate
from customer_data
group by state_name
order by churn_rate
desc
limit 5;

-- churn rate by internet_type --
with customer_data as (
	select
		case 
			when internet_type is not null then internet_type
			else null
			end as internet_type_name,
		case 
			when customer_status = 'Churned' then customer_id
			else null
			end as churned_customer_id,
		case 
			when customer_status is not null then customer_id
			else null
			end as total_customer_id
from customer_churn_data)
select 
	distinct internet_type_name,
	count (distinct churned_customer_id) as churned_num,
	count (distinct total_customer_id) as total_num,
	case 
		when count (distinct total_customer_id) > 0 then 
		(count (distinct churned_customer_id)*100.0/count (distinct total_customer_id))
		else 0
		end as churn_rate
from customer_data
group by internet_type_name
order by internet_type_name;

-- total churn by churn category --
select churn_category, 
	 count(distinct case when customer_status = 'Churned' then customer_id end) as churned_customer 
	from customer_churn_data group by churn_category;

-- churn by  phone services --
with churn_analysis as (
    select 
        case when customer_status = 'Churned' 
             then customer_id 
             else null 
        end as churned_customer 
    from customer_churn_data
),
phone_service_analysis as (
    select
        case 
            when phone_service = 'Yes' then 'Yes'
            else 'No'
        end as phone_service_subscription,
        case 
            when customer_status = 'Churned' then customer_id
            else null
        end as churned_customer_id
    from customer_churn_data
),
total_churned as (
    select 
        count(distinct churned_customer) as total_churned_customer
    from churn_analysis
)

select 
    psa.phone_service_subscription,
    count(distinct psa.churned_customer_id) as churned_num,
    tc.total_churned_customer,
    case 
        when tc.total_churned_customer > 0 then 
            (count(distinct psa.churned_customer_id) * 100.0 / tc.total_churned_customer)
        else 0
    end as churn_rate
from phone_service_analysis psa
left join churn_analysis ca
    on psa.churned_customer_id = ca.churned_customer
cross join total_churned tc
group by psa.phone_service_subscription, tc.total_churned_customer
order by churn_rate;

-- revenue from all customer-- 
select sum(total_revenue) from customer_churn_data;

-- revenue after customer churned --
SELECT SUM(total_revenue) AS revenue
FROM customer_churn_data
WHERE customer_status IN ('Joined', 'Stayed');

	
from customer_churn_data;

select * from customer_churn_data;
