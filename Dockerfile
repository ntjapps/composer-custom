# Base pinned by digest (multi-arch index): `docker buildx imagetools inspect composer:latest`, copy the top-level "Digest:".
# Dependabot (docker, target dev) opens a PR when the digest moves. PECL extensions and the Laravel installer are version-pinned.
FROM composer:latest@sha256:0c8e663f14c94d07b3c45b175c51f5a14718508f21fe4dd7e54f09488dd0ed71

# Install Postgres Database Extension and PECL Redis extension
RUN apk --no-cache update && apk --no-cache upgrade && \
    apk --no-cache add pcre-dev zlib-dev libmemcached-dev ${PHPIZE_DEPS} && \
    pecl install redis-6.3.0 memcached-3.4.0 && \
    docker-php-ext-enable redis memcached && \
    apk --no-cache add postgresql-dev && \
    docker-php-ext-install pdo_pgsql && \
    apk del pcre-dev ${PHPIZE_DEPS} && \
    composer global require laravel/installer:5.33.0

# Check composer version as a test
RUN composer --version
