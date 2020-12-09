#!/bin/sh

cd $DOCUMENT_ROOT

if [[ -f 'artisan' ]]; then
    echo "Scheduling tasks in $DOCUMENT_ROOT"
    php artisan schedule:run >> /dev/null 2>&1
else
    echo "No laravel project found"
fi;
