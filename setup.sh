#!/bin/bash

# --- CONFIGURAÇÃO ---
REPOS=(
  # Shell (root app)
  "git@github.com:dbento-dev/bytebank-root.git"

  # MFEs
  "git@github.com:dbento-dev/bytebank-app-header.git"
  "git@github.com:dbento-dev/bytebank-app-dashboard.git"
  "git@github.com:dbento-dev/bytebank-app-transactions.git"

  # Pacotes compartilhados / utils
  "git@github.com:dbento-dev/bytebank-util-ui.git"
  "git@github.com:dbento-dev/bytebank-util-api.git"
  # "git@github.com:seu-usuario/bytebank-state-management.git"
)


PROJECTS_DIR="projects"

# --- CORES ---
GREEN='\033[0;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Iniciando a configuração do ambiente Bytebank...${NC}"

# --- 1. Clonar ou Atualizar Repositórios ---
echo -e "\n${GREEN}1/2: Clonando ou atualizando repositórios...${NC}"
mkdir -p "$PROJECTS_DIR"
for repo in "${REPOS[@]}"; do
  repo_name=$(basename "$repo" .git)
  dir_name=${repo_name#bytebank-}
  target="$PROJECTS_DIR/$dir_name"

  if [ -d "$target" ]; then
    echo "🔄 '$dir_name' já existe. Atualizando a partir da branch 'main'..."
    (cd "$target" && git checkout main && git pull origin main)
  else
    echo "⬇️ Clonando '$repo_name' em '$target'..."
    git clone "$repo" "$target"
  fi
done

# --- 2. Instalar todas as dependências com npm workspaces ---
echo -e "\n${GREEN}2/2: Instalando todas as dependências...${NC}"
npm install

echo -e "\n🎉 ${BLUE}Ambiente configurado com sucesso!${NC}"
