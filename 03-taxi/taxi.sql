CREATE DATABASE taxi;

USE taxi;

-- On importe le fichier contenant les tables (sources).


-- ******

-- 1. Qui (prenom) conduit la voiture d'id 503 en requête de jointure ?

SELECT c.prenom
FROM conducteur c
INNER JOIN association_vehicule_conducteur a
ON c.id_conducteur=a.id_conducteur
WHERE a.id_vehicule=503;

-- 2. Qui conduit quel modèle (prenom, modele) ?

SELECT c.prenom, v.modele
FROM conducteur c
INNER JOIN association_vehicule_conducteur a
ON c.id_conducteur=a.id_conducteur
INNER JOIN vehicule v
ON a.id_vehicule=v.id_vehicule;

-- 3. Ajoutez vous dans la table conducteur.

INSERT INTO conducteur (prenom,nom) VALUES ('antoine','dessertenne');

--    Afficher TOUS les conducteurs (prenom) ainsi que les modèles de véhicules.
SELECT c.prenom, v.modele
FROM   conducteur c 
LEFT JOIN association_vehicule_conducteur a
ON a.id_conducteur=c.id_conducteur
LEFT JOIN vehicule v
ON a.id_vehicule=v.id_vehicule;



-- 4. Ajoutez un véhicule dans la table correspondante.
INSERT INTO vehicule (marque, modele, couleur, immatriculation) VALUES ('Renault','Clio','Noir','CZ-667-FC');
--    Afficher TOUS les modèles de véhicules, y compris ceux qui n'ont pas de chauffeur, et le prénom des conducteurs.
SELECT v.modele, c.prenom
FROM vehicule v
LEFT JOIN association_vehicule_conducteur a
ON a.id_vehicule=v.id_vehicule
LEFT JOIN conducteur c
ON c.id_conducteur=a.id_conducteur;
-- 5. Afficher TOUS les conducteurs (prenom) et TOUS les modèles de véhicules.
(
    SELECT c.prenom, v.modele
    FROM conducteur c
    LEFT JOIN association_vehicule_conducteur a
    ON a.id_conducteur=c.id_conducteur
    LEFT JOIN vehicule v
    ON a.id_vehicule=v.id_vehicule
)
UNION
(
    SELECT c.prenom, v.modele
    FROM vehicule v
    LEFT JOIN association_vehicule_conducteur a
    ON a.id_vehicule=v.id_vehicule
    LEFT JOIN conducteur c
    ON c.id_conducteur=a.id_conducteur
);

ALTER TABLE `association_vehicule_conducteur` ADD CONSTRAINT `macontrainte` FOREIGN KEY (`id_conducteur`) REFERENCES `conducteur`(`id_conducteur`) ON DELETE CASCADE ON UPDATE CASCADE;

-- La clé primaire (Primary key, clé jaune dans PHPmyAdmin) est la clé toujours attrribué à la première colonne d'id de la table et permet de génerer un auto increment.
-- La clé étrangère (Foreign key, clé grise dans PHPmyAdmin) est la clé qui permet de génerer une contrainte entre deux tables différentes et qui sera relié automatiquement à une clé primaire.

--CASCADE (enchainement ou bien de modification ou bien de suppression sur la table en lien)
--SET NULL (Set à NULL en BDD ou sur la modification ou sur la suppression sur la table en lien)
--NO ACTION (Pas d'action sur la table en liens, aucune modification)
--RESTRICT (bloque tout action si existence sur la table en lien)

-- **************************
-- Exercices
-- **************************

*****************************************************
EXERCICES CONTRAINTES RELATIONNELLES TAXIS
*****************************************************


EXERCICE 1

Vous allez créer des contraintes d'intégrités entre les tables "association_vehicule_conducteur" et "conducteur" :

1- La première doit permettre de répercuter tous changements d'id de la table "conducteur" dans la table "association_vehicule_conducteur".
2- La seconde doit  permettre de bloquer toute suppression de conducteur de la table "conducteur" tant qu'il est associé à un véhicule dans "association_vehicule_conducteur".

ALTER TABLE `association_vehicule_conducteur` ADD CONSTRAINT `macontrainte` FOREIGN KEY (`id_conducteur`) REFERENCES `conducteur`(`id_conducteur`) ON DELETE RESTRICT ON UPDATE CASCADE;


EXERCICE 2

Vous allez créer des contraintes d'intégrités entre les tables "association_vehicule_conducteur" et "vehicule" :

1- La première doit permettre de répercuter tous changements d'id de la table "vehicule" dans la table "association_vehicule_conducteur".
2- La seconde doit  permettre de mettre la valeur NULL dans la table "association_vehicule_conducteur" lors de la suppression d'un véhicule de la table "vehicule", pour conserver l'historique de la présence des conducteurs associés à ce véhicule.



*****************************************************