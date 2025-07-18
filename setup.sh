#!/bin/bash

# --- CONFIGURAÇÃO ---
REPOS=(
  # Shell (root app)
  "git@github.com:dbento-dev/bytebank-root.git"

  # MFEs
  "git@github.com:dbento-dev/bytebank-app-header.git"
  "git@github.com:dbento-dev/bytebank-app-dashboard.git"
  # "git@github.com:dbento-dev/bytebank-app-transactions.git"

  # Pacotes compartilhados / utils
  "git@github.com:dbento-dev/bytebank-util-ui.git"
  # "git@github.com:dbento-dev/bytebank-api-client.git"
  # "git@github.com:seu-usuario/bytebank-state-management.git"
)

# SHARED_PACKAGES=("util-ui", "api-client")
SHARED_PACKAGES=()
CONSUMER_APPS=("root" "app-header" "app-dashboard" "util-ui")
# CONSUMER_APPS=("root" "app-header" "app-dashboard" "app-transactions")

PROJECTS_DIR="projects"

# --- CORES ---
GREEN='\033[0;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Iniciando a configuração do ambiente Bytebank...${NC}"

# --- 1. Clonar Repositórios ---
echo -e "\n${GREEN}1/5: Clonando repositórios...${NC}"
mkdir -p "$PROJECTS_DIR"
for repo in "${REPOS[@]}"; do
  repo_name=$(basename "$repo" .git)
  dir_name=${repo_name#bytebank-}
  target="$PROJECTS_DIR/$dir_name"

  if [ -d "$target" ]; then
    echo "✅ '$dir_name' já existe. Pulando."
  else
    echo "⬇️ Clonando '$repo_name' em '$target'..."
    git clone "$repo" "$target"
  fi
done

# --- 2. Instalar dependências nos pacotes compartilhados ---
echo -e "\n${GREEN}2/5: Instalando dependências nos pacotes compartilhados...${NC}"
for pkg in "${SHARED_PACKAGES[@]}"; do
  dir="$PROJECTS_DIR/$pkg"
  if [ -d "$dir" ]; then
    echo "📦 Instalando em '$pkg'..."
    (cd "$dir" && npm install)
  else
    echo "⚠️ Pacote '$pkg' não encontrado!"
  fi
done

# --- 3. Executar npm link nos pacotes compartilhados ---
echo -e "\n${GREEN}3/5: Registrando pacotes compartilhados com npm link...${NC}"
for pkg in "${SHARED_PACKAGES[@]}"; do
  dir="$PROJECTS_DIR/$pkg"
  if [ -d "$dir" ]; then
    echo "🔗 Linkando globalmente @bytebank/$pkg..."
    (cd "$dir" && npm link)
  fi
done

# --- 4. Linkar os pacotes nos aplicativos consumidores ---
echo -e "\n${GREEN}4/5: Linkando pacotes nos aplicativos consumidores...${NC}"
for app in "${CONSUMER_APPS[@]}"; do
  app_dir="$PROJECTS_DIR/$app"
  if [ -d "$app_dir" ]; then
    for pkg in "${SHARED_PACKAGES[@]}"; do
      echo "🔗 Linkando @bytebank/$pkg em '$app'..."
      (cd "$app_dir" && npm link "@bytebank/$pkg")
    done
  else
    echo "⚠️ App '$app' não encontrado."
  fi
done

# --- 5. Instalar dependências dos apps consumidores ---
echo -e "\n${GREEN}5/5: Instalando dependências nos apps consumidores...${NC}"
for app in "${CONSUMER_APPS[@]}"; do
  app_dir="$PROJECTS_DIR/$app"
  if [ -d "$app_dir" ]; then
    echo "📦 Instalando em '$app'..."
    (cd "$app_dir" && npm install --force)
  fi
done

echo -e "\n🎉 ${BLUE}Ambiente configurado com sucesso!${NC}"
