<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

# Sistem SPMI

Sistem standar penetapan mutu internal (SPMI) — a Laravel-based web application for managing internal quality assurance standards.

<p align="center">
  <a href="https://www.php.net/releases/8.4/en.php"><img src="https://img.shields.io/badge/PHP-%3E%3D8.4-777BB4?logo=php&logoColor=white" alt="PHP"></a>
  <a href="https://laravel.com"><img src="https://img.shields.io/badge/Laravel-13-FF2D20?logo=laravel&logoColor=white" alt="Laravel"></a>
  <a href="https://dev.mysql.com/doc/relnotes/mysql/8.4/en/"><img src="https://img.shields.io/badge/MySQL-8.4-4479A1?logo=mysql&logoColor=white" alt="MySQL"></a>
  <a href="https://vitejs.dev"><img src="https://img.shields.io/badge/Vite-8-646CFF?logo=vite&logoColor=white" alt="Vite"></a>
  <a href="https://tailwindcss.com"><img src="https://img.shields.io/badge/Tailwind_CSS-4-06B6D4?logo=tailwindcss&logoColor=white" alt="Tailwind CSS"></a>
  <a href="https://nodejs.org"><img src="https://img.shields.io/badge/Node.js-22-339933?logo=node.js&logoColor=white" alt="Node.js"></a>
  <a href="https://getcomposer.org"><img src="https://img.shields.io/badge/Composer-2-885630?logo=composer&logoColor=white" alt="Composer"></a>
  <a href="https://phpunit.de"><img src="https://img.shields.io/badge/PHPUnit-12-6B9F3B?logo=phpunit&logoColor=white" alt="PHPUnit"></a>
  <a href="https://www.docker.com"><img src="https://img.shields.io/badge/Docker-24+-2496ED?logo=docker&logoColor=white" alt="Docker"></a>
</p>

## Tech Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| Runtime | PHP | >= 8.4 |
| Framework | Laravel | 13 |
| Database | MySQL | 8.4 |
| Frontend | Vite + Tailwind CSS | 8 + 4 |
| Package Manager | Composer + npm | 2 |
| Testing | PHPUnit | 12 |

## Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) >= 24
- [Docker Compose](https://docs.docker.com/compose/install/) >= 2 (included with Docker Desktop)

### Quick Start

```bash
git clone <repo-url> && cd sistem-spmi

cp .env.example .env

docker compose up -d --build

docker compose exec app php artisan key:generate
docker compose exec app php artisan migrate
```

The application will be available at **http://localhost:8000**.

### Development

The `compose.yml` uses **no bind mounts**, so it runs on any Docker engine — Linux, macOS, or Windows (including Windows Docker daemons without WSL 2 or Docker Desktop). Source code and frontend assets are baked into the image at build time.

| Service | Purpose | Port |
|---------|---------|------|
| `app` | Laravel PHP application server | 8000 |
| `mysql` | MySQL 8.4 database | 3306 |

```bash
# Start everything
docker compose up -d --build

# Follow logs
docker compose logs -f

# Run artisan commands
docker compose exec app php artisan <command>

# Run tests
docker compose exec app php artisan test

# Open a shell inside the app container
docker compose exec app bash
```

> **Note:** Because there are no bind mounts, applying code or asset changes requires a rebuild. Layer caching makes this fast — only the changed steps re-run:
>
> ```bash
> docker compose up -d --build
> ```

### Database

The development stack uses **MySQL 8.4** by default. Connection details are configured in `.env`:

```
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=sistem_spmi
DB_USERNAME=laravel
DB_PASSWORD=password
```

To reset the database:

```bash
docker compose exec app php artisan migrate:fresh --seed
```

## Project Structure

```
sistem-spmi/
├── app/              # Application logic (Models, Http, Services)
├── bootstrap/        # Framework bootstrap
├── config/           # Configuration files
├── database/         # Migrations, factories, seeders
├── public/           # Web root (index.php, assets)
├── resources/        # Views, CSS, JS
├── routes/           # Route definitions
├── storage/          # Logs, cache, compiled views
├── tests/            # Unit & Feature tests
├── Dockerfile        # Multi-stage build (PHP 8.4 + Node 22)
└── compose.yml       # Docker Compose development stack
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for setup instructions and guidelines.
