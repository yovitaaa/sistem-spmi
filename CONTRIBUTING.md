# Contributing

Thank you for considering contributing to this project! This document outlines the process and guidelines for contributing.

## Getting Started

### Using Docker (Recommended)

The fastest way to get a working development environment:

```bash
git clone <repo-url> && cd sistem-spmi
cp .env.example .env
docker compose up -d --build
docker compose exec app php artisan key:generate
docker compose exec app php artisan migrate
```

The application will be available at `http://localhost:8000`. The stack uses no bind mounts and works on any Docker engine. After making code changes, apply them with `docker compose up -d --build`.

### Without Docker

**Requirements:** PHP >= 8.4, Node.js >= 22, Composer >= 2, MySQL >= 8.4

```bash
composer install
cp .env.example .env
php artisan key:generate
npm install && npm run build
php artisan migrate
composer dev
```

## Development Workflow

1. **Fork and clone** the repository
2. **Create a branch** from `main` for your feature or fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** following the coding standards below
4. **Write or update tests** for your changes
5. **Run the test suite** to ensure nothing is broken:
   ```bash
   docker compose exec app php artisan test
   ```
6. **Run the linter** to check code style:
   ```bash
   docker compose exec app ./vendor/bin/pint
   ```
7. **Commit** with a clear, descriptive message
8. **Push** your branch and open a Pull Request

## Coding Standards

- Follow [PSR-12](https://www.php-fig.org/psr/psr-12/) coding style for PHP
- Use [Laravel Pint](https://laravel.com/docs/pint) for automated style fixes
- Write meaningful commit messages
- Keep commits focused and atomic
- Add or update tests for new features or bug fixes

## Testing

This project uses **PHPUnit 12** for testing:

```bash
# Run all tests
docker compose exec app php artisan test

# Run a specific test suite
docker compose exec app php artisan test --testsuite=Unit
docker compose exec app php artisan test --testsuite=Feature

# Run a specific test file
docker compose exec app php artisan test tests/Unit/ExampleTest.php
```

When writing tests:
- Place unit tests in `tests/Unit/`
- Place feature/integration tests in `tests/Feature/`
- Use factories from `database/factories/` for test data
- Aim for meaningful coverage, not just high percentages

## Pull Request Guidelines

- Provide a clear and descriptive title
- Describe what your changes do and why
- Reference any related issues (e.g., `Closes #123`)
- Ensure all tests pass
- Keep PRs focused on a single concern
- Update documentation if your changes affect usage

## Reporting Bugs

- Use the GitHub issue tracker
- Include steps to reproduce the bug
- Include your environment details (OS, PHP version, Docker version if applicable)
- Include relevant logs or error messages

## Code of Conduct

Be respectful and constructive in all interactions. We are committed to providing a welcoming and inclusive experience for everyone.
