-- Commentaire en SQL

-- ***********************************************************************************************************
-- INTRODUCTION

--SQL = Structured Query Language

-- Il s'agit d'un language de requête qui nous permet d'interroger une base de données.

-- Base de Données (BDD) - Emplacement de données sauvegardées qui permet d'éffectuer des opération de lectures et d'écritures
-- Une BDD est constitué de TABLES, qui elles mêmes contiennent des colonnes (CHAMPS)

-- SGBD = Système de gestion de base de données

-- C'est un logiciel qui sert d'interface entre utilisateurs et la BDD qui permet d'introduire des données, de les mettres à jours ou les supprimer

-- CRUD = acronyme anglais pour Create, Read, Update, Delete




-- CONNEXION --------------------------------------------------------------------

-- Ouvrir la console xampp : powershell, shell de xampp:
--      cd c:\xampp\mysql\bin
--      mysql.Exe -u root -p


-- MAMPP

-- Ouvrir la console (terminal) ou shell sous windows :
--      /Applications/MAMP/library/bin/mysql -h localhost -u root -p
--      Password : root

-----------------------------------------------------------------------------

-- REQUETE GENERAL 

-- Créer et utiliser une BDD

CREATE DATABASE entreprise; -- Pour créer une base de données nommée "entreprise"

-- Les requêtes SQL sont insensible à la casse, en revanche les commandes principales doivent être en majuscule par convention

SHOW DATABASES; -- Permet d'afficher les BDD disponibles

USE entreprise; -- Utiliser/Lire la BDD "entreprise"



-- Voir les tables présentent dans la BDD :
SHOW TABLES; -- Affiche les tables

DESC employes; -- Pour observer la structure de la table "employé"

-- Supprimer des éléments :

DROP DATABASE nom_de_la_bdd; -- Pour supprimer la BDD

DROP TABLE nom_de_la_table; -- Pour supprimer la table

TRUNCATE nom_de_la_table; -- Pour vider la table


------------------------------------------------------------------------------------------------------------------------

-- Requêtes de séléction

-- SELECT ALL

SELECT * FROM employes; -- signifie SELECT all FROM -- Affiche tout les champs de la table "employes"

-- SELECT

SELECT nom, prenom FROM employes; -- Affiche le nom et le prénom de tout les employes

SELECT service FROM employes;

-- DISTINCT

SELECT DISTINCT service FROM employes; -- Permet d'afficher les services de la table employes en dédoublonné

-- clause WHERE

SELECT nom, salaire FROM employes WHERE prenom = 'Jean-pierre'; -- Affiche le nom et le salaire des employes ayant pour prénom 'Jean-pierre'

-- BETWEEN 

SELECT nom, prenom, date_embauche FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2010-12-31';

SELECT nom, prenom, date_embauche FROM employes WHERE date_embauche BETWEEN '2006-01-01' AND '2006-12-31';

-- LIKE

SELECT prenom, nom FROM employes WHERE prenom LIKE 's%'; -- Affiche le prénom des employés ou les prénoms commencant par un 's'

SELECT prenom FROM employes WHERE prenom LIKE '%e'; -- Affiche le prénom des employés ou les prénoms terminant par un 'r'

SELECT prenom FROM employes WHERE prenom LIKE '%-%'; -- Affiche le prénom ou les prénoms qui contiennent '-' soit les prenoms composé

SELECT prenom FROM employes WHERE prenom LIKE 'a%e'; -- Affiche le ou les prénoms qui commencent par "a" et finissent par "e"

SELECT prenom FROM employes WHERE prenom LIKE 'j%-%e';

-- OPERATEURS DE COMPARAISON

-- =
-- <
-- >
-- <=
-- >=
-- != ou <>     Différent de

SELECT nom, prenom, service FROM employes WHERE service != 'informatique'; -- On affiche les services qui sont différents d'informatique

SELECT nom, prenom, salaire service FROM employes WHERE salaire >= 2500; -- Affiche les employes qui ont un salaire à plus de 2500

-- ORDER BY

