# CHAT-IA-USB 🧠💻

> IA local, portátil e independente para Windows, executada diretamente a partir de um dispositivo USB.

O **CHAT-IA-USB** é um projeto de **Vini Amaral** criado para disponibilizar uma Inteligência Artificial local e portátil utilizando **llamafile**, **llama.cpp** e um modelo **Qwen3 4B Thinking em formato GGUF**.

A proposta é transformar um dispositivo USB em um ambiente portátil de execução de uma LLM local, permitindo executar o modelo diretamente no computador do usuário sem depender obrigatoriamente de serviços de inferência em nuvem ou APIs comerciais.

---

## 👨‍💻 Autor

**Vini Amaral**

Desenvolvedor e criador do projeto **CHAT-IA-USB**.

🌐 **Site oficial:**  
http://viniamaral.click/

O código, scripts de automação, organização do projeto e documentação específica do CHAT-IA-USB são de autoria de **Vini Amaral**, salvo quando indicado explicitamente como componente de terceiros.

---

# 🚀 O que é o CHAT-IA-USB?

O CHAT-IA-USB foi criado com uma ideia simples:

> **Levar uma IA local para qualquer computador através de um dispositivo USB.**

O projeto combina:

- Runtime local de LLM
- Modelo GGUF
- Execução portátil
- Servidor HTTP
- API local
- Scripts automatizados
- Instalação automática
- Execução através de USB
- Compatibilidade com aplicações que utilizam APIs compatíveis com OpenAI

---

# 🧠 Arquitetura

```text
                         CHAT-IA-USB
                              │
                              ▼
                       DISPOSITIVO USB
                              │
             ┌────────────────┴────────────────┐
             │                                 │
             ▼                                 ▼
       llamafile 0.10.5                  Qwen3 4B
          Runtime                          GGUF
             │                                 │
             └────────────────┬────────────────┘
                              │
                              ▼
                     Servidor de inferência
                              │
                              ▼
                       127.0.0.1:8080
                              │
                ┌─────────────┼─────────────┐
                │             │             │
                ▼             ▼             ▼
             VS Code       Browser       Aplicações
```

---

# ✨ Principais características

- 🧠 Inteligência Artificial local
- 💾 Execução através de USB
- 🪟 Windows
- 📦 Modelo GGUF
- ⚙️ llamafile
- 🦙 llama.cpp
- 🌐 API HTTP local
- 🔌 Endpoint compatível com OpenAI
- 🔒 Execução local por padrão
- 🚀 Inicialização através de `.bat`
- 📥 Download automático dos componentes
- 📚 Documentação completa
- 🧩 Estrutura preparada para futuras extensões

---

# 📦 Componentes utilizados

O projeto utiliza principalmente:

| Componente | Função |
|---|---|
| CHAT-IA-USB | Projeto e automação |
| llamafile 0.10.5 | Runtime de inferência |
| llama.cpp | Infraestrutura de inferência |
| Qwen3 4B | Modelo de linguagem |
| GGUF | Formato do modelo |
| Windows | Sistema operacional |
| USB | Meio de armazenamento |

---

# 🤖 Modelo utilizado

O modelo atualmente utilizado é:

**Qwen3 4B Thinking Fine-tune**

Arquivo:

```text
qwen3-4b-thinking-2507.Q4_K_M.gguf
```

Fonte:

https://huggingface.co/pramodlohra/Qween3_4B_thinking_finetune

O modelo é um componente de terceiros e **não foi criado pelo autor do CHAT-IA-USB**.

O projeto apenas utiliza o modelo disponibilizado pela fonte indicada.

Consulte a página original do modelo para conhecer:

- licença;
- termos de uso;
- autoria;
- condições de redistribuição;
- limitações;
- informações sobre treinamento e conversão.

---

# ⚙️ llamafile

O runtime utilizado pelo projeto é:

```text
llamafile 0.10.5
```

Projeto oficial:

https://github.com/mozilla-ai/llamafile

Release utilizada:

https://github.com/mozilla-ai/llamafile/releases/tag/0.10.5

O llamafile é um projeto de terceiros e não é propriedade do CHAT-IA-USB.

Todos os direitos referentes ao llamafile permanecem com seus respectivos autores e contribuidores.

---

# 🦙 llama.cpp

O ecossistema utilizado para inferência também está relacionado ao:

**llama.cpp**

Projeto oficial:

https://github.com/ggml-org/llama.cpp

O llama.cpp fornece infraestrutura para execução eficiente de modelos de linguagem localmente.

O projeto é de terceiros e possui sua própria licença.

---

# 🛠️ Instalação

