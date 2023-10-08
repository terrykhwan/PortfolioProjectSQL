/* All analysis of crimes committed on the 15th of January in SQL city 
from the police department database is highlighted in this report. */

--filtering the table and identifying that the crime was a murder--
SELECT *
FROM crime_scene_report
WHERE type = 'murder' AND date = 20180115 AND city ='SQL City';

/* using the address in the result, "Northwestern Dr", of the first witness to, 
identify other information (name and id) */
	
SELECT name, id, address_street_name
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

--Querying the Person table by filtering names, using what part of it as well as the address name.--
SELECT name, id, address_street_name
FROM person
WHERE name LIKE '%Annabel%' AND address_street_name = 'Franklin Ave';

/* Joining both the person table and interview table 
to retrieve information(the details of each witness) by leveraging the relationships between them. */ 

SELECT person.id, person.name, interview.transcript
FROM person
JOIN interview
ON person.id = interview.person_id
WHERE person.id = 16371 OR person.id = 14887;

--Querying to check the get_fit_now_member table and filtering the table based on the first witness--
SELECT *
FROM get_fit_now_member
WHERE get_fit_now_member.id LIKE '%48z%' AND membership_status = 'gold';


SELECT *
FROM get_fit_now_check_in
WHERE check_in_date ='20180109' AND membership_id IN ( '48Z7A', '48Z55');


/*using the schema diagram to join the person table (primary key id) and driver license table (foreign key id)
and filtering with their person_id */

SELECT person.name, drivers_license.gender, person.ssn, drivers_license.plate_number, drivers_license.car_make, person.address_street_name, person.address_number 
FROM person
JOIN drivers_license
ON drivers_license.id = person.license_id
WHERE person.id IN (28819, 67318);

--Querying transcript from the interview table--
SELECT *
FROM interview
WHERE person_id = '67318';

--Using the information given in transcript to identify suspect--
SELECT person.name, person. address_number, person. address_street_name, person.ssn
FROm person
JOIN drivers_license
ON person.license_id = drivers_license.id
JOIN facebook_event_checkin
ON person.id = facebook_event_checkin.person_id
WHERE facebook_event_checkin.event_name is 'SQL Symphony Concert' 
		AND facebook_event_checkin.date LIKE '%201712%'
        AND drivers_license.car_make is 'Tesla' AND drivers_license.car_model is 'Model S'
		AND gender is 'female' AND drivers_license.height BETWEEN 65 and 67
        AND drivers_license.hair_color is 'red'
GROUP by person.name
HAVING count(*) == 3;

--solving the case and confirming solution-- 
INSERT INTO solution(user, value)
VALUES (1, 'Miranda Priestly');
SELECT *
FROM solution;