SELECT prenom, salaire FROM employes ORDER BY salaire; -- Affiche le prénom et le salaire des employés par salaire (par défault de manière croissante)

SELECT prenom, salaire FROM employes ORDER BY prenom DESC; -- On affiche le prénom et le salire des employés classés par salaire croissant et par prénom décroissant pour salaire similaire

-- LIMIT

SELECT nom, prenom, service, salaire FROM employes ORDER BY salaire DESC LIMIT 1; -- On affiche les infos triées par salaires décroissant mais en spécifiant uniquement le premier élément
SELECT nom, prenom, service, salaire FROM employes ORDER BY salaire LIMIT 3; -- (Equivalent à 0,3) Affiche les infos des trois premiers éléments de la liste

SELECT nom, prenom, service, salaire FROM employes ORDER BY salaire LIMIT 1,3; -- On affiche les trois premiers éléments de la liste en excluant les 3 premiers résultat

-- ATTENTION A L'ORDRE : SELECT ... FROM ... ORDER BY ... LIMIT



-- Les alias avec le terme AS (colonne nommée)

SELECT nom, prenom, salaire*12 AS salaire_annuel FROM employes; -- Ici on renome la colonne salaire*12 par salaire annuel, afin d'etre plus clair dans le tableau de rendu


-- SUM  Permet de calculer la somme

SELECT SUM(salaire*12) FROM employes; -- On affiche ici la somme de tout les salires annuels des employés

SELECT SUM(salaire) FROM employes;

 
-- MIN et MAX

SELECT MIN(salaire) FROM employes; -- On affiche le salaire minimum des employés

SELECT MAX(salaire) FROM employes; -- On affiche le salaire max des employés


SELECT prenom, MIN(salaire) FROM employes; -- Cette requète génère une erreur ou une incongruité. On ne peut pas croiser une MIN ou MAX requete avec une autre colonne de la table

SELECT prenom, salaire FROM employes ORDER BY salaire ASC LIMIT 1; -- Pour récupérer les infos de celui qui a le plus gros ou petits élement.
-- ASC pour Ascendant et DESC pour Descendant


-- AVG (average = moyenne)

SELECT AVG(salaire) FROM employes; -- Affiche le salaire moyen des employés

-- ROUND

SELECT ROUND( AVG(salaire),1 ) FROM employes; -- Arrondi le résultat du salaire moyen -- Le ,1 arrondi un chiffre après la virgule

SELECT COUNT(id_employes) FROM employes WHERE sexe='f'; -- Affiche combien d'employé sont de sexe féminin

-- IN 

SELECT prenom, service FROM employes WHERE service IN ('comptabilite', 'informatique'); -- On affiche le prénom et le service des employés étant dans le service comptabilité ou informatique

-- NOT IN

SELECT prenom, service FROM employes WHERE service NOT IN ('comptabilite', 'informatique'); -- On affiche le prénom et le service des employés n'étant PAS dans les services comptabilité ou informatique

-- AND et OR

SELECT prenom, salaire, service FROM employes WHERE service = 'commercial' AND salaire <= 2000; -- On affiche le prénom, le salaire et le service des employé travaillant en tant que commercial auxquel leur salaire est plus petit ou égal à 2000

SELECT prenom, salaire, service FROM employes WHERE service = 'production' AND salaire = 1900 OR salaire = 2300; -- On affiche le prénom, le salaire et le service des employé travaillant en production auxquel leur salaire égale à 1900 OU des employés qui ont un salaire égal à 2300

-- REVIENT A ECRIRE
SELECT prenom, salaire, service FROM employes WHERE (service = 'production' AND salaire=1900) OR (service = 'production' AND salaire = 2300);


-- GROUP BY
SELECT service, COUNT(id_employes) AS nombre_employes FROM employes GROUP BY service; -- Affiche le nom du service et le nombre d'employé travaillant dedans

-- GROUP BY ... HAVING (GROUPER PAR ... AYANT)

SELECT service, COUNT(id_employes) AS nombre_employes FROM employes GROUP BY service HAVING nombre_employes >1; -- Affiche le nom du service et le nombre d'employé travaillant dedans et ou il y a plus d'un employé

