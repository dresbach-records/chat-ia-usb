# CHAT-IA-USB — Funcionamento, Internet e Segurança

> Documento técnico sobre arquitetura, funcionamento, conectividade, privacidade e segurança do CHAT-IA-USB.

---

## 1. Visão geral

O **CHAT-IA-USB** foi desenvolvido para executar um modelo de Inteligência Artificial localmente em um computador Windows, utilizando um dispositivo USB como meio de armazenamento dos componentes necessários.

A arquitetura utiliza:

```text
Pendrive USB
     │
     ├── llamafile
     │
     ├── Modelo GGUF
     │
     ├── instalar.bat
     │
     └── iniciar.bat
              │
              ▼
        Computador Windows
              │
              ▼
       Motor de inferência
              │
              ▼
       Servidor HTTP local
              │
              ▼
        127.0.0.1:8080
```

O modelo é executado no próprio computador.

Não existe, na arquitetura padrão do projeto, uma necessidade de enviar cada pergunta para uma API externa para que a resposta seja gerada.

A documentação oficial do llamafile descreve a execução local e informa que, nesse modo, os dados não precisam sair do computador.

---

# 2. O que acontece quando o usuário executa o projeto?

O fluxo normal é:

```text
Usuário conecta o pendrive
          │
          ▼
Windows reconhece o dispositivo
          │
          ▼
Usuário executa instalar.bat
          │
          ▼
Componentes são baixados
          │
          ▼
Modelo GGUF fica armazenado localmente
          │
          ▼
Usuário executa iniciar.bat
          │
          ▼
llamafile carrega o modelo
          │
          ▼
Servidor HTTP é iniciado
          │
          ▼
127.0.0.1:8080
          │
          ▼
Usuário utiliza a IA
```

Depois que os componentes necessários já estão presentes, a execução do modelo pode ocorrer localmente.

---

# 3. A IA precisa de Internet?

## Não necessariamente.

Essa é uma das principais características do projeto.

Existem dois momentos diferentes:

```text
INSTALAÇÃO
    ↓
Internet recomendada/necessária
```

e:

```text
EXECUÇÃO
    ↓
Internet não é obrigatória
```

### Durante a instalação

O `instalar.bat` pode precisar de Internet para baixar:

```text
llamafile
modelo GGUF
```

Esses arquivos são obtidos das respectivas fontes.

Portanto:

```text
Internet
   ↓
Download
   ↓
Armazenamento local
```

### Depois da instalação

Depois que todos os componentes já estiverem armazenados:

```text
Pendrive
   ↓
llamafile
   ↓
modelo GGUF
   ↓
CPU/GPU do computador
   ↓
resposta
```

A inferência pode ocorrer localmente.

---

# 4. É possível utilizar sem Internet?

## Sim.

Depois de baixar os componentes necessários, o usuário pode desconectar o computador da Internet e executar o modelo localmente.

O fluxo passa a ser:

```text
              SEM INTERNET
                   │
                   ▼
             Pendrive USB
                   │
                   ▼
              llamafile
                   │
                   ▼
              Modelo GGUF
                   │
                   ▼
              CPU / GPU
                   │
                   ▼
             IA LOCAL
                   │
                   ▼
          127.0.0.1:8080
```

Nesse cenário, não existe necessidade de uma conexão com um servidor de IA remoto para gerar a resposta.

---

# 5. O que significa "IA local"?

IA local significa que o processamento de inferência acontece no equipamento onde o modelo está sendo executado.

No CHAT-IA-USB:

```text
Pergunta
   │
   ▼
Aplicação local
   │
   ▼
API local
   │
   ▼
llamafile
   │
   ▼
Qwen3 4B GGUF
   │
   ▼
Processamento local
   │
   ▼
Resposta
```

O modelo não precisa ser enviado para um servidor externo para produzir a resposta.

---

# 6. O pendrive é o servidor?

Não exatamente.

