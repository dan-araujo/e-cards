# 🃏 e-cards

**e-cards** é um projeto de banco de dados relacional para gerenciamento de cartas colecionáveis do universo Pokémon TCG. Ele permite organizar coleções, cartas, ataques e atributos com suporte a views, seeds e automações via scripts.

## ⚙️ Pré-requisitos
- PostgreSQL instalado e configurado
- `psql` e `createdb` disponíveis no terminal
- Windows com suporte a scripts `.bat` e PowerShell

---

## 🔐 Configuração do ambiente

1. Copie o arquivo de exemplo:
   ```bash
   copy env.example.bat env.bat
```
2. Edite o `env.bat` com suas credenciais do PostgreSQL

## 🚀 Como rodar o projeto

### 1. Criar o banco e popular com dados
```
run_sql.bat
```

Esse script:

- Cria o banco (se não existir)
- Executa os scripts de criação de tabelas
- Popula com coleções, cartas e ataques
- Gera logs em `log.txt`

### 2. Criar as views
```
run_views.bat
```

Esse script executa os arquivos `.sql` da pasta `views/` e cria as views no banco.

### 3. Visualizar e exportar dados das views
```
run_views_full.bat
```

Esse script:

- Exibe os dados das views no terminal
- Exporta os dados para arquivos `.csv` na pasta `export/`

## 🧠 Conceitos aplicados

- Migrations manuais com versionamento de scripts
- Views para abstração de joins e simplificação de consultas
- Seeds organizados por domínio (coleções, cartas, ataques)
- Automação com `.bat` e PowerShell
    

## 📄 Licença

Este projeto é de uso educacional e está sob a licença MIT. Fique à vontade para estudar, modificar e contribuir!