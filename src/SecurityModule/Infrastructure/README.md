# SecurityModule/Infrastructure

Couche d’adaptation technique: implémente les interfaces du domaine et expose le module via HTTP/Symfony.

- Doctrine/
  - Repository/ : implémentations concrètes des Repository du domaine (Doctrine ORM).
  - Entity/ : (optionnel) mappings séparés si vous ne mettez pas les attributs ORM dans le domaine.
  - Migration/ : (optionnel) migrations spécifiques; recommandé de centraliser dans le dossier migrations racine.
- Http/
  - Controller/ : contrôleurs Web (login, logout, compte, admin utilisateurs).
  - Request/ : (optionnel) objets de requête/validateurs spécifiques.
  - Route/ : (optionnel) définitions de routes si non gérées par attributs.
- Security/
  - Authenticator/ : authenticators (form, JSON, remember-me).
  - Voter/ : voters d’autorisation fine.
  - Provider/ : (optionnel) UserProvider custom si nécessaire.
- Template/ : vues Twig du module (utilisées via le namespace Twig du module).
- Service/ : adaptateurs techniques (ex: mailer, hashing custom) qui dépendent de Symfony/3rd parties.
- Assets/
  - css/, js/ : (optionnel) assets propres au module si vous avez un build (Encore/Vite).

Règles:
- Dépendances autorisées vers Symfony et librairies techniques.
- N’expose pas de logique métier nouvelle; respecte les contrats du domaine.
- Les contrôleurs orchestrent via la couche Application, pas directement le domaine quand c’est possible.