O pendrive é principalmente o **meio de armazenamento e transporte** do ambiente.

Ele contém componentes como:

```text
llamafile
modelo GGUF
scripts
configurações
documentação
```

O processamento pesado ocorre no computador.

Portanto:

```text
PENDRIVE
    =
ARMAZENAMENTO
```

enquanto:

```text
COMPUTADOR
    =
PROCESSAMENTO
```

---

# 7. O computador precisa ser potente?

Depende do modelo utilizado.

O CHAT-IA-USB atualmente utiliza:

```text
Qwen3 4B Thinking
Q4_K_M
GGUF
```

O modelo quantizado reduz o consumo de armazenamento e memória em relação a versões maiores ou menos quantizadas.

Entretanto, o desempenho ainda depende principalmente de:

- CPU;
- RAM;
- GPU;
- VRAM;
- largura de banda de memória;
- velocidade do armazenamento;
- tamanho do contexto;
- parâmetros de execução.

O pendrive não transforma um computador fraco em um computador potente.

Ele apenas torna o ambiente portátil.

---

# 8. O modelo fica na nuvem?

Não.

Quando o modelo GGUF é baixado para o pendrive:

```text
Hugging Face
      │
      │ download
      ▼
Pendrive
      │
      ▼
Modelo GGUF
```

A inferência passa a utilizar o arquivo armazenado localmente.

O modelo utilizado pelo projeto é:

```text
qwen3-4b-thinking-2507.Q4_K_M.gguf
```

Fonte:

https://huggingface.co/pramodlohra/Qween3_4B_thinking_finetune

---

# 9. Para que serve a porta 8080?

O CHAT-IA-USB executa um servidor HTTP local.

A configuração utilizada pelo projeto é:

```text
Host:
127.0.0.1

Porta:
8080
```

Portanto:

```text
http://127.0.0.1:8080
```

é o endereço local do servidor.

A documentação do llamafile utiliza `localhost:8080` para o servidor Web/API e documenta o modo `--server`.

---

# 10. O que é 127.0.0.1?

`127.0.0.1` é o endereço de loopback do próprio computador.

Em termos simples:

```text
127.0.0.1
    =
este próprio computador
```

Quando uma aplicação acessa:

```text
http://127.0.0.1:8080
```

ela está acessando o servidor no próprio computador.

Isso é diferente de:

```text
0.0.0.0
```

que pode fazer o serviço escutar interfaces de rede externas.

A documentação do servidor do llama.cpp indica `127.0.0.1` como host padrão e `8080` como porta padrão.

---

# 11. O servidor fica acessível pela Internet?

## Na configuração padrão, não deveria ficar diretamente exposto à Internet.

O projeto utiliza:

```text
--host 127.0.0.1
--port 8080
```

Isso restringe o serviço ao próprio computador.

Exemplo:

```text
Internet
   X
   │
   │ não é o objetivo
   ▼
127.0.0.1:8080
   ▲
   │
Computador local
```

A documentação oficial diferencia explicitamente o uso local do uso com `--host 0.0.0.0`, que permite acesso por outras máquinas alcançáveis pela rede.

---

# 12. E se eu usar 0.0.0.0?

É necessário cuidado.

Por exemplo:

```text
--host 0.0.0.0
```

pode fazer o servidor aceitar conexões através das interfaces de rede do computador.

Isso pode permitir que outros dispositivos da rede acessem a IA.

Dependendo da configuração do roteador, firewall e rede, uma configuração incorreta pode aumentar significativamente a superfície de ataque.

Por isso, o projeto utiliza:

```text
127.0.0.1
```

como configuração padrão.

---

# 13. Posso abrir a porta 8080 no Firewall?

Tecnicamente, sim.

Mas isso deve ser feito somente quando houver uma necessidade específica.

Uma regra como:

