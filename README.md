# TesteTecnico
# DigioStore

## Visão Geral

O **DigioStore** é um aplicativo de exemplo que exibe uma loja fictícia com banners de destaques, produtos e uma funcionalidade de "cashback". Ele foi construído utilizando arquitetura MVC com foco em modularidade e testes unitários.

## Arquitetura

O aplicativo segue a arquitetura **MVC (Model-View-Controller)**:
- **Model:** Contém as estruturas de dados principais, como `DigioStore`, `Product`, `Spotlight` e `Cash`.
- **View:** Inclui as interfaces de usuário, implementadas em `UIViewController` e `UITableViewCell`.
- **Controller:** Controladores que gerenciam a lógica entre as Views e Models, como o `DigioStoreViewController`.

## Dependências

Nenhuma biblioteca externa foi utilizada neste projeto.

## Decisões de Implementação

- **Estrutura do Projeto:** Decidi utilizar MVC devido à sua simplicidade e adequação a projetos pequenos e médios.
- **Manutenção de Estado:** O estado da aplicação, como os dados da loja, é mantido dentro dos controladores principais, com suporte a injeção de dependências para facilitar o teste unitário.
- **Testes Unitários:** Implementei testes para garantir que os dados são corretamente carregados e exibidos nas células apropriadas.
- **Tratamento de Erros:** Utilizei uma extensão para exibir alertas em caso de falhas no carregamento de dados.

## Testes Unitários

Os testes foram escritos para garantir:
- A correta configuração das células na tabela.
- A correta manipulação e exibição dos dados do modelo.
- O tratamento apropriado de falhas de carregamento de dados.

## Como Executar o Projeto

1. Clone o repositório.
2. Abra o projeto no Xcode.
3. Selecione o destino (iPhone Simulator ou dispositivo físico).
4. Execute o projeto (`Cmd + R`).

## Como Executar os Testes

1. Selecione o esquema de testes no Xcode.
2. Execute os testes (`Cmd + U`).

## Swiftlint

1. [Swiftlint](https://github.com/realm/swiftlint?tab=readme-ov-file#swift-package-projects)

## Justificativa para Uso de Bibliotecas

Nenhuma biblioteca externa foi utilizada neste projeto, focando em uma implementação nativa e direta das funcionalidades necessárias.

---

Se precisar de mais alguma informação ou ajustes adicionais, é só me avisar!

