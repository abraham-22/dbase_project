-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT COUNT(cf_id)
FROM campaign 
GROUP BY cf_id
ORDER BY cf_id DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT * FROM backers ;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT co.first_name,
	co.last_name,
    co.email,
    ca.goal,
    ca.pledged,
	(ca.goal-ca.pledged)AS remaining_goal_amount
-- INTO email_contacts_remaining_goal_amount
FROM contacts as co
	INNER JOIN campaign as ca
		ON (co.contact_id = ca.contact_id)
ORDER BY ca.goal DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount ;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
-- 1. Join Backers and Campaign table
SELECT b.first_name,
	b.last_name,
    b.email,
    ca.cf_id,
    ca.company_name,
	ca.description,
	ca.end_date,
	ca.goal,
    ca.pledged
INTO backers_new
FROM backers as b
	LEFT JOIN campaign as ca
		ON (b.cf_id = ca.cf_id)
;
-- 2. Using the new table get the remaining amount of the campaign goal as "Left of Goal"
SELECT bn.email,
	bn.last_name,
    bn.first_name,
    bn.cf_id,
    bn.company_name,
	bn.description,
	bn.end_date,
	bn.goal,
	bn.pledged,
    (bn.goal-bn.pledged)AS remaining_goal_amount
INTO email_backers_remaining_goal_amount
FROM backers_new as bn
ORDER BY bn.email DESC;

-- Or without joining
SELECT b.first_name,
	b.last_name,
    b.email,
    ca.cf_id,
    ca.company_name,
	ca.description,
	ca.end_date,
	(ca.goal-ca.pledged)AS remaining_goal_amount
-- INTO email_backers_remaining_goal_amount
FROM backers as b
	LEFT JOIN campaign as ca
		ON (b.cf_id = ca.cf_id)
ORDER BY b.email DESC;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount ;