```cmd
netsh advfirewall firewall add rule name="CHAT-IA-USB - Llamafile 8080" dir=in action=allow protocol=TCP localport=8080 profile=private
```

permite entrada de tráfego na porta especificada conforme as condições da regra.

Isso **não significa automaticamente que a aplicação esteja exposta à Internet**.

A exposição depende também de:

- endereço de bind;
- interfaces de rede;
- firewall;
- roteador;
- NAT;
- regras de encaminhamento de portas;
- configuração da rede.

---

# 14. Internet desligada

Uma das formas mais simples de verificar o caráter local do projeto é:

```text
1. Baixar os componentes.
2. Instalar o modelo.
3. Desconectar a Internet.
4. Executar iniciar.bat.
5. Acessar 127.0.0.1:8080.
```

Se o ambiente estiver corretamente configurado, a inferência poderá continuar localmente.

---

# 15. A IA pode acessar a Internet?

Na configuração básica do projeto, o modelo está sendo utilizado para inferência local.

Isso não significa que qualquer software executado no computador seja incapaz de acessar a Internet.

É importante separar:

```text
MODELO
```

de:

```text
PROCESSO LLAMAFILE
```

e:

```text
OUTROS PROGRAMAS DO COMPUTADOR
```

O fato de a IA ser local não transforma automaticamente todo o computador em um ambiente isolado.

---

# 16. O llamafile possui mecanismos de segurança?

O projeto llamafile possui mecanismos de sandboxing em plataformas onde determinadas primitivas estão disponíveis.

A documentação oficial informa que mecanismos como `pledge()` e `unveil()` podem restringir capacidades do processo, mas também deixa claro que **Windows não fornece essas mesmas primitivas de sandboxing utilizadas em Linux/OpenBSD**; no Windows, elas são no-op e o llamafile registra que o sandbox não está disponível.

Isso é extremamente importante.

Portanto:

> **Não devemos afirmar que a execução no Windows é sandboxed da mesma forma que no Linux.**

O projeto deve considerar o ambiente Windows como parte da superfície de segurança.

---

# 17. O que isso significa na prática?

No Windows:

```text
llamafile
    │
    ▼
Processo Windows
    │
    ▼
Permissões do usuário
```

Por isso, recomenda-se:

- não executar como Administrador;
- manter o Windows atualizado;
- utilizar antivírus/Windows Defender;
- não executar arquivos desconhecidos;
- baixar componentes de fontes confiáveis;
- verificar arquivos antes de executar;
- não habilitar ferramentas desnecessárias;
- não expor a API publicamente sem autenticação.

---

# 18. Não executar como administrador

O projeto não precisa ser executado como administrador para funcionar normalmente.

Evite:

```text
Executar como administrador
```

sem necessidade.

Quanto menor o privilégio do processo:

```text
menor privilégio
      ↓
menor impacto potencial
```

em caso de comprometimento.

---

# 19. Segurança da API

O servidor local pode aceitar requisições HTTP.

A configuração básica não deve ser tratada como uma API pública segura.

O servidor do llama.cpp possui suporte a autenticação através de:

```text
--api-key
```

e também:

```text
--api-key-file
```

conforme a documentação atual do servidor.

Isso é importante principalmente quando o servidor deixa de ser exclusivamente local.

---

# 20. CORS

CORS controla quais origens de navegador podem fazer determinadas requisições ao servidor.

O servidor possui configuração para:

```text
--cors-origins
```

A configuração padrão e o comportamento de CORS devem ser considerados ao construir uma interface web.

Para um ambiente exclusivamente local, é preferível restringir as origens quando isso for necessário.

Não é recomendado simplesmente liberar tudo sem entender o impacto.

---

# 21. API pública não é recomendada

Não faça:

```text
Internet
   │
   ▼
porta 8080
   │
   ▼
llamafile
```

sem uma camada adequada de proteção.

Para uma implantação pública, recomenda-se uma arquitetura como:

