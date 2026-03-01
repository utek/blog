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
- **Content format:** Markdown (.md)
- **Theme:** Custom Bootstrap 3 theme (`themes/uteks/`)
- **Templating:** Jinja2
- **Build/deploy automation:** Fabric
- **Analytics:** Google Analytics

## Project Structure

```
content/          Blog posts (.md files)
themes/uteks/     Custom theme (templates, CSS, JS, fonts)
fabfile.py        Fabric build and deployment tasks
pelicanconf.py    Development configuration
publishconf.py    Production configuration
```

## Prerequisites

- Python 3.10+
- [uv](https://docs.astral.sh/uv/)

## Setup

```bash
uv sync
```

## Usage

```bash
# Build the site (development)
uv run fab build

# Clean output and rebuild
uv run fab rebuild

# Start a local dev server at http://localhost:8000
uv run fab serve

# Build and serve in one step
uv run fab reserve

# Watch for changes and auto-regenerate
uv run fab regenerate
```

## License

Copyright Łukasz 'utek' Bołdys
