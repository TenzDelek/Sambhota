.PHONY: dev install lint test migrate dev-api dev-web dev-db

dev:
	$(MAKE) dev-api & $(MAKE) dev-web & wait

install:
	cd api && poetry install
	cd web && npm install

lint:
	cd api && poetry run ruff check .
	cd web && npm run lint

test:
	cd api && poetry run pytest
	cd web && npm test

migrate:
	cd api && poetry run alembic upgrade head

dev-api:
	cd api && poetry run uvicorn core.app:api --reload

dev-web:
	cd web && npm run dev

dev-db:
	cd api/local_setup && docker compose up agent-database
