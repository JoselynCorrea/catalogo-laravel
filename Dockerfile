FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git unzip curl libzip-dev libonig-dev libpng-dev libpq-dev \
    && docker-php-ext-install pdo pdo_mysql zip


COPY --from=composer:2 /usr/bin/composer /usr/bin/composer


WORKDIR /var/www/html

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 80

CMD php artisan serve --host=0.0.0.0 --port=80
