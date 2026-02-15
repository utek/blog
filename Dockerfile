FROM python:3.14-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ruby \
    && gem install mdl --no-document \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

WORKDIR /app

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen

COPY . .

EXPOSE 8000

CMD ["uv", "run", "fab", "reserve"]
