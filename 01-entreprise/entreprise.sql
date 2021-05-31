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