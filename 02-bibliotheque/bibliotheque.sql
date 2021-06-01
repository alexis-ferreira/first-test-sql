-- ****************
-- Exercices
-- ****************

-- 1. Quel est l'id_abonne de Laura ?
SELECT id_abonne FROM abonne WHERE prenom = 'Laura';
-- 2. L'abonné d'id_abonne 2 est venu emprunté un livre à quelles dates (date_sortie) ?
SELECT date_sortie FROM emprunt WHERE id_abonne = '2';
-- 3. Combien d'emprunts ont été effectués en tout ?
SELECT COUNT(id_emprunt) FROM emprunt;
-- 4. Combien de livres sont sortis le 2011-12-19 ?
SELECT COUNT(id_emprunt) FROM emprunt WHERE date_sortie = '2011-12-19';
-- 5. Une Vie est de quel auteur ?
SELECT auteur FROM livre WHERE titre = 'Une vie';
-- 6. De combien de livres d'Alexandre Dumas dispose-t-on ?
SELECT COUNT(id_livre) FROM livre WHERE auteur = 'Alexandre Dumas';
-- 7. Quel id_livre est le plus emprunté ?
SELECT id_livre FROM emprunt GROUP BY id_livre



---------------------------------
------ REQUETES IMBRIQUEES-------

-- Une requête imbriqué permet de réaliser une requete sur plusieurs table lorsqu'elles ont un chant en commun. Ainsi lorsque dans le SELECT nous utilisons les champs commun de ces tables (ce champ commun est obligatoire, c'est le principe ou jeu de clés primaires et clés étrangère)

-- Un champ NULL se test avec un IS NULL

SELECT id_livre FROM emprunt WHERE date_rendu IS NULL; -- Affiche les livres empruntés dont date_rendu est NULL, donc le retour n'a pas été éffectué

-- Titre des livres non rendus donc dont le champs date_rendu est NULL

-- On récupère le titre des livres graces aux ID -- On récupère ici les id des livres non rendu
SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);

-- IN est utilisé lorsque l'on sait que plusieurs résultats sont attendus. Si un seul résultat est attendu, on peut utiliser =

SELECT id_livre FROM emprunt WHERE id_abonne =(SELECT id_abonne FROM abonne WHERE id_abonne = 3);

-- 1. Afficher le prénom des abonnés ayant emprunté un livre le 2011-12-19
SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE date_sortie = '2011-12-19');
-- 2. Afficher le prénom des abonnés ayant emprunté un livre d'Alphonse Daudet
SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE id_livre IN (SELECT id_livre FROM livre WHERE auteur = 'GUY DE MAUPASSANT'));
-- 3. Afficher le titre des livres que Chloé a empruntés
SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE id_abonne = 3);
-- 4. Afficher le titre des livres que Chloé n'a pas encore empruntés
SELECT titre FROM livre WHERE id_livre NOT IN (SELECT id_livre FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = "Chloé"));
-- 5. Afficher le titre des livres que Chloé n'a pas encore rendus

-- 6. Combien de livres Benoît a empruntés ?


----------------------------
----- JOINTURE INTERNE --------

-- Une jointure interne est une requete permettant de faire des relations entre differentes table grace aux champs en commun. De plus elle permette de séléctionné (afficher) des champs qui proviennent de table differentes dans le SELECT 

-- Difference entre imbriquee et jointure:
--  Une jointure est possible dans tout les cas alors qu'une requête imbriquée n'est possible seulement si l'affichage de donnée ne provient que d'une seule et même table

-- Lorsqu'elle est possible, la requete imbriquee est préférable car plus rapide même si inquantifiable dans notre cas.

-- Afficher les dates de sorties, de rendu et le prenom pour l'abonné qui s'apelle Guillaume

SELECT a.prenom, e.date_sortie, e.date_rendu
FROM abonne a
INNER JOIN emprunt e
ON a.id_abonne = e.id_abonne
WHERE a.prenom = 'Guillaume';

-- 1ere ligne: ce que je veux afficher
-- 2eme ligne : la premiere table d'ou proviennent les informations
-- 3ème ligne : la secconde table d'ou proviennent les informations
--4ème ligne : la jointure qui lie les 2 champs en commun dans les 2 tables
-- 5ème ligne: la condition complementaire éventuelle ici le prénom

-- "a" et "e" s'appellent des alias de tables. ils sont définis par FROM et INNER JOIN après le nom de la table à laquelle ils appartiennent

-- donc a.prenom -> table.champs



-- *********************
-- Exercices
-- *********************
-- 1. Afficher le titre, date de sortie et date de rendu des livres écrits par Alphonse Daudet.

-- 2. Afficher qui (prénom) a emprunté "Une vie" sur 2011.

-- 3. Afficher le nombre de livres empruntés par chaque abonné (prénom).

-- 4. Afficher qui (prénom) a emprunté quels livres (titre) et à quelles dates (date de sortie).