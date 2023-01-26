/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-03-02', 0, 'TRUE', 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, 'TRUE', 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, 'FALSE', 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, 'TRUE', 11);


/* Alter Table data */

ALTER TABLE animals ADD COLUMN species varchar;
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
  VALUES ('Charmander', '2020-02-08', 0, false, -11.00), ('Plantmon', '2021-11-15', 2, true, -5.70), ('Squirtle', '1993-04-02', 3, false, -12.13),
    ('Angemon', '2005-06-12', 1, true, -45.00), ('Boarmon', '2005-06-07', 7, true, 20.40), ('Blossom', '1998-10-13', 3, true, 17.00),
    ('Ditto', '2022-05-14', 4, true, 22.00)
;

  -- Insert data into the species table
INSERT INTO species (name) 
VALUES ('Pokemon'),
  ('Digimon');

-- Update the animals table with species_id information
UPDATE animals
SET species_id = (
    SELECT id FROM species WHERE name = (
        CASE
            WHEN animals.name LIKE '%mon' THEN 'Digimon'
            ELSE 'Pokemon'
        END
    )
);

-- Update the animals table with owner_id information
UPDATE animals 
SET owner_id = (
    SELECT id 
    FROM owners 
    WHERE full_name = (
        CASE animals.name 
            WHEN 'Agumon' THEN 'Sam Smith' 
            WHEN 'Gabumon' THEN 'Jennifer Orwell' 
            WHEN 'Pikachu' THEN 'Jennifer Orwell' 
            WHEN 'Devimon' THEN 'Bob' 
            WHEN 'Plantmon' THEN 'Bob' 
            WHEN 'Charmander' THEN 'Melody Pond' 
            WHEN 'Squirtle' THEN 'Melody Pond' 
            WHEN 'Blossom' THEN 'Melody Pond' 
            WHEN 'Angemon' THEN 'Dean Winchester' 
            WHEN 'Boarmon' THEN 'Dean Winchester' 
        END
    )
);

--Project Day 4---
/*1*/
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, 'Apr 23, 2000');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, 'Jan 17, 2019');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, 'May 04, 1981');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, 'Jun 08, 2008');

/*2*/
INSERT INTO specializations (species_id, vets_id) VALUES (1, 1);
INSERT INTO specializations (species_id, vets_id) VALUES (2, 3);
INSERT INTO specializations (species_id, vets_id) VALUES (2, 3);
INSERT INTO specializations (species_id, vets_id) VALUES (1, 4);

/*3*/
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES (1, 3, '2020-07-22');
INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES (2, 4, '2021-02-02');
INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES (3, 2, '2020-01-05');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, '2020-05-08');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, '2020-05-14');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (4, 3, '2021-05-04');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (5, 4, '2021-02-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 2, '2019-12-21');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 1, '2020-08-10');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 2, '2021-04-07');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (7, 3, '2019-09-29');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2019-01-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2019-05-15');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2020-02-27');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, '2020-08-03');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 3, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 4, '2021-01-11');

/*4*/
--Who was the last animal seen by William Tatcher--
SELECT animals.name 
FROM visits 
JOIN vets ON visits.vets_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
WHERE vets.name = 'William Tatcher' 
ORDER BY date_of_visit DESC 
LIMIT 1;

--How many different animals did Stephanie Mendez see?--
SELECT COUNT(animals.name) 
FROM visits 
JOIN vets ON visits.vets_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
WHERE vets.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties--
SELECT vets.name, species.name 
FROM specializations FULL 
JOIN vets ON specializations.vets_id = vets.id 
FULL JOIN species ON specializations.species_id = species.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.--
SELECT animals.name 
FROM visits 
JOIN vets ON visits.vets_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
WHERE vets.name = 'Stephanie Mendez' 
AND visits.date_of_visit 
BETWEEN '2020-04-01' 
AND '2020-08-30';

--What animal has the most visits to vets?--
SELECT animals.name AS Pet, COUNT(*) 
AS CNT FROM visits 
JOIN vets ON visits.vets_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
GROUP BY Pet 
ORDER BY CNT 
DESC LIMIT 1;

--Who was Maisy Smith's first visit?--
SELECT animals.name 
FROM visits 
JOIN vets ON visits.vets_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
WHERE vets.name = 'Maisy Smith' 
ORDER BY visits.date_of_visit 
ASC 
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.--
SELECT * FROM visits 
JOIN vets on visits.vets_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
ORDER BY visits.date_of_visit 
DESC LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?--
SELECT COUNT(*) FROM visits J
OIN vets ON visits.vets_id = vets.id 
FULL JOIN specializations ON specializations.vets_id = vets.id 
WHERE specializations.species_id IS NULL;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.--
SELECT species.name AS S, COUNT(*) 
AS CNT FROM visits 
JOIN vets ON visits.vets_id = vets.id 
JOIN animals ON visits.animals_id = animals.id 
JOIN species ON animals.species_id = species.id 
FULL JOIN specializations ON specializations.vets_id = vets.id 
WHERE vets.name = 'Maisy Smith' 
GROUP BY S 
ORDER BY CNT 
DESC LIMIT 1;