O CHAT-IA-USB utiliza dois scripts principais:

```text
instalar.bat
iniciar.bat
```

## `instalar.bat`

O instalador prepara automaticamente os componentes necessários.

Fluxo:

```text
instalar.bat
      │
      ▼
Verifica o ambiente
      │
      ▼
Verifica o llamafile
      │
      ▼
Baixa llamafile 0.10.5
      │
      ▼
Baixa Qwen3 4B GGUF
      │
      ▼
Verifica os arquivos
      │
      ▼
Instalação concluída
```

Execute:

```text
instalar.bat
```

---

# ▶️ Inicialização

Depois da instalação:

```text
iniciar.bat
```

O servidor será iniciado em:

```text
http://127.0.0.1:8080
```

API:

```text
http://127.0.0.1:8080/v1
```

---

# 🌐 API local

O servidor utiliza:

```text
127.0.0.1:8080
```

A API pode ser utilizada por aplicações compatíveis com APIs no padrão OpenAI, dependendo da ferramenta utilizada.

Base URL:

```text
http://127.0.0.1:8080/v1
```

Teste:

```cmd
curl http://127.0.0.1:8080/v1/models
```

---

# 🔒 Segurança

O servidor é configurado por padrão para:

```text
127.0.0.1
```

Isso significa que a IA permanece disponível localmente no computador onde está sendo executada.

O projeto **não recomenda expor diretamente a porta 8080 à Internet**.

Não altere:

```text
127.0.0.1
```

para:

```text
0.0.0.0
```

sem compreender as implicações de segurança.

Para exposição externa, recomenda-se utilizar uma arquitetura apropriada com:

- autenticação;
- autorização;
- TLS/HTTPS;
- rate limiting;
- controle de origem;
- firewall;
- monitoramento;
- logs;
- proteção contra abuso.

---

# 🔥 Firewall

Normalmente, uma aplicação acessando:

```text
127.0.0.1:8080
```

não precisa ser exposta à Internet.

Caso seja necessário permitir a porta através do Firewall do Windows em uma rede privada:

```cmd
netsh advfirewall firewall add rule name="CHAT-IA-USB - Llamafile 8080" dir=in action=allow protocol=TCP localport=8080 profile=private
```

Verificar:

```cmd
netsh advfirewall firewall show rule name="CHAT-IA-USB - Llamafile 8080"
```

---

# 🧪 Testando a IA

Depois de executar:

```text
iniciar.bat
```

mantenha a janela aberta.

Abra outro CMD ou PowerShell.

Execute:

```cmd
curl http://127.0.0.1:8080/v1/models
```

Se o servidor estiver funcionando, será retornada uma resposta JSON contendo informações sobre o modelo carregado.

Também pode ser utilizado:

```cmd
curl http://127.0.0.1:8080/health
```

---

# 💾 Requisitos do pendrive

O projeto foi desenvolvido/testado utilizando um pendrive comercializado como:

```text
16 GB
```

Entretanto, o Windows não necessariamente exibirá exatamente `16 GB`.

O dispositivo utilizado apresentou aproximadamente:

```text
14,326 GB
```

de capacidade reportada pelo sistema.

Isso é esperado devido à diferença entre:

```text
GB
```

e:

```text
GiB
```

além da estrutura utilizada pelo sistema de armazenamento.

Portanto:

```text
16 GB comercial
≠
16 GiB disponíveis no Windows
```

Um pendrive de 16 GB apresentar aproximadamente 14,3 GB no Windows **não significa automaticamente que exista defeito no dispositivo**.

---

# 💿 Sistema de arquivos recomendado

Para o CHAT-IA-USB:

```text
Sistema de arquivos: exFAT
Tabela de partição: MBR
```

Rótulo recomendado:

```text
CHAT-IA-USB
```

O exFAT é recomendado porque permite trabalhar com arquivos grandes, incluindo modelos GGUF.

---

# ⚠️ Formatação

A formatação apaga os dados do dispositivo.

Faça backup antes de executar qualquer procedimento de formatação.

No Windows:

```text
Este Computador
      ↓
Pendrive
      ↓
Botão direito
      ↓
Formatar
      ↓
Sistema de arquivos: exFAT
      ↓
Rótulo: CHAT-IA-USB
      ↓
Iniciar
```

Não é necessário formatar o dispositivo novamente depois que o projeto estiver instalado.

---

# 🔍 Diagnóstico do pendrive

Para verificar o sistema de arquivos:

```cmd
chkdsk E:
```

Para visualizar os arquivos:

```cmd
dir E:\
```

Para verificar o espaço disponível:

