# My Life App
Le titre est provisoire.
Il s'agit d'un projet personnel, qui me permet de mettre en oeuvre plusieurs idées de développement que j'ai en tête depuis longtemps.

La version originale de ce document est datée du 19 octobre 2025.

J'ai envie de pouvoir fournir un site web avec des parties publiques: une représentation de ma carrière et des petits projets fun.
J'aimerais également mettre en place des parties privées accessibles uniquement pas moi.

C'est aussi un terrain de jeu, afin de m'incité à apprendre de nouvelles librairies/outils tout en développant quelque chose d'utile pour moi.

## Sommaire
- [Contexte](#contexte)
- [Objectifs](#objectifs)
- [Périmètre](#périmètre)
- [Public cible / Personae](#public-cible--personae)
- [Architecture et technologies](#architecture-et-technologies)
- [Organisation du code](#organisation-du-code)
- [Déploiement](#déploiement)
- [Observabilité / Monitoring](#observabilité--monitoring)
- [Licence](#licence)

## Contexte
### Problème adressé
Je suis sur le point de devenir indépendant à titre complémentaire.
Je suis développeur depuis ma sortie de mes études en 2010 et spécialisé dans le développement web depuis 2011.

Durant ma carrière et ma vie de manière générale, j'ai développé plusieurs intérêts personnels et j'aimerais créer une application qui les rassemble.

### Parties prenantes
Cette application n'a pas pour but d'être commercialisée.
C'est une rassemblement d'outils pour ma vie personnelle et professionnelle.

### Contraintes (techniques, légales, délais)
Il n'y a pas de contraintes techniques particulières.
Il s'agit pour le moment d'une application web construite en PHP 8.4+, autour du framework Symfony 7.3+.

## Objectifs
### Objectif principal
Rassembler un ensemble d'outils pour ma vie personnelle et professionnelle.
Chaque outil sera développé indépendamment les uns des autres.
Chaque outil sera accessible depuis une interface web.

### Objectifs secondaires
Me permettre d'utiliser des nouveaux outils, de pratiquer mon métier dans un environnement contrôler par mes soins.

## Périmètre
### Inclus
- Modules personnels/pro: catalogue d’outils indépendants (ex: gestion de tâches, suivi financier perso, journal technique, bookmarks, suivi sport, générateur de devis/factures).
- Accès via une même interface web avec navigation commune.
- Authentification simple utilisateur unique.
- Stockage local des données (DB unique).
- Déploiement self-hosted.

### Exclusions
- Multi-tenant, comptes multiples ou rôles avancés.
- SLA/haute disponibilité/scale-out.
- Paiements en ligne, obligations légales de facturation.
- Apps mobiles natives (responsive web seulement).
- Internationalisation complète (français uniquement au départ).
- Support client ou publication publique.

### Hypothèses de périmètre
- Les modules peuvent évoluer indépendamment et être activés/désactivés.
- Cohérence UI/UX minimale commune (navigation, thème).
- Sécurité “raisonnable” pour usage perso (mots de passe forts, HTTPS).
- Intégrations externes opportunistes, non critiques (APIs facultatives).

## Public cible / Personae
Cette application web est destinée qu'à mon propre usage personnel.

## Modules clés
- [Module 1] Ma visibilité en tant que développeur professionnel indépendant
  - visibilité publique
  - CV publique + Portfolio (si possible)
  - Gestion des plateformes de présence en ligne (ex: LinkedIn, ICTJobs, ...)
- [Module 2] Mon activité de coach en programmation
  - visibilité publique
  - CV
  - Liste des participants (élèves ou mentorés)
  - Suivi des sessions de travails par élève dans le temps
  - Génération de récapitulatifs de sessions
  - Génération de devis/factures
  - Gestion des rendez-vous dans le calendrier avec les participants
- [Module 3] Ma santé
  - visibilité privée
  - suivi du poids
  - suivi de mon activité physique
  - contact de médecins
  - mon couverture assurance santé
  - Suivi de ma thérapie
- [Module 4] Mes finances
  - visibilité privée
  - Suivi de mes dépenses et revenus
- [Module 5] Ma vie sociale
  - visibilité privée
  - Suivi de mes contacts
  - Aide à la prise de contact régulière avec mes contacts (roue de sélection aléatoire en fonction du contact)
- [Module 6] Jeux JS
  - visibilité publique
  - Expérimentations en JS
  - Pratique de mes compétences en développement orienté sur le jeu

## Architecture et technologies
- Type d’application: monorepo
- Pile technologique envisagée
  - Framework: Symfony 7.3+
  - Frontend: HTML/CSS/JS via des templates Twig
  - Langage: PHP 8.4+
  - Base de données: PostgreSQL 16+
  - Infrastructure: Docker
  - Tests: PHPUnit

## Organisation du code
- Structure des dossiers: Symfony 7 avec répartition en modules. Un module = un "feature directory"
- Conventions de nommage: Bonnes pratiques PHP 8 (voir: www.php-fig.org et https://symfony.com/doc/current/contributing/code/standards.html)
- Formatage du code: PHP-CS-Fixer
- Gestion des dépendances: Composer
- Scripts utiles: make, composer, bin/console, Dockerfile et docker-compose.yml

## Déploiement
- Environnements: dev, test et prod
- Stratégie de déploiement: manuel dans un premier temps. Peut-être automatisé plus tard
- Variables d’environnement / secrets
- Rollback

## Observabilité / Monitoring
- Stack: Monolog + rotation

## Sécurité
- Authentification: login/password hashé (bcrypt/argon2id), éventuellement 2FA plus tard.
- TLS obligatoire, gestion des cookies (SameSite, Secure).
- Mises à jour régulières Composer (audit composer audit).
- Politique des secrets (dotenv-vault/secrets manager, jamais en repo).

## Licence
Licence MIT classique : code open source, pas de frais de licence.
Les données privées restent dans l'application et ne sont exploitée que par l'application pour son fonctionnement.
Usage personnel uniquement.
Certain modules publierons des données publiques (ex: CV, portfolio, ...).
Aucune données personnelles, en dehors des miennes, ne sera publiée.
