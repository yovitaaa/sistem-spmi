# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **Database infrastructure migrations** — restored the standard Laravel skeleton migrations missing from the custom migration set: `cache`/`cache_locks`, `jobs`/`job_batches`/`failed_jobs`, and `sessions` tables (required by the database-backed `SESSION_DRIVER`, `CACHE_STORE`, and `QUEUE_CONNECTION` settings).
- `CONTRIBUTING.md` — contribution guidelines covering Docker and non-Docker workflows, coding standards, and testing.
- `CHANGELOG.md` — this file.

### Changed

- **PHP upgraded from 8.3 to 8.4** — `composer.json` requires `^8.4`, Dockerfile uses `php:8.4-cli`.
- **Database switched from SQLite to MySQL 8.4** — `.env.example` defaults to `DB_CONNECTION=mysql` with `mysql` host.
- **`Dockerfile`** — replaced `pdo_sqlite` with `pdo_mysql` extension; removed SQLite-specific configuration.
- **`compose.yml`** — rewritten as a flat development stack (no profiles); all services start together by default. Later rewritten again to be **bind-mount-free** for compatibility with any Docker engine (including Windows daemons without WSL 2): source code and assets are baked into the image, only `mysql-data` uses a named volume, and the `node` service was removed (assets build at image build time).
- **`Dockerfile`** — bakes `.env` from `.env.example` into the image so Laravel is configured without host bind mounts or `env_file`.
- **`README.md`** — completely rewritten; removed all default Laravel boilerplate (About, Learning Laravel, Agentic Development sections); now documents project-specific stack, setup, and usage, plus the rebuild-based change workflow.
- **`CONTRIBUTING.md`** — updated setup instructions to reflect MySQL-based development environment and PHP 8.4 requirement.
- **`.dockerignore`** — updated to exclude `tests/` directory, PowerShell scripts, and backup files from build context.

## [0.1.0] - 2026-08-31

### Initial Release

- Sistem SPMI application scaffold (Laravel 13, PHP 8.3).
- Frontend build pipeline (Vite 8, Tailwind CSS 4).
- SQLite as default database with database-backed sessions, cache, and queue.
- PHPUnit 12 test suite (Unit + Feature).
- Docker support with multi-stage build, Nginx, MySQL (profile-based), and Node dev server (profile-based).
