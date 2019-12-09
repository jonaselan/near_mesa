# Near MeSa

[![Build Status](https://travis-ci.com/jonaselan/near_mesa.svg?branch=master)](https://travis-ci.com/jonaselan/near_mesa)

[LIVE DEMO](https://near-mesa.herokuapp.com/)

## Desenvolvimento

Sempre quando recebo um problema a ser resolvido, tento entender ao máximo o cenário em questão e a problemática. Acredito que com esses dois pontos, já ajuda muito a trazer uma boa solução. Então reservei algum tempo para ler o que foi descrito e imaginar cenários de testes, modelagem de banco, padrões, já identificando os pontos mais críticos para que eu tivesse um nível maior de atenção e possivelmente começar por eles.

## Detalhes Técnicos

- Como Não há é possivel saber a localização do usuário através de uma api, essa informação deve vir de outro lugar. Para solucionar isso, poderiamos como:

  - Permitir que o usuário só cadastre um local;
  - Permite que o usuário defina um local padrão dos quais ele já cadastrou;
  - Obter essa informação do front (através de algum serviço de geolocalização).

  Essa última foi a que achei que chegaria mais próximo da realidade e opitei por ela

- Optei por usar um service somente para ordenação, porque agora, estamos ordenando por mode, mas posteriormente poderá haver a ordenação de outras formas, e tudo em relação a isso será mantido dentro deste service
- Extrai a consulta usada para descobrir os pontos mais próximos dado uma cordenada foi deste [artigo do Google](https://developers.google.com/maps/solutions/store-locator/clothing-store-locator#creating-a-table-in-mysql).
- Isso não ficou explicito na descrição, mas adicionei uma condição que o usuário poderá visualizar unicamente o seu perfil
- Já faz um tempo que li que há alguns projetos que não testam mais controllers. O problema é que eles não testam a stack inteira. Eles apenas criam uma instância da classe do controller e acionam as actions. A recomendação é usar mais testes de models e requests. Esse último faz requisições reais para a aplicação e é testado apenas a saíde (e efeitos colaterais críticos, se necessário). Para o teste, fiz os testes de request apenas da autenticação, pois não sei se na Mesa é usado testes em controllers também.

## Documentação

### Api

A documentação foi feita no [Postman](https://web.postman.co/collections/8869351-abc40e98-67f0-4a7c-a711-1384e76b4468?version=latest&workspace=79760668-1ca1-4eda-88ad-277ed63375eb)

### Docker

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
