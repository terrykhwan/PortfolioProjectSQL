SELECT *
FROM crime_scene_report
WHERE type = 'murder' AND date = 20180115 AND city ='SQL City';

SELECT name, id, address_street_name
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;


SELECT name, id, address_street_name
FROM person
WHERE name LIKE '%Annabel%' AND address_street_name = 'Franklin Ave';


SELECT person.id, person.name, interview.transcript
FROM person
JOIN interview
ON person.id = interview.person_id
WHERE person.id = 16371 OR person.id = 14887;


SELECT *
FROM get_fit_now_member
WHERE get_fit_now_member.id LIKE '%48z%' AND membership_status = 'gold';


SELECT *
FROM get_fit_now_check_in
WHERE check_in_date ='20180109' AND membership_id IN ( '48Z7A', '48Z55');

SELECT person.name, drivers_license.gender, person.ssn, drivers_license.plate_number, drivers_license.car_make, person.address_street_name, person.address_number 
FROM person
JOIN drivers_license
ON drivers_license.id = person.license_id
WHERE person.id IN (28819, 67318);


SELECT *
FROM interview
WHERE person_id = '67318';


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


INSERT INTO solution(user, value)
VALUES (1, 'Miranda Priestly');
SELECT *
FROm solution;
