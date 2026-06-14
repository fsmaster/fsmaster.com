# fsmaster.com

Source for **[fsmaster.com](https://fsmaster.com)** — the personal one-page site of
**Igor Marchuk**, Senior AIOps / L3 Cloud Support Engineer (San Jose, California).

A single, self-contained static page: dark, modern, responsive, built with
Tailwind (CDN) and Lucide icons. Sections: hero, about, expertise, certifications,
experience, projects, and contact.

## Structure

```
public/            # the deployable static site (web root)
  index.html       # the entire page
  assets/          # photo, favicons, web manifest, CV (PDF)
deploy/
  fsmaster.nginx   # nginx server block (TLS added by certbot)
  deploy.sh        # sync public/ to the web root and reload nginx
```

## Local preview

```bash
cd public && python -m http.server 8099
# open http://localhost:8099
```

## Deploy / redeploy

The site is served by host nginx from `/var/www/fsmaster`. On the server, from a
clone of this repo:

```bash
git pull
sudo ./deploy/deploy.sh
```

`deploy.sh` rsyncs `public/` into the web root, fixes ownership, validates the
nginx config, and reloads nginx. TLS certificates are managed by certbot and
renew automatically.

## License

© Igor Marchuk. Site content (text, photo, CV) is personal and not licensed for reuse.
