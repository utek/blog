# utek's thoughts

A personal technical blog built with [Pelican](https://getpelican.com/), a Python-based static site generator. The site is published at [dev.utek.pl](http://dev.utek.pl).

## Topics

Blog posts cover Python development, web technologies, databases, and tooling — written in reStructuredText:

- Python packaging and middleware
- JavaScript and interactive maps (OpenLayers)
- Database migrations (MSSQL, Alembic)
- Developer tools (PySeaWeed)

## Tech Stack

- **Static site generator:** Pelican
- **Content format:** reStructuredText (.rst)
- **Theme:** Custom Bootstrap 3 theme (`themes/uteks/`)
- **Templating:** Jinja2
- **Build/deploy automation:** Fabric
- **Comments:** Disqus
- **Analytics:** Google Analytics

## Project Structure

```
content/          Blog posts (.rst files)
themes/uteks/     Custom theme (templates, CSS, JS, fonts)
fabfile.py        Fabric build and deployment tasks
pelicanconf.py    Development configuration
publishconf.py    Production configuration
```

## Prerequisites

- Python 2.7+
- [Pelican](https://getpelican.com/)
- [Fabric](https://www.fabfile.org/)

```
pip install pelican fabric
```

## Usage

```bash
# Build the site (development)
fab build

# Build with production settings (enables feeds)
fab preview

# Clean output and rebuild
fab rebuild

# Start a local dev server at http://localhost:8000
fab serve

# Build and serve in one step
fab reserve

# Watch for changes and auto-regenerate
fab regenerate
```

## License

Copyright Łukasz 'utek' Bołdys
