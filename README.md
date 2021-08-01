# Pewlett Hackard Analysis

## Overview 

Pewlett Hackard is a large company that has been around for many years and has many employees. Being a large and prestigious organization to work for, Pewlett Hackard boasts of very low employee attrition rates so many of its employees have been working in the company for several decades. As the old order of employees is now reaching retirement Pewlett Hackard is facing the following challenges. 

    * Large numbers of employees retiring means many vacant positions that need filling 
    * Retiring employees need to be given retirement packages to facilitate the retiring process 
    * Pewlett Hackard wants to introduce a mentorship program to identify mentors who can mentor the new entrants into the companies working ethic and culture. 
    * They need to know if they have enough mentors. 

These are some of the questions that they must find answers to. Pewlett Hackard currently has all their data in various stand-alone databases and has historically used excel.  We have been invited to step in and help them integrate the databases and provide answers to their burning questions in a swift and accurate manner. We believe SQL will do the job.

The questions we are looking to answer are as below

    * How many employees are retiring? 
    * What are their titles? 
    * Which departments do they belong to? 
    * Who is eligible to participate in the mentorship program 
    * Do we have enough mentors in the respective roles  to train and mentor our new entrants

## Resources

### Tools

    * PostgreSQL and pgAdmin 
        * Postgres will be used to create a database, and pgAdmin to work with the data we import
    * Quick DBD 
        * Quick DBD – to help us create clean and comprehensible ERDs

 ### Resources

We have been given 6 data sets in CSV format as below

    * departments.csv 
    * dept_emp.csv 
    * dept_manager.csv 
    * employees.csv 
    * salaries.csv 
    * titles.csv

## Deliverable 1: The Number of Retiring Employees by Title

### Task 1

Our first task was the check how many employees are on the brink of retirement. To perform this task we retrieved the emp_no, first_name and last_name from Employees table and title, from_date and to_date from the Titles table. We joined the two tables using the common column (emp_no) which we called the primary key. We filtered the data to include only people born between 1952 and 1955 and ordered the table by ascending employee numbers. We created and saved the new table as retirement_titles.csv 


### Task 2 
By looking at the data we realized that there were duplicate entries per employees based on the past titles held by them and hence we needed to filter the data to only include the latest title of the employees. We used the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON() clause. The results of this analysis were stored in a new table called Unique Titles table using the INTO clause. The unique_titles table was sorted in the ascending order of employee number and descending order by last_date(most recent title)


### Task 3
Here we wanted to get the count of each retiring titles. We retrieved the number of employees by their most recent job title who are about to retire. Retrived the number of titles from the Unique Titles table. Created a new table called retiring_titles  to help the data.
###  Refactoring  Queries From Deliverable 1 
We realized looking at the to_date in the retirement_titles table that some of the people we are counting as eligible to retire have already left the company. They need to be removed from the database. We need to only include current employees in our analysis. So we refactored our queries to accommodate this and our new refactored queries were as below
refactored_retirement_titles
refactored_unique_titles
refactored_retiring_titles

### Learnings  from Deliverable 1
-	There are a total of 72458 employees on the brink of retirement
-	 
 
## Deliverable 2: The Employees Eligible for the Mentorship Program
Here the task is to write out a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program. These mentors will be assigned new entrants and will be tasked to mentor them. For the purpose of the mentorship program we selected employees born in the year 1965.  Here the query uses three tables. The Employees table for emp_no, first_name, last_name and birth_date, the Department Employees table for the from_date and to_date and the Titles table for the title. We use the DISTINCT ON statement to retrieve the latest titles and then join the Employees and Department Employees table using emp_no primary key and we join the Employee and Title table using the emp_no primary key. Next we filter the data based on birth dates to include employees born in the year 1965 . We create a new table called mentorship_eligibility and save it.

## Deliverable 3: Additional Analysis to Find Out If We Have Enough Mentors
Created a query to find out number of eligible mentors by department  by using the count function on our newly created mentorship_eligibility table , grouping the data by title and ordering the dat by descending order of counts. The data was saved into a new table called mentorship_eligibity_counts

## Deliverable 4: Additional Analysis To Check the Most Affected Departments
To find out which departments would be most affected by this silver tsunami. This query used three tables  .  Our Refactored Retirement Titles table  renamed, The Department Employee table and the Departments table.  The Refactored Retirement Titles table and Department Employee table were joine using the emp_no primary key and the Departments and Department Employee tables were joined using the dept_no primary key.  We selected the count function and grouped the data by dept_no and dept_name   and the ordered the data  by count in descending order . 

