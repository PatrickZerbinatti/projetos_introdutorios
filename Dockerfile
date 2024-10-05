# Use a imagem base do Ubuntu
FROM ubuntu:22.04

# Definir fuso horário
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Variáveis de ambiente para não perguntar durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependências do sistema e compiladores básicos
RUN apt-get update && \
    apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    curl \
    wget \
    gnupg \
    unzip \
    build-essential \
    libssl-dev \
    libffi-dev \
    gcc \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# Instalar pip manualmente após instalar o Python 3.11
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.11 get-pip.py && \
    rm get-pip.py

# Definir Python 3.11 como padrão
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip 1

# Atualizar pip
RUN pip install -U pip

# Instalar o Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Instalar pacotes Python via pip
RUN pip install robotframework-browser rpaframework

# Inicializar o Robot Framework Browser
RUN rfbrowser init

# Instalar dependências e navegadores do Playwright
RUN npx playwright install-deps

# Criar volume para armazenar arquivos
VOLUME /workspace/download

# Definir o diretório de trabalho
WORKDIR /workspace

# Definir o ponto de entrada padrão
CMD ["/bin/bash"]