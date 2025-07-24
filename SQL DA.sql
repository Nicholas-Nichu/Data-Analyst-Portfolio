-- Database: dvdrental

-- DROP DATABASE IF EXISTS dvdrental;

CREATE DATABASE dvdrental
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
-------------------------------------------------------------------------------------------------------------------

/*
Situation 1:
We want to send out a promotional email to our existing customers!
*/

select first_name,last_name,email from customer

-------------------------------------------------------------------------------------------------------------------

/*
Situation 2:
An Australian visitor isn't familiar with MPAA movie ratings (e.g: PG, PG-13, R etc,.)
We want to know the types of ratings we have in our database.
What ratings do we have available?
*/

select distinct(rating) from film

-------------------------------------------------------------------------------------------------------------------
/*
Situation 3:
A customer forgot their wallet at our store! We need to track down their email to inform them.

What's the email for the customer with the name Nancy Thomas?

*/
select email from customer
where first_name='Nancy' and last_name='Thomas'

-------------------------------------------------------------------------------------------------------------------
/*
Situation 4:
A customer wants to know what the movie "Outlaw Hankey" is about.

Could you give them the description for the movie "Outlaw Hanky"?
*/
select description from film
where title = 'Outlaw Hanky'

-------------------------------------------------------------------------------------------------------------------

/*
Situation 5:
A customer is late on their movie return, and we've them a letter to their address at '259 Ipoh Drive'. We should also call them on the phone to let them know.

Can you get the phone number for the customer who lives at '259 Ipoh Drive'?
*/
select phone from address
where address='259 Ipoh Drive'

-------------------------------------------------------------------------------------------------------------------

/*
Situation 6:
We want to reward our first 10 paying customers

What are the customer ids of the first 10 customers who craeted a payment?
*/
select customer_id from payment
order by payment_date asc
limit 10
-------------------------------------------------------------------------------------------------------------------
/*
Situation 7:
A customer wants to quickly rent a video to watch over their short lunch break

What are the titles of the 5 shortest (in length of runtime) movies?
*/
select title,length from film
order by length asc
limit 5

-------------------------------------------------------------------------------------------------------------------
/*
Situation 8:
If the previous customer can watch any movie that is 50 minutes or less in run time, how many options does she have?
*/
select count(title) from film
where length<=50

-------------------------------------------------------------------------------------------------------------------
/*
Situation 9:
How many payment transactions were greater than $.5.00?
*/
select count(*) from payment
where amount>5
-------------------------------------------------------------------------------------------------------------------
/*
Situation 10:
How many actors have a first name that starts with the letter P?
*/
select count(*) from actor
where first_name ilike 'p%'

-------------------------------------------------------------------------------------------------------------------
/*
Situation 11:
How many unique districts are our customers from?
*/
select count(distinct(district)) from address
-------------------------------------------------------------------------------------------------------------------
/*
Situation 12:
Retrieve the list of names for those distinct districts from the previous question?
*/
select distinct(district) from address

-------------------------------------------------------------------------------------------------------------------
/*
Situation 13:
How many films have a rating of R and a replacement cost between $5 & $15
*/
select count(*) from film
where replacement_cost between 5 and 15 and rating='R'

-------------------------------------------------------------------------------------------------------------------
/*
Situation 14:
How many films have the word Truman somewhere in the title?
*/
select count(*) from film
where title ilike '%truman%'

-------------------------------------------------------------------------------------------------------------------
/*
Situation 15:
We have two staff members, with staff IDs 1 & 2. We want to give a bonus to the staff member that handled the most payments. (Most in terms of number of payments processed, not dollar amount).

How many payments did each staff member handle and who gets the bonus?
*/

select staff_id,count (amount) from payment
group by staff_id
order by count (amount) desc
-------------------------------------------------------------------------------------------------------------------
/*
Situation 16:
Corporate HQ is conducting a study on the relationship between replacement cost and a movie MPAA rating (e.g: G,PG,R etc...)

What's the average replacement cost per MPAA rating?
*/

select rating,round(avg(replacement_cost),0) from film
group by rating
-------------------------------------------------------------------------------------------------------------------
/*
Situation 17:
We are running a promotion to reward our top 5 customers with coupons.

What are the customer ids of the top 5 customers by total spend?
*/

select customer_id,sum(amount) from payment
group by customer_id
order by sum(Amount) desc
limit 5
-------------------------------------------------------------------------------------------------------------------
/*
Situation 18:
We are launching a platinum service for our most loyal customers. We will assign platinum status to customers that have 40 or more transaction payments.
What customer_ids are eligible for platinum status?
*/

select customer_id,count(amount) from payment
group by customer_id
having count(amount)>=40
-------------------------------------------------------------------------------------------------------------------
/*
Situation 19:
What are the customer ids of customers who have spent more than $100 in payment transactions with our staff_id member 2?
*/

select customer_id,sum(amount) from payment
where staff_id=2
group by customer_id
having sum(amount)>100

