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



-- ****************
-- Exercices
-- ****************

-- 1. Quel est l'id_abonne de Laura ?

SELECT id_abonne FROM abonne WHERE prenom = 'Laura';

-- 2. L'abonné d'id_abonne 2 est venu emprunté un livre à quelles dates (date_sortie) ?

SELECT date_sortie FROM emprunt WHERE id_abonne = 2;

-- 3. Combien d'emprunts ont été effectués en tout ?

SELECT COUNT(id_emprunt) FROM emprunt;

-- 4. Combien de livres sont sortis le 2011-12-19 ?

SELECT COUNT(id_livre) FROM emprunt WHERE date_sortie = "2011-12-19";

-- 5. Une Vie est de quel auteur ?

SELECT auteur FROM livre WHERE titre = 'Une vie';

-- 6. De combien de livres d'Alexandre Dumas dispose-t-on ?

SELECT COUNT(titre) FROM livre WHERE auteur = 'ALEXANDRE DUMAS';

-- 7. Quel id_livre est le plus emprunté ?

SELECT id_livre, COUNT(id_emprunt) AS nombre FROM emprunt GROUP BY id_livre ORDER BY nombre DESC LIMIT 0,1;



--*********************
-- **Requête imbriqué**
--*********************

--Une requête imbriqué permet de réaliser une requête sur plusieurs tables lorsqu'elles ont un champs en commun
--Lorsque dans le SELECT nous utilisons le champs commun de ces tables (le champs commun est obligatoire, c'est le principe ou jeu de clés primaires et clés étrangères)

--un champs NULL se test avec IS NULL : 
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL; --affiche les livres empruntés dont date_rendu est nulle donc dont le retour n'a pas été effectué.


-- on récupère le titre des livres grace aux id_livres récupérés ensuite puis  on récupère les id des livres non rendus
SELECT titre FROM livre WHERE id_livre IN(SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);


--In est  utilisé lorsque l'on sait que plusieurs résultats sont attendus. Si un seul résultat est attendu on peut utiliser  :
SELECT id_livre FROM emprunt WHERE id_abonne =(SELECT id_abonne FROM abonne WHERE id_abonne = 3);
--Attention = renvoie à une égalité stricte

-- ******************
-- Exercices
-- ******************
-- 1. Afficher le prénom des abonnés ayant emprunté un livre le 2011-12-19

SELECT prenom FROM abonne WHERE id_abonne IN(SELECT id_abonne FROM emprunt WHERE date_sortie = '2011-12-19');

-- 2. Afficher le prénom des abonnés ayant emprunté un livre d'Alphonse Daudet

SELECT prenom FROM abonne WHERE id_abonne IN(SELECT id_abonne FROM emprunt WHERE id_livre IN(SELECT id_livre FROM livre WHERE auteur = 'ALPHONSE DAUDET'));

-- 3. Afficher le titre des livres que Chloé a empruntés

SELECT titre FROM livre WHERE id_livre IN(SELECT id_livre FROM emprunt WHERE id_abonne=(SELECT id_abonne FROM abonne WHERE prenom='Chloe'));

-- 4. Afficher le titre des livres que Chloé n'a pas encore empruntés

SELECT titre FROM livre WHERE id_livre NOT IN(SELECT id_livre FROM emprunt WHERE id_abonne=(SELECT id_abonne FROM abonne WHERE prenom='Chloe'));

-- 5. Afficher le titre des livres que Chloé n'a pas encore rendus

SELECT titre FROM livre WHERE id_livre IN(SELECT id_livre FROM emprunt WHERE id_abonne IN(SELECT id_abonne FROM abonne WHERE prenom='Chloe') AND date_rendu IS NULL);

-- 6. Combien de livres Benoît a empruntés ?

SELECT COUNT(id_livre) FROM emprunt WHERE id_abonne =(SELECT id_abonne FROM abonne WHERE prenom='Benoit');

-- ******************
-- Jointure interne
-- ******************

--une jointure interne est une requête permettant de faire des relations entre différentes tables grâce aux champs en commun De plus elle permet de sélectionner (afficher) des champs qui proviennent de tables différentes dans les SELECT

-- Différence entre imbriquée et jointure : 
-- une jointure est possible dans tous les cas alors qu'une requête imbriquée n'est possible seulement si l'affichage de donné ne provient que d'une seule et même table.
-- la requête imbriquée est plus rapide que la jointure. Lorsqu'elle est possible, la requête imbriquée est préférable (surtout applications au Big Data)

-- Afficher les dates de rendu et de sorti et le prénom pour l'abonné qui s'appelle Guillaume :

SELECT a.prenom, e.date_sortie, e.date_rendu
FROM abonne a
INNER JOIN emprunt e
ON a.id_abonne = e.id_abonne
WHERE a.prenom = 'Guillaume';

-- 1e ligne : ce que je veux afficher
-- 2e ligne : la premiere table d'ou proviennent les informations
-- 3e ligne : la seconde table d'où proviennent les informations
-- 4e ligne : la jointure qui lie les 2 champs en commun dans les 2 tables
-- 5e ligne : la condition complémentaire éventuelle ici le prénom

-- "a" et "e" s'appellent des alias de tables. Ils sont définis par FROM et INNER JOIN après le nom de la table à laquelle ils appartiennent.

-- a.prenom --> table.champs


-- *********************
-- Exercices
-- *********************
-- 1. Afficher le titre, date de sortie et date de rendu des livres écrits par Alphonse Daudet.

SELECT l.titre, e.date_sortie, e.date_rendu
FROM livre l
INNER JOIN emprunt e
ON l.id_livre=e.id_livre
WHERE =l.auteur='Alphonse Daudet';

-- 2. Afficher qui (prénom) a emprunté "Une vie" sur 2011.

SELECT a.prenom
FROM abonne a
INNER JOIN emprunt e
ON a.id_abonne=e.id_abonne
INNER JOIN livre l
ON l.id_livre=e.id_livre
WHERE l.titre='une vie' AND e.date_sortie LIKE '2011%';

-- 3. Afficher le nombre de livres empruntés par chaque abonné (prénom).

SELECT COUNT(e.id_livre), a.prenom
FROM emprunt e
INNER JOIN abonne a
ON a.id_abonne=e.id_abonne
GROUP BY prenom;

-- 4. Afficher qui (prénom) a emprunté quels livres (titre) et à quelles dates (date de sortie).

SELECT a.prenom, l.titre, e.date_sortie
FROM abonne a
INNER JOIN emprunt e
ON a.id_abonne=e.id_abonne
INNER JOIN livre l
ON e.id_livre=l.id_livre;


-- *********************
-- Jointure externe
-- *********************

--Une jointure externe est une requête sans correspondace exigée entre les valeurs des requêtes dans les différentes tables. Par exempl, vous vous insérez en abonné mais vous n'avez rien emprunté, avec une jointure interne vous n'apparaitrez pas. 
--En revanche, avec une jointure externe, vous apparaitrez avec la mention NULL pour les emprunts

--on s'ajoute en abonné dans la bibliothèque
INSERT INTO abonne (prenom) VALUES ('antoine');

SELECT a.prenom, e.id_livre
FROM abonne a
INNER JOIN emprunt e
ON a.id_abonne=e.id_abonne;

+-----------+----------+
| prenom    | id_livre |
+-----------+----------+
| Guillaume |      100 |
| Benoit    |      101 |
| Chloe     |      100 |
| Laura     |      103 |
| Guillaume |      104 |
| Benoit    |      105 |
| Chloe     |      105 |
| Benoit    |      100 |
+-----------+----------+

--Afin d'apparaître dans le listing abonné emprunt, nous allons effectuer une jointure externe
SELECT a.prenom, e.id_livre
FROM abonne a LEFT JOIN emprunt e --le join dépend de l'ordre dans lequel on les déclare dans le FROM
ON a.id_abonne=e.id_abonne;

+-----------+----------+
| prenom    | id_livre |
+-----------+----------+
| Guillaume |      100 |
| Benoit    |      101 |
| Chloe     |      100 |
| Laura     |      103 |
| Guillaume |      104 |
| Benoit    |      105 |
| Chloe     |      105 |
| Benoit    |      100 |
| antoine   |     NULL |
+-----------+----------+

DELETE FROM livre WHERE id_livre=100;

-- Exercice :
-- 1° Afficher la liste des emprunts (id_emprunt) avec le titre des livres qui existent encore.

SELECT e.id_emprunt, l.titre
FROM emprunt e
INNER JOIN livre l
ON e.id_livre=l.id_livre;

-- 2° Afficher la liste de TOUS les emprunts avec le titre des livres, y compris les emprunts pour lesquels il n'y a plus de livre en bibliothèque.

SELECT e.id_emprunt, l.titre
FROM emprunt e LEFT JOIN livre l
ON l.id_livre=e.id_livre;


-- *********************
-- UNION
-- *********************

-- UNION permet de fusionner 2 requêtes dans un même résultat. Pour cela il faut que les 2 requêtes aient le même SELECT (données d'affichage demandées) et ces mêmes SELECT dans le même ordre.

-- Exemple: si on désinscrit Guillaume, on peut à la fois TOUS les livres empruntés, y compris par les lecteurs désinscrits
--(guillaume) et TOUS les abonnés, y compris  ceux qui n'ont rien emprunté (VOUS)

-- On supprime Guillaume

DELETE FROM abonne WHERE prenom='guillaume';
(
SELECT a.prenom, e.id_livre
FROM abonne a LEFT JOIN emprunt e
ON a.id_abonne=e.id_abonne
)
UNION
(
SELECT a.prenom, e.id_livre
FROM abonne a RIGHT JOIN emprunt e
ON a.id_abonne=e.id_abonne
);