-- Attention à l'ordre des mot cl"s :
-- SELECT ... FROM ... WHERE ... GROUP BY ... ORDER BY ... LIMIT ...

---------------------------- REQUETES D'INSERTION --------------------------

-- INSERT INTO

-- Insertion d'un nouvel employe -- Les champs entre les premières () et les secondes doivent être renseignés dans le même ordre

INSERT INTO employes (prenom,nom,sexe,service,date_embauche,salaire) VALUES ('Alexis', 'Ferreira', 'm', 'informatique', '2021-05-31', 32420);

-- Même chose mais nécéssite de remplir tout les champs en table y compris l'ID définit sur NULL car en auto-incrémentation en BDD

INSERT INTO employes VALUES (NULL, 'Mark', 'Zuckerberg','m', 'Assistant','2021-05-31', 1200);



--------------- REQUETES DE MODIFICATION --------------------

-- UPDATE

UPDATE employes SET salaire = 4500 WHERE id_employes = 992; -- Ici on modifie le salaire de l'id 992 (On utilise l'id dans le WHERE car il est le seul a être unique)

-- A NE PAS FAIRE SANS CLAUSE WHERE LORSQUE L'ON SOUHAITE MODIFIER SEULE UNE OU QUELQUES ENTREES
UPDATE employes SET salaire=1500;

-- REPLACE

REPLACE INTO employes (id_employes,prenom, nom,sexe,service,date_embauche,salaire) VALUES (2000, 'test', 'test','m','information','2021-06-01', 2500); -- Ici nous n'avons pas d'entrée avec un id 2000 donc ça en créer un

REPLACE INTO employes (id_employes,prenom, nom,sexe,service,date_embauche,salaire) VALUES (2000, 'test', 'test','m','information','2021-06-01', 4500); -- Ici nous avons une entrée avec un id 2000, donc ca va modifier les valeurs 

---------------------------------------------------------

-- REQUETES DE SUPRESSION

-- DELETE

DELETE FROM employes WHERE id_employes=900; -- Supprime l'employé ayant l'id 900

DELETE FROM employes WHERE id_employes=417 OR id_employes=627; -- Supprime les deux employés avec leur id respectif. On utilise OR car l'id étant unique, seul OR lui permet de saisir qu'il doit supprimer plusieurs employés

-- A NE PAS FAIRE : un DELETE sans clause WHERE

DELETE FROM employes; -- Revient à vider la table entière









-- ***************************
-- Exercices
-- ***************************
-- 1. Afficher le service de l'employé 547
SELECT service FROM employes WHERE id_employes = '547';
-- 2. Afficher la date d'embauche d'Amandine
SELECT date_embauche FROM employes WHERE prenom = 'Amandine';
-- 3. Afficher le nombre de commerciaux
SELECT COUNT(id_employes) FROM employes WHERE service = 'commercial';
-- 4. Afficher le salaire des commerciaux sur 1 année
SELECT salaire*12 FROM employes WHERE service ='commercial';
-- 5. Afficher le salaire moyen par service
SELECT service, AVG(salaire) AS salaire_annuel FROM employes GROUP BY service;
-- 6. Afficher le nombre de recrutement sur 2010
SELECT COUNT(id_employes) FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2010-12-31';
-- 7. Augmenter le salaire de chaque employés de 100

-- 8. Afficher le nombre de services DIFFERENTS
SELECT COUNT(DISTINCT service) FROM employes;
-- 9. Afficher le nombre d'employés par service
SELECT service, COUNT(id_employes) AS nbr_employes FROM employes GROUP BY service;
-- 10. Afficher les informations de l'employé du service commercial gagnant le salaire le plus élevé
SELECT * FROM employes WHERE service = 'commercial' ORDER BY salaire DESC LIMIT 1;
-- 11. Afficher l'employé ayant été embauché en dernier
SELECT nom, prenom FROM emplyes ORDER BY date_embauche DESC LIMIT 1;