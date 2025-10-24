# SecurityModule/Application

Ce dossier contient la couche Application du module, où résident les cas d’usage (orchestration), indépendants des détails techniques (HTTP, Doctrine, Twig).

- Command/ : commandes d’écriture (ex: CréerUtilisateur, ChangerMotDePasse, PromouvoirUtilisateur).
- Handler/ : gestionnaires qui exécutent les Command/Query en orchestrant les services de domaine et repositories.
- DTO/ : objets de transport de données pour valider/porter les entrées/sorties des cas d’usage.
- Query/ : requêtes de lecture (ex: RechercherUtilisateurParEmail, ListerUtilisateurs).

Règles:
- Pas de logique d’infrastructure (pas d’ORM, pas de HTTP).
- Dépend du Domaine via interfaces; l’Infrastructure injecte les implémentations.
- Code testable facilement et réutilisable depuis Web, CLI ou API.
