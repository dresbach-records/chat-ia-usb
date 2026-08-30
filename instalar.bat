Sim. E agora dá para fazer o `BAT` baixar **automaticamente o `llamafile-0.10.5`** também.

A documentação oficial confirma que, no Windows, o llamafile pode ser usado como um binário separado junto com um GGUF externo — exatamente o seu cenário. ([GitHub][1])

Para o **0.10.5**, existe o binário oficial `llamafile-0.10.5` com aproximadamente **351 MB** no Hugging Face da Mozilla AI. ([Hugging Face][2])

Eu faria assim:

### `instalar.bat`

```bat
@echo off
setlocal EnableExtensions

title CHAT-IA-USB - Instalador

cd /d "%~dp0"

echo ============================================================
echo                 CHAT-IA-USB
echo              INSTALADOR AUTOMATICO
echo ============================================================
echo.
echo Pasta:
echo %CD%
echo.

REM ============================================================
REM CONFIGURACAO
REM ============================================================

set "LLAMAFILE=llamafile-0.10.5.exe"
set "MODEL=qwen3-4b-thinking-2507.Q4_K_M.gguf"

set "LLAMAFILE_URL=https://huggingface.co/mozilla-ai/llamafile_0.10/resolve/main/llamafile-0.10.5?download=true"

set "MODEL_URL=https://huggingface.co/pramodlohra/Qween3_4B_thinking_finetune/resolve/main/qwen3-4b-thinking-2507.Q4_K_M.gguf?download=true"

REM ============================================================
REM VERIFICAR CURL
REM ============================================================

where curl >nul 2>&1

if errorlevel 1 (
    echo [ERRO] O comando CURL nao foi encontrado.
    echo.
    pause
    exit /b 1
)

REM ============================================================
REM BAIXAR LLAMAFILE
REM ============================================================

if exist "%LLAMAFILE%" (
    echo [OK] llamafile ja existe.
    echo.
) else (
    echo ============================================================
    echo BAIXANDO LLAMAFILE 0.10.5
    echo ============================================================
    echo.
    echo Tamanho aproximado: 351 MB
    echo.
    echo Fonte:
    echo Mozilla AI
    echo.

    curl -L --fail --progress-bar ^
        -o "%LLAMAFILE%" ^
        "%LLAMAFILE_URL%"

    if errorlevel 1 (
        echo.
        echo [ERRO] Falha ao baixar o llamafile.
        echo.
        
        if exist "%LLAMAFILE%" del /q "%LLAMAFILE%"
        
        pause
        exit /b 1
    )

    echo.
    echo [OK] llamafile baixado.
    echo.
)

REM ============================================================
REM BAIXAR MODELO QWEN
REM ============================================================

if exist "%MODEL%" (
    echo [OK] Modelo Qwen ja existe.
    echo.
) else (
    echo ============================================================
    echo BAIXANDO QWEN 3 4B
    echo ============================================================
    echo.
    echo Arquivo:
    echo %MODEL%
    echo.
    echo Tamanho aproximado: 2.5 GB
    echo.
    echo Fonte:
    echo Hugging Face
    echo.

    curl -L --fail --progress-bar ^
        -o "%MODEL%" ^
        "%MODEL_URL%"

    if errorlevel 1 (
        echo.
        echo [ERRO] Falha ao baixar o modelo Qwen.
        echo.
        
        if exist "%MODEL%" del /q "%MODEL%"
        
        pause
        exit /b 1
    )

    echo.
    echo [OK] Modelo Qwen baixado.
    echo.
)

REM ============================================================
REM VERIFICAR ARQUIVOS
REM ============================================================

echo ============================================================
echo VERIFICANDO INSTALACAO
echo ============================================================
echo.

if not exist "%LLAMAFILE%" (
    echo [ERRO] llamafile nao encontrado.
    pause
    exit /b 1
)

if not exist "%MODEL%" (
    echo [ERRO] Modelo Qwen nao encontrado.
    pause
    exit /b 1
)

echo [OK] llamafile encontrado.
echo [OK] Qwen encontrado.
echo.

REM ============================================================
REM MOSTRAR TAMANHOS
REM ============================================================

echo ============================================================
echo ARQUIVOS INSTALADOS
echo ============================================================
echo.

dir "%LLAMAFILE%" "%MODEL%"

echo.
echo ============================================================
echo INSTALACAO CONCLUIDA
echo ============================================================
echo.
echo Para iniciar a IA execute:
echo.
echo iniciar.bat
echo.

pause
```

### `iniciar.bat`

```bat
@echo off
setlocal

title CHAT-IA-USB - Qwen 3 4B

cd /d "%~dp0"

echo ============================================================
echo              CHAT-IA-USB - QWEN 3 4B
echo ============================================================
echo.
echo Pasta:
echo %CD%
echo.

if not exist "llamafile-0.10.5.exe" (
    echo [ERRO] llamafile nao encontrado.
    echo.
    echo Execute primeiro:
    echo instalar.bat
    echo.
    pause
    exit /b 1
)

if not exist "qwen3-4b-thinking-2507.Q4_K_M.gguf" (
    echo [ERRO] Modelo Qwen nao encontrado.
    echo.
    echo Execute primeiro:
    echo instalar.bat
    echo.
    pause
    exit /b 1
)

echo Modelo:
echo qwen3-4b-thinking-2507.Q4_K_M.gguf
echo.
echo Servidor:
echo http://127.0.0.1:8080
echo.
echo API:
echo http://127.0.0.1:8080/v1
echo.
echo ============================================================
echo INICIANDO IA...
echo ============================================================
echo.

"llamafile-0.10.5.exe" ^
    --server ^
    --model "qwen3-4b-thinking-2507.Q4_K_M.gguf" ^
    --host 127.0.0.1 ^
    --port 8080

echo.
echo ============================================================
echo SERVIDOR ENCERRADO
echo ============================================================
echo.

pause
```

### Resultado

O usuário baixa seu projeto e terá:

```text
CHAT-IA-USB/
│
├── instalar.bat
├── iniciar.bat
├── README.md
├── .gitignore
├── .gitattributes
│
├── llamafile-0.10.5.exe       ← baixado pelo instalar.bat
└── qwen3-4b-thinking-2507...  ← baixado pelo instalar.bat
```

O GitHub fica leve porque os dois arquivos grandes **não são versionados**.

Na primeira execução:

```text
instalar.bat
     ↓
Baixa llamafile 0.10.5 (~351 MB)
     ↓
Baixa Qwen GGUF (~2,5 GB)
     ↓
Instalação concluída
     ↓
iniciar.bat
     ↓
Qwen → 127.0.0.1:8080
```

Atenção: o arquivo do llamafile que a Mozilla publica nessa versão é um binário de aproximadamente 351 MB, portanto **não tente colocá-lo dentro do GitHub como arquivo normal**. ([Hugging Face][2])

E o modelo continua vindo diretamente do model card que você escolheu, em vez de ser redistribuído pelo seu repositório. Isso também deixa a atribuição correta. ([GitHub][1])

[1]: https://github.com/mozilla-ai/llamafile/blob/main/docs/quickstart.md?utm_source=chatgpt.com "llamafile/docs/quickstart.md at main · mozilla-ai/llamafile · GitHub"
[2]: https://huggingface.co/mozilla-ai/llamafile_0.10/blob/main/llamafile-0.10.5?utm_source=chatgpt.com "llamafile-0.10.5 · mozilla-ai/llamafile_0.10 at main"
