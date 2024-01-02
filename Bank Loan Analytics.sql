create database internship;
use internship;
select*from finance_2_excel;
select*from finance_1;
-------------------------------------------------------------------
#SUM OF FUNDED AMOUNT
select concat(round(sum(funded_amnt)/1000000,2),"M") as Total_Funded_Amount from finance_1;

-------------------------------------------------------------------
#AVERAGE OF LOAN AMOUNT
select avg(loan_amnt) as Average_Loan_Amount from finance_1;

-------------------------------------------------------------------
#AVERAGE OF INTEREST RATE
select concat(round(avg(int_rate),2),"%") as Average_Interest_Rate from finance_1;

-------------------------------------------------------------------------
#Year wise loan amount Stats
set sql_safe_updates=0;
UPDATE finance_1 SET issue_d= STR_TO_DATE(issue_d, '%d-%m-%Y');

select year(issue_d) as year from finance_1;
select year(issue_d) as Year,concat(round(sum(loan_amnt)/1000000,2),"M") as Loan_Amount from finance_1
group by year(issue_d)
order by year;

-------------------------------------------------------------------------
#Grade and sub grade wise revol_bal

select grade,sub_grade ,concat(round(sum(revol_bal)/1000000,2),"M")  as Revolving_Balance from finance_1 join finance_2_excel
using(id)
group by grade,sub_grade
order by grade,sub_grade;

-------------------------------------------------------------------------
#Total Payment for Verified Status Vs Total Payment for Non Verified Status
select verification_status ,concat(round(sum(total_pymnt)/1000000,2),"M") as Total_Paymnet
from finance_1 join finance_2_excel using(id)

group by verification_status
having verification_status="verified" or verification_status="not verified" ;

-------------------------------------------------------------------------
#State wise and month wise loan status
select addr_state,month(issue_d) ,loan_status,count(loan_status) as Loan_Stats
from finance_1
group by addr_state,month(issue_d),loan_status
order by loan_stats desc 
limit 10;


--------------------------------------------------------------------------
#Home ownership Vs last payment date stats
select home_ownership,max(last_pymnt_d) from finance_1 
join finance_2_excel
using(id)
group by home_ownership