```text
Internet
   │
   ▼
HTTPS
   │
   ▼
Reverse Proxy
   │
   ├── TLS
   ├── Rate Limit
   ├── Authentication
   ├── Access Control
   └── Logging
   │
   ▼
llamafile
   │
   ▼
Modelo
```

A documentação do servidor recomenda API key e reverse proxy para ambientes públicos.

---

# 22. O que acontece com minhas perguntas?

No fluxo local:

```text
Pergunta
   │
   ▼
Aplicação local
   │
   ▼
127.0.0.1:8080
   │
   ▼
llamafile
   │
   ▼
modelo local
   │
   ▼
Resposta
```

A pergunta não precisa ser enviada para uma API de IA na nuvem.

Isso é uma diferença importante em relação a serviços em que o processamento ocorre em servidores remotos.

---

# 23. Privacidade

A arquitetura local pode proporcionar uma vantagem importante de privacidade:

```text
Dados
  ↓
Computador local
  ↓
Modelo local
```

em vez de:

```text
Dados
  ↓
Internet
  ↓
Servidor externo
  ↓
Modelo remoto
```

Entretanto, privacidade não deve ser confundida com segurança absoluta.

O sistema operacional, outros programas, malware, extensões, logs e ferramentas utilizadas pelo usuário continuam sendo fatores de segurança.

---

# 24. O projeto é 100% seguro?

## Não existe garantia de 100% de segurança.

A descrição correta é:

> O CHAT-IA-USB foi projetado para execução local e, por padrão, mantém o servidor vinculado ao `127.0.0.1`. Isso reduz a exposição de rede, mas não elimina riscos de segurança.

Segurança depende de:

- sistema operacional;
- usuário;
- permissões;
- arquivos executados;
- origem do modelo;
- versão do runtime;
- configuração de rede;
- firewall;
- antivírus;
- aplicações integradas;
- extensões;
- comportamento do usuário.

---

# 25. Segurança do pendrive

O pendrive também deve ser tratado como um dispositivo de armazenamento.

Não conecte o pendrive em computadores desconhecidos sem considerar os riscos.

Um computador comprometido pode:

```text
USB
 ↓
ler arquivos
 ↓
alterar arquivos
 ↓
substituir executáveis
 ↓
comprometer a execução
```

Por isso, é recomendado utilizar o projeto em máquinas confiáveis.

---

# 26. Verificação dos arquivos

Para uma versão mais avançada do projeto, recomenda-se futuramente implementar:

```text
SHA-256
```

para verificar a integridade dos downloads.

Exemplo:

```text
Download
   ↓
SHA-256
   ↓
Comparação
   ↓
Arquivo válido?
   │
   ├── SIM → continuar
   │
   └── NÃO → excluir e baixar novamente
```

Essa funcionalidade está prevista como evolução do projeto.

---

# 27. Instalação versus execução

É importante diferenciar:

## Instalação

Pode precisar de Internet:

```text
Internet
   ↓
llamafile
   ↓
modelo
```

## Execução

Pode funcionar sem Internet:

```text
USB
 ↓
llamafile
 ↓
modelo
 ↓
CPU/GPU
 ↓
IA
```

Essa separação é fundamental para entender o projeto.

---

# 28. O projeto depende de servidores externos durante a inferência?

A arquitetura padrão não foi projetada para depender de um servidor externo para gerar cada resposta.

O modelo GGUF é armazenado localmente.

A documentação do llamafile descreve justamente o uso local do modelo e da interface/API.

Entretanto, qualquer atualização, novo download, instalação ou integração externa pode naturalmente exigir Internet.

---

# 29. Atualizações

Quando houver uma nova versão do:

```text
llamafile
```

ou:

```text
modelo
```

o projeto poderá disponibilizar uma nova versão do instalador.

Recomenda-se não substituir componentes críticos manualmente sem verificar:

- versão;
- origem;
- compatibilidade;
- licença;
- integridade.