```cmd
fsutil volume diskfree E:
```

Dependendo da versão do Windows e do sistema de arquivos, determinados comandos podem apresentar limitações.

---

# 🧰 Diagnóstico com DiskPart

Abra o CMD como administrador:

```cmd
diskpart
```

Depois:

```text
list disk
```

Localize cuidadosamente o pendrive.

Para visualizar informações:

```text
select disk X
detail disk
```

Substitua `X` pelo número correspondente ao seu pendrive.

⚠️ **ATENÇÃO**

Nunca execute comandos de limpeza ou formatação em um disco sem confirmar que ele é realmente o pendrive.

Comandos como:

```text
clean
format
delete
```

podem destruir dados permanentemente.

---

# 📁 Estrutura do projeto

A estrutura recomendada para o GitHub é:

```text
CHAT-IA-USB/
│
├── README.md
├── LICENSE
├── .gitignore
├── .gitattributes
│
├── instalar.bat
├── iniciar.bat
│
├── docs/
│   ├── INSTALACAO.md
│   ├── SEGURANCA.md
│   └── CONFIGURACAO-VSCODE.md
│
└── scripts/
    └── testar-servidor.bat
```

---

# 🚫 Arquivos grandes

Os arquivos abaixo **não devem ser enviados diretamente para o GitHub como arquivos normais do projeto**:

```text
*.gguf
*.exe
*.safetensors
*.bin
```

O GitHub deve armazenar principalmente:

- código;
- scripts;
- documentação;
- configurações;
- exemplos;
- arquivos de automação.

Os componentes grandes podem ser baixados diretamente das respectivas fontes.

---

# 📥 Recuperação caso o instalador falhe

Se:

```text
instalar.bat
```

apresentar erro, não é necessário reinstalar o projeto.

Primeiro teste:

```cmd
curl --version
```

Se o comando funcionar, execute novamente:

```cmd
instalar.bat
```

---

# 🔧 Download manual do llamafile

Se o download automático falhar:

Acesse:

https://github.com/mozilla-ai/llamafile/releases/tag/0.10.5

Baixe o componente correspondente à versão:

```text
0.10.5
```

Coloque-o na pasta do projeto com o nome esperado pelo script:

```text
llamafile-0.10.5.exe
```

---

# 🔧 Download manual do Qwen3

Se o download automático do modelo falhar:

Acesse:

https://huggingface.co/pramodlohra/Qween3_4B_thinking_finetune

Baixe:

```text
qwen3-4b-thinking-2507.Q4_K_M.gguf
```

Coloque o arquivo na pasta principal do projeto.

---

# 🆘 Se o `iniciar.bat` não funcionar

Abra o CMD.

Entre na pasta:

```cmd
cd /d E:\
```

Depois:

```cmd
iniciar.bat
```

Isso permite visualizar os erros.

Também é possível executar diretamente:

```cmd
llamafile-0.10.5.exe --server --model "qwen3-4b-thinking-2507.Q4_K_M.gguf" --host 127.0.0.1 --port 8080
```

---

# ⚠️ Warnings

Durante a inicialização do llamafile podem aparecer mensagens classificadas como:

```text
W
warning
```

Nem todo warning representa uma falha fatal.

O principal teste é verificar se o servidor responde:

```cmd
curl http://127.0.0.1:8080/v1/models
```

---

# 🔌 Uso com VS Code

O servidor pode ser utilizado por ferramentas compatíveis com endpoints OpenAI.

Base URL:

```text
http://127.0.0.1:8080/v1
```

O projeto pode futuramente fornecer configurações específicas para:

- VS Code;
- extensões de IA;
- agentes;
- ferramentas de desenvolvimento;
- interfaces web;
- aplicações próprias.

---

# 🧠 Evolução planejada

O CHAT-IA-USB foi pensado para evoluir além da simples execução de um modelo.

## Fase 1 — IA local

- [x] llamafile
- [x] Qwen3 4B
- [x] GGUF
- [x] execução local
- [x] USB
- [x] servidor HTTP
- [x] API local

## Fase 2 — Automação

- [x] `instalar.bat`
- [x] `iniciar.bat`
- [ ] verificação de integridade
- [ ] recuperação automática de download
- [ ] detecção automática do modelo
- [ ] diagnóstico automático

## Fase 3 — Interface

- [ ] interface web própria
- [ ] chat
- [ ] histórico
- [ ] sessões
- [ ] upload de documentos

## Fase 4 — RAG

- [ ] documentos locais
- [ ] embeddings
- [ ] banco vetorial
- [ ] busca semântica
- [ ] contexto externo

