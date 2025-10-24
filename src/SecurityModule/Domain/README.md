# SecurityModule/Domain

Cette couche contient le cœur métier du module (indépendant de Symfony/HTTP/ORM).

- Entity/ : entités du domaine (ex: User, PasswordResetToken) avec invariants métier.
- Event/ : événements de domaine (ex: UserRegistered, PasswordChanged).
- Repository/ : interfaces de persistance (ex: UserRepositoryInterface).
- Service/ : services métier purs (ex: PasswordPolicy, DomainRules).
- ValueObject/ : valeurs immuables (ex: Email, HashedPassword, Role).

Règles:
- Aucune dépendance à l’infrastructure (pas de Doctrine, pas de contrôleurs).
- Les entités garantissent leurs invariants; les Services encapsulent des règles transverses.
- Les Repositories sont des interfaces; les implémentations vivent en Infrastructure.
