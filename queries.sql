/*Queries that provide answers to the questions from all projects.*/


SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN DATE '2016-01-01' AND DATE '2019-12-31';
SELECT name FROM animals WHERE neutered = 'YES' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'YES';
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT species FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK TRANSACTION;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > DATE '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT TRANSACTION;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered, AVG(escape_attempts) as avg_escapes FROM animals
GROUP BY neutered
ORDER BY avg_escapes DESC
LIMIT 1;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;

SELECT name FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.species_id) as count FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.id;

SELECT animals.name FROM animals
INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT owners.full_name, COUNT(animals.species_id) as count FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.id ORDER BY count DESC
LIMIT 1;
