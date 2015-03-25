SELECT COUNT(Name) FROM Country; //Räkna länder

SELECT *
FROM organization
JOIN ismember
ON organization.abbreviation=ismember.organization
WHERE ismember.country='S' // Alla org sverige e med i

SELECT * FROM (SELECT *
FROM River
JOIN located
ON located.river=River.name
WHERE country='USA') AS LongestRivers ORDER BY length DESC LIMIT 3 //Longest River






LABB 1

SELECT Name, Population, Capital FROM Province WHERE country = 'S' ORDER BY Population DESC



SELECT * FROM Organization WHERE name LIKE '%Nuclear%' AND established IS NULL



SELECT Mountain, height AS HeightInMeters, height*3.2808 AS HeightInFeet, continent FROM ((SELECT MAX(height), continent FROM (SELECT continent, height,mountain FROM (SELECT * FROM (encompasses JOIN (SELECT mountain,height,country FROM 
(Mountain JOIN geo_mountain ON geo_mountain.mountain = Mountain.name)) AS temp1
ON encompasses.country = temp1.country)) AS temp2) AS HogstaBerg GROUP BY hogstaberg.continent) AS hogstaberglista 
JOIN (Mountain JOIN geo_mountain ON geo_mountain.mountain = Mountain.name) AS hogsta ON hogstaberglista.max = hogsta.height) GROUP BY height, mountain, continent



SELECT Name, SUM(length) AS TotLength, COUNT(Name) AS Borders, CAST(SUM(length)/COUNT(Name) AS BIGINT) AS Ratio FROM (Country JOIN borders ON Country.code = borders.country1 OR Country.code = borders.country2) GROUP BY Name ORDER BY ratio DESC



SELECT Name, Population, CAST(((1+(population_growth/100))^10)*Population AS BIGINT) AS pop10, CAST(((1+(population_growth/100))^25)*Population AS BIGINT)  AS Pop25, CAST(((1+(population_growth/100))^50)*Population AS BIGINT) AS Pop50, CAST(((1+(population_growth/100))^100)*Population AS BIGINT) AS Pop100 FROM (Country JOIN Population ON country.code = population.country) ORDER BY Name





SELECT * FROM(SELECT * FROM (SELECT name, code FROM (SELECT name, code FROM country) AS land WHERE land.name NOT IN (SELECT name FROM country JOIN ismember ON country.code=ismember.country WHERE organization= 'NATO')) AS NATO CROSS JOIN (SELECT name, code FROM country JOIN ismember ON country.code=ismember.country WHERE organization= 'NATO') AS natocross JOIN borders ON nato.code = country1 AND natocross.code = country2 OR nato.code = country2 AND natocross.code = country1) AS finish





CREATE VIEW EightThousanders AS
SELECT name, mountains, height, coordinates
FROM Mountain
WHERE height > 7999


EXPLAIN ANALYSE SELECT * FROM EightThousanders


CREATE RULE uppdatera AS ON UPDATE TO eightthousanders DO INSTEAD UPDATE Mountain SET height = NEW.height, name = NEW.name, mountains = NEW.mountains, coordinates = NEW.coordinates WHERE name = NEW.name




















WITH RECURSIVE mexico AS(



SELECT country1, country2 FROM borders WHERE 'MEX' = borders.country2 OR borders.country1 ='MEX'

 UNION

(SELECT borders.country1,borders.country2 FROM mexico, borders WHERE mexico.country1 = borders.country1 OR mexico.country1 = borders.country2 OR mexico.country2 = borders.country1 OR mexico.country2 = borders.country2)
)




SELECT name FROM (SELECT * FROM ((SELECT mexico.country1 FROM mexico) UNION (SELECT mexico.country2 FROM mexico)) AS test JOIN country ON test.country1 = country.code) AS lander ORDER BY name
