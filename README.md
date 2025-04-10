# Guia de Instalação do Prolog

Este guia fornece instruções passo a passo para instalar Prolog e executar o jogo Nine Men's Morris.

## **Integrantes**
- Alexandre Campos - 123110762
- Jonatas Alves - 123110541
- Theo Evangelista - 123110843
- Vinícius Laureano - 123111119
---

# 📦 Instalação do SWI-Prolog no Linux

Este guia fornece instruções passo a passo para instalar o **SWI-Prolog** em sistemas Linux (Ubuntu/Debian e derivados). O SWI-Prolog é uma implementação de Prolog amplamente usada para ensino, pesquisa e aplicações comerciais.

---

## ✅ Requisitos

- Sistema operacional baseado em Linux (preferencialmente Debian/Ubuntu ou derivados)
- Acesso ao terminal com permissões de superusuário (sudo)

---

## 🚀 Etapas de Instalação

### 1. Atualizar os repositórios do sistema

```bash
sudo apt update && sudo apt upgrade -y
```

---

### 2. Instalar o SWI-Prolog via `apt`

```bash
sudo apt install swi-prolog -y
```

Esse comando instalará a versão estável do SWI-Prolog diretamente dos repositórios oficiais da sua distribuição Linux.

---

### 3. Verificar se a instalação foi bem-sucedida

Digite no terminal:

```bash
swipl
```

Você deverá ver algo como:

```
Welcome to SWI-Prolog (threaded, 64 bits, version x.x.x)
...
?-
```

Isso indica que o Prolog está pronto para uso!

---

## 🕹️ Instalação e Execução do Jogo!

### 1. Faça o Download do jogo
Para isso, basta executar o seguinte comando no terminal:
```git
git clone https://github.com/ViniciusLaureano/Prolog_Project.git
```

### 2. Acesse os arquivos do jogo
Entre na pasta que acabou de ser criada, com o comando:
```bash
cd Prolog_Project/
```
### 3. Execute o jogo com Prolog
Dentro da pasta principal, execute o arquivo main:
```bash
swipl main.pl
```

### 4. Execute a função principal
No terminal do próprio Prolog, execute:
```bash
?- main.
```

## Pronto para jogar!!!