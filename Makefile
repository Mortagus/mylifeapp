.PHONY: help install update cc warmup env \
db-url db-test-conn db-create db-drop db-reset schema-validate \
migrate migration-diff migration-status migration-prev migration-first \
lint-yaml lint-twig lint-container lint-schema security-audit \
test prepare-dev prepare-test quality

# Variables
PHP        ?= php
CONSOLE    ?= $(PHP) bin/console
COMPOSER   ?= composer
ENV        ?= dev

# Si tu utilises Docker, décommente et adapte:
# DOCKER    ?= docker compose exec -T php
# CONSOLE   ?= $(DOCKER) php bin/console
# PHP       ?= $(DOCKER) php
# COMPOSER  ?= $(DOCKER) composer

.DEFAULT_GOAL := help

help: ## Affiche l’aide
	@echo "Cibles Make disponibles :"
	@awk 'BEGIN {FS":.*?## "}; /^[a-zA-Z0-9_%-]+:.*?## / {printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

# -------------------------
# Environnement & maintenance
# -------------------------
install: ## Installe les dépendances Composer
	$(COMPOSER) install

update: ## Met à jour les dépendances Composer
	$(COMPOSER) update

cc: ## Vide le cache Symfony (ENV=$(ENV))
	$(CONSOLE) cache:clear --env=$(ENV)

warmup: ## Chauffe le cache Symfony (ENV=$(ENV))
	$(CONSOLE) cache:warmup --env=$(ENV)

env: ## Affiche l’environnement courant
	@echo "ENV=$(ENV)"

# -------------------------
# Base de données & Doctrine
# -------------------------
db-url: ## Affiche la DSN de connexion
	$(CONSOLE) debug:container --env-var=DATABASE_URL

db-test-conn: ## Vérifie la connexion DB (essaie une requête simple)
	$(CONSOLE) dbal:run-sql "SELECT 1" --env=$(ENV)

db-create: ## Crée la base si absente
	$(CONSOLE) doctrine:database:create --if-not-exists --env=$(ENV)

db-drop: ## Supprime la base
	$(CONSOLE) doctrine:database:drop --force --env=$(ENV)

db-reset: ## Reset DB = drop + create
	$(MAKE) db-drop ENV=$(ENV) || true
	$(MAKE) db-create ENV=$(ENV)

schema-validate: ## Valide le mapping et la synchro schéma
	$(CONSOLE) doctrine:schema:validate --skip-sync --env=$(ENV)
	$(CONSOLE) doctrine:schema:validate --no-mapping --env=$(ENV) || true
	$(CONSOLE) doctrine:schema:validate --env=$(ENV)

migrate: ## Exécute les migrations
	$(CONSOLE) doctrine:migrations:migrate --no-interaction --env=$(ENV)

migration-diff: ## Génère une nouvelle migration à partir des entités
	$(CONSOLE) make:migration --env=$(ENV)

migration-status: ## Affiche l’état des migrations
	$(CONSOLE) doctrine:migrations:status --env=$(ENV)

migration-prev: ## Revient à la migration précédente
	$(CONSOLE) doctrine:migrations:migrate prev --no-interaction --env=$(ENV)

migration-first: ## Revient à la première version (vide)
	$(CONSOLE) doctrine:migrations:migrate first --no-interaction --env=$(ENV)

# -------------------------
# Qualité & outils dev
# -------------------------
lint-yaml: ## Lint YAML
	$(CONSOLE) lint:yaml config --parse-tags

lint-twig: ## Lint Twig
	$(CONSOLE) lint:twig templates

lint-container: ## Vérifie le container DI
	$(CONSOLE) lint:container

lint-schema: ## Alias rapide pour la validation Doctrine
	$(MAKE) schema-validate ENV=$(ENV)

security-audit: ## Audit de sécurité Composer
	$(COMPOSER) audit || true

# -------------------------
# Tests
# -------------------------
test: ## Lance la suite de tests (PHPUnit)
	$(PHP) ./vendor/bin/phpunit

# -------------------------
# Cibles composées utiles
# -------------------------
prepare-dev: ## Setup dev: install deps, clear cache, DB create, migrate
	$(MAKE) install
	$(MAKE) cc ENV=dev
	$(MAKE) db-create ENV=dev
	$(MAKE) migrate ENV=dev

prepare-test: ## Setup test: install deps, reset DB test, migrate
	$(MAKE) install
	$(MAKE) db-reset ENV=test
	$(MAKE) migrate ENV=test

quality: ## Lints + audit
	$(MAKE) lint-yaml
	$(MAKE) lint-twig
	$(MAKE) lint-container
	$(MAKE) security-audit
