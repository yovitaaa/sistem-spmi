# ─────────────────────────────────────────────────────────────
#  Multi-stage Dockerfile — Laravel 13 / PHP 8.4
# ─────────────────────────────────────────────────────────────

# ── Stage 1: Build frontend assets (Vite + Tailwind CSS) ────
FROM node:22-alpine AS node-build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

COPY vite.config.js ./
COPY resources/ resources/
RUN npm run build


# ── Stage 2: Install PHP dependencies ────────────────────────
FROM composer:2 AS composer-install

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install \
        --no-dev \
        --no-interaction \
        --no-scripts \
        --no-autoloader \
        --prefer-dist

COPY . .
RUN composer dump-autoload --optimize --no-dev


# ── Stage 3: Final PHP runtime image ─────────────────────────
FROM php:8.4-cli AS runtime

# System dependencies required by PHP extensions & runtime
RUN apt-get update && apt-get install -y --no-install-recommends \
        git \
        unzip \
        libzip-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        libonig-dev \
        libxml2-dev \
        libcurl4-openssl-dev \
        libssl-dev \
    && docker-php-ext-configure gd \
        --with-jpeg \
        --with-freetype \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        dom \
        gd \
        mbstring \
        pdo_mysql \
        simplexml \
        xml \
        zip \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# Install Redis extension (optional, for queue/cache in production)
RUN pecl install redis && docker-php-ext-enable redis

WORKDIR /app

# Copy Composer artifacts from composer-install stage
COPY --from=composer-install /app/app/ app/
COPY --from=composer-install /app/vendor/ vendor/
COPY --from=composer-install /app/public/ public/
COPY --from=composer-install /app/artisan ./
COPY --from=composer-install /app/bootstrap/ bootstrap/
COPY --from=composer-install /app/config/ config/
COPY --from=composer-install /app/database/ database/
COPY --from=composer-install /app/routes/ routes/
COPY --from=composer-install /app/storage/ storage/
COPY --from=composer-install /app/resources/ resources/
COPY --from=composer-install /app/composer.json ./

# Copy built frontend assets from node-build stage
COPY --from=node-build /app/public/build/ public/build/

# Bake environment file (compose intentionally uses no env_file /
# bind mounts so the stack runs on any Docker engine)
COPY --from=composer-install /app/.env.example .env

# Create non-root user for security
RUN groupadd -g 1000 -r app && \
    useradd -g 1000 -r -d /app -s /bin/bash app && \
    chown -R app:app /app

USER app

EXPOSE 8000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
