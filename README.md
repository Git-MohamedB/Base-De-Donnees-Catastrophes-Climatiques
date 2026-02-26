# Base de Donnees - Catastrophes Climatiques (SAE 1.04)

Ce projet est une implémentation de base de données relationnelle PostgreSQL visant à modéliser, stocker et analyser les données mondiales relatives aux catastrophes climatiques (inondations, sécheresses, tempêtes, etc.). 

## Objectif du Projet

L'objectif principal de ce projet est de transformer un jeu de données brut (fichier plat CSV) en une base de données relationnelle normalisée et optimisée. 

## Modele de Donnees (Schema Relationnel)

La base de données a été structurée pour éviter la redondance des données et garantir l'intégrité référentielle. Elle est composée des 5 tables suivantes :

* **region** : Les grandes régions du monde.
* **sub_region** : Les sous-régions, rattachées à une région mère.
* **country** : Les pays avec leurs codes ISO (ISO2, ISO3), rattachés à une sous-région.
* **disaster** : Le catalogue des types de catastrophes climatiques.
* **climate_disaster** : Table de liaison (faits) qui recense le nombre de catastrophes par pays, par type de catastrophe et par année.

## Fonctionnalites et Competences Demontrees

Ce dépôt met en évidence la maîtrise du langage SQL (PostgreSQL) à travers le script de peuplement :

* **Création de schéma** : Définition des tables avec typage rigoureux, SERIAL PRIMARY KEY, et contraintes de clés étrangères avec suppression en cascade (ON DELETE CASCADE).
* **Gestion des données brutes** : Utilisation d'une table temporaire (TEMP TABLE) pour accueillir les données non normalisées.
* **Importation de fichiers plats** : Utilisation de la commande \copy pour ingérer efficacement les données depuis un fichier CSV.
* **Normalisation des données** : Extraction et insertion intelligente des données vers les tables relationnelles en utilisant des requêtes complexes (INSERT INTO ... SELECT DISTINCT ... JOIN ...).

## Architecture du Depot

```text
/
 ├── peuplement.sql       # Script principal de création et d'insertion des données
 └── README.md            # Documentation du projet
