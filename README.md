## OpenCATS (Docker Compose)

This repository provides a simple Docker Compose setup to run **OpenCATS** locally (Apache+PHP + MariaDB).

### Prerequisites

- Docker + Docker Compose (the `docker compose` command)
- Git

### Quick start

1) Create a local `.env` file:

```bash
cp .env.example .env
```

2) Bootstrap OpenCATS source + config (clones OpenCATS into `./opencats/`):

```bash
./scripts/setup_opencats
```

3) Start OpenCATS:

```bash
docker compose up -d --build
```

4) Open:

- OpenCATS: `http://localhost:${OPENCATS_HTTP_PORT:-8080}`

### Stop

```bash
docker compose down
```

### Notes

- OpenCATS source is cloned into `./opencats/` (ignored by git).
- Database data is stored in the Docker volume `opencats_db_data`.
- If you change DB credentials in `.env`, re-run `./scripts/setup_opencats` to regenerate `opencats/config.php`.