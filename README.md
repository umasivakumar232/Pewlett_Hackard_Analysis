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

<img width="641" alt="Retirement_titles" src="https://user-images.githubusercontent.com/85518330/127787025-4ca19983-2481-41c1-a83c-33ed5a927c10.png">


### Task 2 
By looking at the data we realized that there were duplicate entries per employee based on the past titles held by them. We needed to filter the data to include only the latest title of the employees. To do this we used the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON() clause. The results of this analysis was stored in a new table called Unique Titles using the INTO clause. The unique_titles table was sorted in the ascending order of employee number and descending order by last_date(most recent title)

<img width="280" alt="Unique_titles" src="https://user-images.githubusercontent.com/85518330/127787032-83a9499e-a1be-4ee6-a0a2-3e1c14e1b68b.png">


### Task 3
Here we wanted to get the count of each retiring title. We retrieved the number of employees who are about to retire by their most recent job title. Retrived the number of titles from the Unique Titles table. Created a new table called retiring_titles and saved it as retiring_titles.csv.

<img width="149" alt="retiring_titles" src="https://user-images.githubusercontent.com/85518330/127787039-4179b974-9905-4c03-8223-21b2e4eb2852.png">


###  Refactoring  Queries From Deliverable 1 
We realised after a relook at the retirement_titles table that some of the people we are counting as eligible to retire have already left the company. These records need to be removed from the database. We need to only include current employees in our analysis. So we refactored our queries to accommodate this and our new refactored queries were saved as tables of the same name and saved as csv files 

refactored_retirement_titles

<img width="411" alt="refactored_retirement_titles" src="https://user-images.githubusercontent.com/85518330/127787334-ee8ac78a-d2db-4e1e-8b1c-3e1f68d90749.png">


refactored_retiring_titles

<img width="141" alt="Refactored_retiring_titles" src="https://user-images.githubusercontent.com/85518330/127787344-e8c4cb08-0965-44c5-84e6-ef1f1a6995b0.png">


## Deliverable 2: The Employees Eligible for the Mentorship Program

Here the task is to write out a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program. These mentors will be assigned new entrants and will be tasked to mentor them. For the purpose of the mentorship program we selected employees born in the year 1965. The query uses data from three input tables. The Employees table for emp_no, first_name, last_name and birth_date, the Dept_Emp table for the from_date and to_date and the Titles table for the title. We use the DISTINCT ON statement to retrieve the latest titles and then join the Employees and Dept_Emp tables using emp_no primary key and we join the Employee and Title table using the emp_no primary key. Next we filter the data based on birth dates to include employees born in the year 1965 . We create a new table called mentorship_eligibility and save it.

<img width="458" alt="Mentorship_eligibility" src="https://user-images.githubusercontent.com/85518330/127787653-9850bbc5-e87d-4bf1-87ee-2bf434aa366f.png">


## Deliverable 3: Additional Analysis to Find Out If We Have Enough Mentors

Created a query to find out number of eligible mentors by department  by using the count function on our newly created mentorship_eligibility table , grouping the data by title and ordering the data by descending order of counts. The data was saved into a new table called mentorship_eligibity_counts

<img width="164" alt="Mentorship_eligibility_counts" src="https://user-images.githubusercontent.com/85518330/127787664-7ee6e10e-49e0-4fbb-9a38-7549ebb289a7.png">

## Deliverable 4: Additional Analysis To Check the Most Affected Departments
To find out which departments would be most affected by the silver tsunami. This query used three tables.  Our refactored_retirement_titles table, The dept_emp table and the departments table.  The refactored_retirement_titles table and dept_emp table were joined using the emp_no primary key and the departments and dept_emp tables were joined using the dept_no primary key.  We selected the count function and grouped the data by dept_no and dept_name   and the ordered the data  by count in descending order . 

<img width="250" alt="Departmentwise_Retirees" src="https://user-images.githubusercontent.com/85518330/127787701-b8418cf6-6ba5-499b-8d74-588220604353.png">

## Key Takeouts 

* Our refactored query indicates that there are a total of 72458 employees on the brink of retirement 
* The titles with the highest retirees are Senior Engineers (25916),  Senior Staff (24926) and Engineers (9285) 
* We have found 1549 employees who are eligible for the mentorship program based on our criteria 
* When we compare the available mentors with the number of new possible hires they will need to mentor, we find that there are very few mentors for some titles like senior    engineers, senior staff, staff and technical leaders. The below image gives the details. Our recommendation is to try and find more mentors such that the ratios of mentor:mentee is more managable 

<img width="284" alt="Mentor_Mentee Ratios" src="https://user-images.githubusercontent.com/85518330/127788198-39c21535-93d7-42d1-bcc3-77fa0aa0227b.png">

* The departments most impacted by this silver tsunami are the Development, Production and Saled departments 
* The Pewlett Hackard HR team has quite a task cut out for them to find these replacements  
