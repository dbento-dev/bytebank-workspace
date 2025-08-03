# Bytebank - Workspace de Micro-Frontends

Este é o **workspace** central para o projeto Bytebank, desenvolvido como parte da pós-graduação em Front-End Engineering da FIAP! 🚀

Este repositório utiliza **npm Workspaces** e **Docker Compose** para orquestrar um ambiente de desenvolvimento completo baseado em uma arquitetura de **Micro-Frontends** com **Webpack Module Federation**.

---

### ✅ Status do projeto

🚧 Workspace 🚀 Em construção... 🚧

---

### ❗ Sobre o Projeto

O `bytebank-workspace` é o ponto de partida para configurar e executar toda a aplicação Bytebank. Ele é responsável por:

- **Gerenciar o Ambiente**: Centraliza a configuração e os scripts para rodar todos os projetos de forma integrada.
- **Orquestração com Docker**: Utiliza `docker-compose` para construir e executar cada micro-frontend e pacote utilitário em seu próprio contêiner, simplificando o setup do ambiente de desenvolvimento.
- **Clonagem e Instalação**: Automatiza o processo de clonar todos os repositórios necessários e instalar as dependências de todos os projetos de uma só vez.

O objetivo é fornecer um ambiente de desenvolvimento robusto e fácil de gerenciar, onde cada parte da aplicação pode ser desenvolvida de forma independente, mas executada de forma coesa.

---

### 🏛️ Arquitetura

A aplicação é composta por uma aplicação **shell** (`root`) que carrega e integra dinamicamente os outros micro-frontends e pacotes compartilhados.

- **Aplicações (MFEs):**
  - `root`: A aplicação principal (host) que renderiza o layout e gerencia o roteamento.
  - `app-header`: O cabeçalho da aplicação.
  - `app-dashboard`: O painel principal com o saldo e informações do usuário.
  - `app-transactions`: A lista de transações.
- **Pacotes Utilitários:**
  - `util-ui`: Componentes de UI compartilhados (baseado em Material-UI).
  - `util-api`: Funções e hooks para comunicação com a API.
  - `util-store`: Lógica de estado global compartilhada (usando Zustand).

#### Layout da Aplicação

```text
+--------------------------------------------------+
|                 appHeader                        |
+--------------------------------+-----------------+
|                                |                 |
|         appDashboard           | appTransactions |
|                                |                 |
+--------------------------------+-----------------+
```

---

### 🛠️ Tecnologias

As tecnologias principais utilizadas para orquestrar o ambiente são:

- **Docker & Docker Compose**: Para containerizar e gerenciar os serviços.
- **npm Workspaces**: Para gerenciar as dependências do monorepo.
- **Bash Script**: Para automação do setup inicial.
- **Webpack (Module Federation)**: Utilizado dentro de cada projeto para a arquitetura de micro-frontends.
- **React.js & TypeScript**: A base de todos os projetos visuais.

---

### 🚀 Como rodar localmente

Com o Docker, você não precisa se preocupar em rodar cada projeto individualmente. O Docker Compose cuida de tudo!

#### Pré-requisitos

- **Git**
- **Node.js** e **npm**
- **Docker** e **Docker Compose**

#### Passos

1. **Clone este repositório:**

    ```bash
    git clone git@github.com:dbento-dev/bytebank-workspace.git
    cd bytebank-workspace
    ```

2. **Execute o script de setup:**
    Este script irá clonar todos os repositórios dos micro-frontends e utilitários para dentro da pasta `projects/` e instalar todas as dependências usando `npm workspaces`.

    ```bash
    npm run setup
    ```

3. **Inicie a aplicação com Docker Compose:**
    Este comando irá construir as imagens Docker para cada serviço (se ainda não existirem) e iniciar todos os contêineres.

    ```bash
    npm start
    ```

    A aplicação principal estará disponível em: **http://localhost:3000**

    > ✨ **Pronto!** Todos os micro-frontends e utilitários estarão rodando e se comunicando dentro da rede Docker.
    > ✨ **Para para uma experiência completa, é preciso executar o backend que está no repositório:** **[bytebank-api](https://github.com/dbento-dev/bytebank-api)**

---

### 📜 Scripts Disponíveis

- `npm run setup`: Prepara o ambiente, clonando os repositórios e instalando as dependências.
- `npm start`: Inicia todos os serviços usando `docker-compose up --build`.
- `npm run start:clean`: Reconstrói as imagens Docker sem usar cache e inicia os serviços. Útil quando há mudanças nos `Dockerfiles` ou dependências.
- `npm stop`: Para todos os contêineres em execução com `docker-compose down`.
- `npm run install-all`: Apenas instala/reinstala as dependências do workspace.
- `npm run nuke-all`: **CUIDADO!** Remove a pasta `projects`, `node_modules` e `package-lock.json` para uma limpeza completa do ambiente.

---

Feito com 💙 para fins educacionais.
