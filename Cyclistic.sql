--We create a table to include all data from 12 months
create table #full_data (rideable_type nvarchar(50), started_at datetime2(7)  , ended_at datetime2(7), start_location nvarchar(50) ,
end_location nvarchar(50), member_casual nvarchar(50), Month_Name nvarchar(50), Day_Name nvarchar(50), Day_of_Year smallint, Total_seconds int)



--data is inserted


insert into #full_data
select *
from january
union
select *
from february
union
select *
from march
union
select *
from april
union
select *
from may
union
select *
from june
union
select *
from july
union
select *
from august
union
select *
from september
union
select *
from october
union
select *
from november
union
select *
from december

--Analysis starts

--we need to see which has more accumulated time, classic bike or electric bike, members or casual riders

select rideable_type, sum(cast(total_seconds as bigint)) as accumulated_time
from #full_data
group by rideable_type
order by accumulated_time desc

select member_casual, sum(cast(total_seconds as bigint)) as accumulated_time
from #full_data
group by member_casual
order by accumulated_time desc

--which one used the most classic bike or electric bike, members or casual riders

select rideable_type, count(total_seconds) as #of_times_used
from #full_data
group by rideable_type

select member_casual, count(total_seconds) as #of_times_used
from #full_data
group by member_casual


--we need to know which station is more common

select count(distinct (start_location))
from #full_data

select count(distinct (end_location))
from #full_data

--Lets see which day/month the service is used the most

select Day_Name, count(day_name) as #of_times_used
from #full_data
group by Day_Name


select Month_Name, count(month_name) as #of_times_used
from #full_data
group by Month_Name
order by #of_times_used desc


--which months are the busiest 

select Month_Name, sum(cast(total_seconds as bigint)) as accumulated_time
from #full_data
group by Month_Name
order by accumulated_time desc


--which day of the week/ of the year is the busiest and best to advertise

select top (10)  count(rideable_type) freq , Day_of_Year , Day_Name , Month_Name
from #full_data
group by  Day_of_Year, Day_Name , Month_Name
order by count(rideable_type) desc

--most used locations

select top (10) count(rideable_type) freq, start_location 
from #full_data
group by start_location
order by freq desc

select top (10) count(rideable_type) freq, end_location 
from #full_data
group by end_location
order by freq desc



