/*
Exercise 
Database: cereals 
Queries 
1. Add index name fast on name 
2. Describe the schema of table 
3. Create view name as see where users can not see type column [first run appropriate query 
then create view] 
4. Rename the view as saw 
5. Count how many are cold cereals 
6. Count how many cereals are kept in shelf 3 
7. Arrange the table from high to low according to ratings 
8. Suggest some column/s which can be Primary key 
9. Find average of calories of hot cereal and cold cereal in one query 
10. Add new column as HL_Calories where more than average calories should be categorized as 
HIGH and less than average calories should be categorized as LOW 
11. List only those cereals whose name begins with B 
12. List only those cereals whose name begins with F 
13. List only those cereals whose name ends with s 
14. Select only those records which are HIGH in column HL_calories and mail to 
jeevan.raj@imarticus.com [save/name your file as <your first name_cereals_high>] 
15. Find maximum of ratings
16. Find average ratings of those were High and Low calories 
17. Craete two examples of Sub Queries of your choice and give explanation in the script 
itself with remarks by using # 
18. Remove column fat 
19. Count records for each manufacturer [mfr] 
20. Select name, calories and ratings only
*/

DROP database if exists cereals_db;
create database cereals_db;
use cereals_db;
select * from cereals_data;

# 1. Add index name fast on name 
create index idx_fast on cereals_data (name);
select max(length(name)) from cereals_data;
alter table cereals_data modify name varchar(40);
create index idx_fast on cereals_data (name);

select name from cereals_data;
show tables;
show index from cereals_data;

# 2. Describe the schema of table
describe cereals_data;

# 3. Create view name as see where users can not see type column 
# [first run appropriate query then create view] 
select * from cereals_data;
create view see as(select name,mfr,calories,protein,fat,sodium,fiber,carbo,sugars,potass,vitamins,shelf,weight,cups,rating from cereals_data);
select * from see;

# 4. Rename the view as saw
rename table see to saw;
select * from saw;

# 5. Count how many are cold cereals 
select * from cereals_data;
select type,count(*) as No_of_cold_cereals from cereals_data where type='c';

# 6. Count how many cereals are kept in shelf 3
select shelf,count(*) as No_of_cereals_kept_in_shelf_3 from cereals_data where shelf=3;

# 7. Arrange the table from high to low according to ratings
select * from cereals_data order by rating desc;

# 8. Suggest some column/s which can be Primary key
select distinct count(name) from cereals_data;   # you use name as a primary key because it is unique and not null
select name from cereals_data where name is null;

# 9. Find average of calories of hot cereal and cold cereal in one query 
select * from cereals_data;
select type,round(avg(calories),0) as Average_calories from cereals_data group by type;

# 10. Add new column as HL_Calories where more than average calories should be 
# categorized as HIGH and less than average calories should be categorized as LOW 
select * from cereals_data;
select round(avg(calories),0) from cereals_data;
alter table cereals_data add column HL_Calories varchar(20);
update cereals_data set HL_Calories =case when  calories>107 then 'High' else 'Low' end;

# 11. List only those cereals whose name begins with B 
select name from cereals_data where name like 'B%';

# 12. List only those cereals whose name begins with F 
select * from cereals_data where name like 'F%';

# 13. List only those cereals whose name ends with s
select * from cereals_data where name like '%s';

# 14. Select only those records which are HIGH in column HL_calories and mail to 
#jeevan.raj@imarticus.com [save/name your file as <your first name_cereals_high>] 
select * from cereals_data where HL_Calories ='High';

# 15. Find maximum of ratings
select max(rating) as max_of_rating from cereals_data;

# 16. Find average ratings of those were High and Low calories 
select * from cereals_data;
select HL_Calories,round(avg(rating),0) from cereals_data group by HL_calories;

# 17. Craete two examples of Sub Queries of your choice and give explanation in the script 
# itself with remarks by using #
select * from cereals_data
where sodium = (select MAX(sodium) from cereals_data);

#The outer query selects all the column details from the cereals_data table.
#The subquery (SELECT MAX(sodium) from cereals_data) calculates the maximum value of sodium from the cereals_data table.
#The outer query's WHERE clause compares the sodium of each product with the maximum sodium obtained from the subquery.
# If any of the sodium value matches the maximum value, their information is returned in the result.

select * from cereals_data
where rating = (select MAX(rating) from cereals_data);

#The outer query selects all the column details from the cereals_data table.
#The subquery (SELECT MAX(rating) from cereals_data) calculates the maximum rating from the cereals_data table.
#The outer query's WHERE clause compares the rating of each product with the maximum rating obtained from the subquery.
# If any of the rating value matches the maximum value, their information is returned in the result.


# 18. Remove column fat
select * from cereals_data;
alter table cereals_data drop fat;
select * from cereals_data;

# 19. Count records for each manufacturer [mfr]
select mfr,count(*) as No_of_counts_Based_on_mfr from cereals_data group by mfr;

# 20. Select name, calories and ratings only
select name,calories,rating from cereals_data;