---

# 30. Ferramentas e agentes

O llama.cpp possui recursos adicionais de ferramentas/agentes.

Esses recursos exigem atenção especial.

A documentação atual alerta que ferramentas podem acessar arquivos locais e, dependendo da configuração, executar operações com os privilégios do processo. A recomendação oficial é não habilitá-las em ambientes não confiáveis.

Por isso:

```text
CHAT
   =
menor superfície de ataque
```

enquanto:

```text
CHAT + TOOLS + FILESYSTEM + EXEC
   =
maior superfície de ataque
```

O projeto básico não deve habilitar capacidades adicionais sem necessidade.

---

# 31. Modelo local não significa computador isolado

Esta distinção é essencial.

```text
IA LOCAL
```

significa:

> o modelo e a inferência estão sendo executados localmente.

Não significa:

```text
computador isolado
```

nem:

```text
computador invulnerável
```

nem:

```text
nenhum processo pode acessar a Internet
```

São conceitos diferentes.

---

# 32. Modelo de ameaça

O projeto deve considerar pelo menos:

### Ameaça 1 — Arquivo malicioso

Um executável adulterado pode comprometer o computador.

Mitigação:

- utilizar fontes oficiais;
- verificar hashes;
- evitar binários desconhecidos;
- utilizar antivírus.

### Ameaça 2 — Exposição da API

Uma API exposta pode receber requisições não autorizadas.

Mitigação:

- `127.0.0.1`;
- firewall;
- API key;
- reverse proxy;
- TLS.

### Ameaça 3 — CORS excessivamente permissivo

Um navegador pode tentar realizar requisições ao servidor local.

Mitigação:

- restringir origens;
- evitar CORS aberto sem necessidade.

### Ameaça 4 — Ferramentas com acesso ao sistema

Ferramentas podem ampliar significativamente as permissões efetivas do sistema.

Mitigação:

- não habilitar ferramentas desnecessárias;
- utilizar isolamento;
- limitar permissões;
- revisar comandos permitidos.

### Ameaça 5 — Computador comprometido

Se o Windows já estiver comprometido, uma IA local não resolve o problema.

Mitigação:

- Windows atualizado;
- Defender/antivírus;
- contas com privilégios mínimos;
- software confiável.

---

# 33. Configuração recomendada

Para uso pessoal e local:

```text
Host:
127.0.0.1

Port:
8080

Internet:
Opcional após instalação

API pública:
Não

API Key:
Opcional para uso exclusivamente local

CORS:
Restrito quando necessário

Tools:
Desabilitadas

Execução:
Usuário normal

Firewall:
Sem exposição pública
```

---

# 34. Configuração NÃO recomendada

Evite uma configuração como:

```text
Host:
0.0.0.0

Port:
8080

API:
Pública

API Key:
Nenhuma

CORS:
*

Tools:
Todas

Execução:
Administrador
```

Essa combinação aumenta significativamente a superfície de ataque.

---

# 35. Configuração para ambiente de produção

Se o projeto futuramente for transformado em um serviço de IA acessível por rede, a arquitetura deve ser alterada.

Recomendação:

```text
                    INTERNET
                       │
                       ▼
                    HTTPS
                       │
                       ▼
                Reverse Proxy
                       │
          ┌────────────┴────────────┐
          │                         │
          ▼                         ▼
     Authentication             Rate Limit
          │                         │
          └────────────┬────────────┘
                       │
                       ▼
                 API Gateway
                       │
                       ▼
              llama.cpp/llamafile
                       │
                       ▼
                    Model
```

Deve incluir:

- TLS;
- autenticação;
- autorização;
- rate limiting;
- logs;
- monitoramento;
- controle de origem;
- isolamento;
- gerenciamento de segredos;
- atualização de dependências.

---

# 36. Checklist de segurança

Antes de utilizar:

