<?php /** @noinspection PhpUnused */

namespace App\SecurityModule\Domain\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;

#[ORM\Entity]
#[ORM\Table(name: 'users')]
#[ORM\HasLifecycleCallbacks]
class User implements UserInterface, PasswordAuthenticatedUserInterface
{
  #[ORM\Id]
  #[ORM\GeneratedValue]
  #[ORM\Column]
  private ?int $id = null {
    get {
      return $this->id;
    }
  }

  #[ORM\Column(length: 180, unique: true)]
  private string $email {
    get {
      return $this->email;
    }
  }

  #[ORM\Column(type: 'json')]
  private array $roles;

  #[ORM\Column]
  private string $password;

  #[ORM\Column(type: 'boolean', options: ['default' => true])]
  private bool $isActive = true;

  #[ORM\Column(type: 'datetime_immutable')]
  private \DateTimeImmutable $createdAt {
    get {
      return $this->createdAt;
    }
  }

  #[ORM\Column(type: 'datetime_immutable', nullable: true)]
  private ?\DateTimeImmutable $updatedAt = null {
    get {
      return $this->updatedAt;
    }
  }

  #[ORM\Column(type: 'datetime_immutable', nullable: true)]
  private ?\DateTimeImmutable $lastLoginAt = null {
    get {
      return $this->lastLoginAt;
    }
  }

  public function __construct(string $email)
  {
    $this->email = mb_strtolower($email);
    $this->roles = ['ROLE_USER'];
    $this->createdAt = new \DateTimeImmutable('now');
  }

  public function getUserIdentifier(): string
  {
    return $this->email;
  }

  public function renameEmail(string $email): self
  {
    $this->email = mb_strtolower($email);
    return $this;
  }

  public function getRoles(): array
  {
    // Garantit au minimum ROLE_USER
    $roles = $this->roles;
    if (!in_array('ROLE_USER', $roles, true)) {
      $roles[] = 'ROLE_USER';
    }
    return array_values(array_unique($roles));
  }

  public function setRoles(array $roles): self
  {
    $this->roles = array_values(array_unique($roles));
    return $this;
  }

  public function addRole(string $role): self
  {
    if (!in_array($role, $this->roles, true)) {
      $this->roles[] = $role;
    }
    return $this;
  }

  public function removeRole(string $role): self
  {
    $this->roles = array_values(array_filter($this->roles, static fn(string $r) => $r !== $role));
    return $this;
  }

  public function getPassword(): string
  {
    return $this->password;
  }

  // Le mot de passe doit être déjà hashé (via UserPasswordHasherInterface)
  public function setPassword(string $hashedPassword): self
  {
    $this->password = $hashedPassword;
    return $this;
  }

  public function isActive(): bool
  {
    return $this->isActive;
  }

  public function activate(): self
  {
    $this->isActive = true;
    return $this;
  }

  public function deactivate(): self
  {
    $this->isActive = false;
    return $this;
  }

  public function touchLastLogin(): self
  {
    $this->lastLoginAt = new \DateTimeImmutable('now');
    return $this;
  }

  public function eraseCredentials(): void
  {
    // Rien à effacer: pas de données sensibles temporaires stockées sur l'entité
  }

  #[ORM\PreUpdate]
  public function onPreUpdate(): void
  {
    $this->updatedAt = new \DateTimeImmutable('now');
  }

  /**
   * Accesseurs temporels
   */
  public function getCreatedAt(): \DateTimeImmutable
  {
    return $this->createdAt;
  }

  public function getUpdatedAt(): ?\DateTimeImmutable
  {
    return $this->updatedAt;
  }

  public function getLastLoginAt(): ?\DateTimeImmutable
  {
    return $this->lastLoginAt;
  }

  /**
   * Méthodes héritées mais non utilisées dans Symfony 6+/7+:
   * getSalt() n'est pas nécessaire lorsque l'algorithme moderne (bcrypt/argon2id) est utilisé.
   */
}
