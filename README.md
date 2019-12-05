# Near MeSa

## Extras

- Configuração com o docker

```bash
# definir variáveis de ambiente
cp .env.example .env

# constuir containers
docker-compose build

# criar banco
docker-compose run web rails db:create

# rodar migration
docker-compose run web rails db:migrate

# rodar aplicação em background
docker-compose up -d
```

Acessar em `localhost:3000` ou `0.0.0.0:3000`
