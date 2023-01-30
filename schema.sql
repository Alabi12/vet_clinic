/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY, 
    name VARCHAR(250), 
    date_of_birth DATE NOT NULL, 
    escape_attempts INT NOT NULL, 
    neutered BOOLEAN, weight_kg DECIMAL,
    species VARCHAR(255);
    );

/*Create owners table  */
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(255),
    age INT  
);

/* Create the species table */
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255)
);

/* Modify animals table*/

ALTER TABLE animals
DROP COLUMN species;


ALTER TABLE animals
ADD COLUMN species_id INT,
ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

--Project Day 4---

--create vets table--
create table vets (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    name VARCHAR(255), 
    age INT, 
    date_of_graduation DATE
);

/*There is a many-to-many relationship between 
the tables species and vets: a vet can specialize 
in multiple species, and a species can have multiple 
vets specialized in it. Create a "join table" called 
specializations to handle this relationship.*/

create table specializations (species_id INT, vets_id INT);
ALTER TABLE specializations ADD CONSTRAINT species_fkey FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE specializations ADD CONSTRAINT vets_fkey FOREIGN KEY (vets_id) REFERENCES vets(id);

/*There is a many-to-many relationship between the 
tables animals and vets: an animal can visit multiple 
vets and one vet can be visited by multiple animals. 
Create a "join table" called visits to handle this 
relationship, it should also keep track of the date of the visit.*/

create table visits (animals_id INT, vets_id INT, date_of_visit date);
ALTER TABLE visits ADD CONSTRAINT animals_fkey FOREIGN KEY (animals_id) REFERENCES animals(id);
ALTER TABLE visits ADD CONSTRAINT vets_fkey FOREIGN KEY (vets_id) REFERENCES vets(id);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

---PERFORMANCE IMPROVEMENT---
CREATE index animals_id_index ON visits (animals_id);
CREATE INDEX vets_id_index ON visits (vets_id);
CREATE INDEX owners_email_index ON owners (id);