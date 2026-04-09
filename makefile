.PHONY: dev install lint test migrate dev-api dev-web dev-db stop-db

install:
	cd api && poetry install
	cd web && npm install

dev: dev-db
	@echo "Starting full-stack dev environment..."
	@npx concurrently -c "green,blue" -n "FASTAPI,NEXTJS" \
		"cd api && poetry run uvicorn core.app:api --reload" \
		"cd web && npm run dev"

dev-db:
	@echo "Starting database..."
	cd api/local_setup && docker compose up -d agent-database

stop-db:
	@echo "Stopping database..."
	cd api/local_setup && docker compose down

dev-api: dev-db
	cd api && poetry run uvicorn core.app:api --reload

dev-web:
	cd web && npm run dev

migrate:
	cd api && poetry run alembic upgrade head

lint:
	cd api && poetry run ruff check .
	cd web && npm run lint

test:
	cd api && poetry run pytest
	cd web && npm test