## Fase 5 — Agentes

- [ ] ferramentas
- [ ] execução de tarefas
- [ ] agentes
- [ ] plugins
- [ ] automações

## Fase 6 — Multi-modelo

- [ ] múltiplos modelos
- [ ] seleção de modelo
- [ ] modelos especializados
- [ ] detecção de hardware
- [ ] GPU acceleration

---

# 📜 Atribuições

O CHAT-IA-USB combina código e automações próprias com componentes de código aberto e modelos disponibilizados por terceiros.

## Projeto CHAT-IA-USB

**Autor: Vini Amaral**

🌐 http://viniamaral.click/

A organização do projeto, scripts de instalação, scripts de execução, documentação específica e integrações desenvolvidas para o CHAT-IA-USB são atribuídos a **Vini Amaral**, salvo indicação diferente.

---

## Mozilla AI — llamafile

Projeto:

https://github.com/mozilla-ai/llamafile

O llamafile é um projeto de terceiros.

Todos os direitos relacionados ao projeto original permanecem com seus respectivos autores e contribuidores.

---

## llama.cpp

Projeto:

https://github.com/ggml-org/llama.cpp

O llama.cpp é um projeto de terceiros utilizado no ecossistema de inferência.

---

## Qwen3 4B Thinking Fine-tune

Modelo:

https://huggingface.co/pramodlohra/Qween3_4B_thinking_finetune

Autor/distribuidor indicado na fonte:

```text
pramodlohra
```

O modelo não é de autoria de Vini Amaral.

---

## Unsloth

Projeto:

https://github.com/unslothai/unsloth

A página do modelo utilizada neste projeto informa o uso do ecossistema Unsloth no processo relacionado ao modelo.

---

# ⚖️ Licenciamento

Os componentes de terceiros possuem suas próprias licenças.

Este repositório não altera, substitui ou concede direitos adicionais sobre:

- llamafile;
- llama.cpp;
- Qwen;
- modelos GGUF;
- Unsloth;
- outros componentes de terceiros.

Antes de redistribuir qualquer componente, consulte a licença e os termos da fonte original.

---

# ⚠️ Aviso sobre redistribuição

O fato de um arquivo estar disponível publicamente na Internet **não significa automaticamente que ele possa ser redistribuído sem restrições**.

Por isso, o CHAT-IA-USB utiliza uma estratégia em que os componentes grandes são obtidos diretamente das fontes correspondentes.

O GitHub contém principalmente:

```text
Código
Scripts
Documentação
Configurações
Automação
```

Enquanto os componentes externos podem ser obtidos diretamente de:

```text
Mozilla AI
Hugging Face
Projetos originais
```

---

# 🤝 Contribuições

Contribuições são bem-vindas.

Você pode contribuir através de:

- Issues;
- Pull Requests;
- documentação;
- testes;
- correções;
- sugestões;
- novas integrações;
- melhorias de desempenho;
- novos módulos.

---

# 🌟 Apoie o projeto

Se o **CHAT-IA-USB** foi útil para você:

⭐ Dê uma estrela no GitHub.

🍴 Faça um fork.

🐛 Reporte problemas.

💡 Sugira melhorias.

🤝 Contribua com o projeto.

🌐 Conheça o trabalho do autor:

**http://viniamaral.click/**

---

# 📌 Resumo rápido

```text
╔══════════════════════════════════════════════╗
║              CHAT-IA-USB                     ║
╠══════════════════════════════════════════════╣
║ Autor: Vini Amaral                           ║
║ Site: viniamaral.click                       ║
║                                              ║
║ Sistema: Windows                             ║
║ Dispositivo: USB                             ║
║ Filesystem: exFAT                            ║
║ Partição: MBR                                ║
║ Runtime: llamafile 0.10.5                    ║
║ Modelo: Qwen3 4B Thinking                    ║
║ Formato: GGUF                                ║
║ Servidor: 127.0.0.1:8080                    ║
║ API: 127.0.0.1:8080/v1                       ║
╚══════════════════════════════════════════════╝
```

---

# 🚀 Filosofia

O CHAT-IA-USB nasceu de uma ideia simples:

> **Uma Inteligência Artificial não precisa necessariamente estar na nuvem.**

Com hardware compatível, modelos quantizados e ferramentas de inferência local, é possível construir experiências de IA que executam diretamente no computador do usuário.

O objetivo deste projeto é explorar essa possibilidade de forma portátil, simples e acessível.

---

## 👨‍💻 Criado por Vini Amaral

🌐 **http://viniamaral.click/**

**CHAT-IA-USB — IA local. Portátil. Independente.**
```