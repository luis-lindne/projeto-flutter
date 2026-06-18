# Projeto Flutter

Aplicativo Flutter para dispositivos moveis com autenticacao de usuario, gerenciamento de sessao e consumo da API DummyJSON para listagem e manipulacao de produtos.

## Funcionalidades

### Autenticacao
- Login via POST em `https://dummyjson.com/auth/login`
- Validacao dos campos de usuario e senha no formulario
- Exibicao de mensagem de erro quando o login falha
- Sessao mantida em memoria com token e dados do usuario autenticado
- Acesso a tela de produtos bloqueado para usuarios nao autenticados
- Nome do usuario exibido na barra superior da tela principal
- Botao de logout com encerramento da sessao

### Produtos
- Consulta de produtos via GET em `https://dummyjson.com/products`
- Modelo `Product` mapeado para o formato de resposta da DummyJSON
- Listagem com titulo, preco e imagem de cada produto
- Tela de detalhes exibindo nome, preco, descricao, categoria, avaliacao e imagens
- Cadastro de novo produto via POST em `/products/add`
- Edicao de produto existente via PUT em `/products/{id}`
- Exclusao de produto com confirmacao via DELETE em `/products/{id}`

### Navegacao e interface
- Transicao entre telas com `Navigator.push` e retorno com `Navigator.pop`
- Favoritos locais com opcao de marcar e desmarcar produtos
- Atualizacao automatica da interface ao alterar favoritos
- Indicador de carregamento durante requisicoes
- Tratamento de erro com opcao de tentar novamente

## Credenciais de teste

| Campo  | Valor   |
|--------|---------|
| Usuario | `admin` |
| Senha   | `admin` |

O app trata essas credenciais como alias local e realiza a autenticacao na DummyJSON com o endpoint `/auth/login`.

## Estrutura do projeto

```
lib/
  models/
    authenticated_user.dart
    product.dart
  providers/
    product_provider.dart
    session_provider.dart
  screens/
    auth_gate.dart
    login_screen.dart
    product_detail_screen.dart
    product_form_screen.dart
    product_list_screen.dart
  services/
    auth_service.dart
    product_service.dart
  widgets/
    product_card.dart
    product_form_field.dart
```

## Gerenciamento de estado

O projeto utiliza o pacote `Provider` com `ChangeNotifier`. A escolha se justifica pelo escopo objetivo da aplicacao: uma sessao de usuario e uma lista de produtos compartilhada entre poucas telas.

- **SessionProvider** — controla login, usuario autenticado e logout.
- **ProductProvider** — controla carregamento, erros, listagem, cadastro, edicao, exclusao e favoritos de produtos.

## Como executar

```bash
flutter pub get
flutter run
```

## Verificacao

```bash
flutter analyze
```