- [ ] Windows atualizado
- [ ] Windows Defender ativo
- [ ] Arquivos obtidos de fontes confiáveis
- [ ] Modelo obtido da fonte original
- [ ] llamafile obtido da fonte oficial
- [ ] Não executar como administrador
- [ ] Host configurado como `127.0.0.1`
- [ ] Porta 8080 não exposta publicamente
- [ ] Ferramentas não habilitadas sem necessidade
- [ ] CORS revisado
- [ ] Firewall revisado
- [ ] Pendrive utilizado em computador confiável

---

# 37. Resumo da conectividade

| Operação | Internet |
|---|---:|
| Clonar o projeto | Sim |
| Baixar llamafile | Sim |
| Baixar modelo | Sim |
| Instalação inicial | Geralmente sim |
| Iniciar modelo já instalado | Não |
| Conversar com a IA local | Não |
| Acessar `127.0.0.1:8080` | Não |
| Usar API local | Não |
| Atualizar componentes | Sim |
| Baixar novo modelo | Sim |
| Usar serviços externos | Depende da integração |

---

# 38. Resumo da arquitetura

```text
┌─────────────────────────────────────────────┐
│                 PENDRIVE USB                │
│                                             │
│  instalar.bat                               │
│  iniciar.bat                                │
│  llamafile                                  │
│  Qwen3 4B GGUF                              │
│                                             │
└─────────────────────┬───────────────────────┘
                      │
                      ▼
              COMPUTADOR WINDOWS
                      │
                      ▼
                 llamafile
                      │
                      ▼
                 Qwen3 4B
                      │
                      ▼
              Inferência local
                      │
                      ▼
              HTTP Server :8080
                      │
                      ▼
                127.0.0.1
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
        Browser     VS Code     Aplicações
```

---

# 39. Conclusão

O CHAT-IA-USB foi projetado para oferecer uma experiência de Inteligência Artificial **local, portátil e independente de nuvem durante a inferência**.

O funcionamento pode ser dividido em duas etapas:

```text
DOWNLOAD
    ↓
Internet
```

e:

```text
INFERÊNCIA
    ↓
Local
```

Depois que o llamafile e o modelo GGUF estiverem armazenados no dispositivo, o computador pode executar a IA localmente sem depender de uma conexão permanente com a Internet.

A utilização de:

```text
127.0.0.1:8080
```

como endereço padrão reduz a exposição da API para outros dispositivos da rede.

Entretanto, **local não significa automaticamente seguro**.

A segurança depende também do sistema operacional, dos arquivos utilizados, das permissões do processo, das configurações de rede, do firewall, das ferramentas habilitadas e da integridade dos componentes.

Para uso local:

```text
127.0.0.1
+
usuário sem privilégios administrativos
+
fontes confiáveis
+
firewall
+
ferramentas desabilitadas
```

é uma configuração muito mais adequada.

Para exposição em rede ou Internet, o projeto deve receber uma camada adicional de segurança com autenticação, TLS, reverse proxy, rate limiting e controles de acesso.

---

# 👨‍💻 Autor

**Vini Amaral**

🌐 http://viniamaral.click/

---

# 🔗 Fontes técnicas

### llamafile

https://github.com/mozilla-ai/llamafile

### llamafile — Quickstart

https://github.com/mozilla-ai/llamafile/blob/main/docs/quickstart.md

### llamafile — Running in server mode

https://github.com/mozilla-ai/llamafile/blob/main/docs/running_llamafile.md

### llamafile — Security

https://github.com/mozilla-ai/llamafile/blob/main/docs/security.md

### llama.cpp

https://github.com/ggml-org/llama.cpp

### Qwen3 4B Thinking Fine-tune

https://huggingface.co/pramodlohra/Qween3_4B_thinking_finetune

---

> **CHAT-IA-USB — IA local. Portátil. Independente.**
>
> **Criado por Vini Amaral.**
>
> 🌐 http://viniamaral.click/