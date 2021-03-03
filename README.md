# twt-tools

Tools for twtxt that don't suck

## Presentation

twt-tools is a set of 3 scripts covering the use of [twtxt](https://github.com/buckket/twtxt):

- **twtsrv**: script run by your webserver used to update your twtxt file through a REST API
- **twtpub**: publishing script (twtssrv client)
- **twtsub**: subscription script (you can follow people with it)

## Installation

### twtsrv

This script can be run with FastCGI using for example fcgiwrap.

Here is an exemple of nginx config:

```
server {
    listen 80;
    listen [::]:80;
    server_name exemple.com;

    root /var/www/twtxt;

    location ~ \.sh {
        fastcgi_pass  unix:/var/run/fcgiwrap.socket;
        include /etc/nginx/fastcgi_params;
        fastcgi_param SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    }
}
```

Don't forget to edit the script and set `secret` variable to a strong secret.

### twtpub

Copy and adapt [`twtpub.ini`](config-example/twtpub.ini) in `~/.config/twtxt/twtpub.ini`. You can have multiple feeds there if you want.

### twtsub

Copy and adapt [`twtsub.txt`](config-example/twtsub.txt) in `~/.config/twtxt/twtpub.txt`. Each subscription is on a separate line, the first item of the line is the name os the subscription, then a tab, then the URL to the twtxt.txt file.

