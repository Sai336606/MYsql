# Exercise
# Database: insurance

create database Insurance_db;
use Insurance_db;
select * from Insurance;

# 1. Count for each categories of ‘region
select region,count(*) as Count from insurance group by region;

# 2. Find 50 records of highest ‘age’ and export data/table to desktop
select * from insurance order by age desc limit 50;

# 3. Add index name ‘quick’ on ‘id’
create index quick on insurance (id);        
show index from insurance;

# 4. Describe the schema of table
describe insurance;

# 5. Create view name as ‘gender’ where users can not see ‘sex’ [Hint: first run appropriate query then create view]
select * from insurance;
create view gender as (select id,age,bmi,children,smoker,region,charges from insurance);
select * from gender;

# 6. Rename the view as ‘type’
rename table gender to type;
select * from type;

# 7. Count how many are ‘northwest’ insurance holders
select * from insurance;
select region,count(*) as count from insurance where region = 'northwest';

# 8. Count how many insurance holders were ‘femail’
select sex,count(*) as count from insurance where sex='female';

# 9. Create Primary key on a suitable column
select id from insurance group by id having count(id)>1;    
alter table insurance modify id int primary key;
describe insurance;

# 10. Create a new column ‘ratio’ which is age multiply by bmi
alter table insurance add column ratio int;
update insurance set ratio=age*bmi;
select * from insurance;

# 11. Arrange the table from high to low according to charges
select * from insurance order by charges desc;

# 12. Find MAX of ‘charges’
select max(charges) as Max_Charges from insurance;

# 13. Find MIN of ‘charges’
select min(charges) as Min_Charges from insurance;

# 14. Find average of ‘charges’ of male and female
select sex,avg(charges) as Average_charges from insurance group by sex;

# 15. write a query to rename column name sex to gender 
alter table insurance change sex Gender varchar(10);
select * from insurance;

# 16. Add new column as HL_Charges where more than average charges should be categorized as HIGH and less than average charges should be categorized as LOW
alter table insurance add column HL_Charges varchar(10);
select * from insurance;
select avg(charges) from insurance;
update insurance set HL_Charges = case when charges<13270 then 'Low' when charges>13270 then 'High' end ;

# 17. Change location/position of ‘smoker’ and bring before ‘children’
alter table insurance modify smoker text after bmi;
select * from insurance;

# 18. Show top 20 records
select * from insurance limit 20;

# 19. Show bottom 20 records
select * from insurance order by id desc limit 20;

# 20. Randomly select 20% of records and export to desktop
select round(0.2*count(*),0) from insurance;
select * from insurance order by rand() limit 268;

# 21. Remove column ‘ratio’
alter table insurance drop column ratio;
select * from insurance;

# 22. Craete one example of Sub Queries involving ‘bmi’ and ‘sex’ and give explanation in the script itself with remarks by using #
# Will get second highet bmi based on SEX =Male
select sex,max(bmi) from insurance group by sex;
select sex,max(bmi) as second_Max_Male_BMI from insurance where bmi <(select max(bmi) from insurance where sex='Male') and sex='male';

# 23. Create a view called Female_HL_Charges that shows only those data where HL_Charges is High, Female, Smoker and with 0 childern
create view Female_HL_Charges as (select * from insurance where HL_Charges='High' and Gender = 'Female' and smoker = 'yes' and children = 0);
select * from Female_HL_Charges;

select distinct children from insurance;

# 24. update children column if there is 0 children then make it as Zero children, if 1 then One_children,if 2 then two_children,if 3 then Three_children,if 4 then Four_children if 5 then five_children else print it as More_than_five_children 
describe insurance;
alter table insurance modify children varchar(20);

update insurance
set children= case when  children=0 then 'Zero Children'
	when children=1 then 'one_children'
    when children=2 then 'two_children'
    when children=3 then 'three_children'
    when children=4 then 'four_children'
    when children=5 then 'five_children'
    when children>5 then 'More_than_five_children'
    end;

select * from insurance;
