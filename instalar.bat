@echo off
setlocal EnableExtensions EnableDelayedExpansion

title CHAT-IA-USB - Instalador

cd /d "%~dp0"

echo ==========================================
echo        CHAT-IA-USB - INSTALADOR
echo ==========================================
echo.
echo Diretorio de instalacao:
echo %CD%
echo.

set "LLAMAFILE_FILE=llamafile-0.10.5.exe"
set "MODEL_FILE=qwen3-4b-thinking-2507.Q4_K_M.gguf"

set "LLAMAFILE_URL=https://github.com/mozilla-ai/llamafile/releases/download/0.10.5/llamafile-0.10.5.exe"

set "MODEL_URL=https://huggingface.co/pramodlohra/Qween3_4B_thinking_finetune/resolve/main/qwen3-4b-thinking-2507.Q4_K_M.gguf?download=true"

echo [1/7] Verificando Windows...
ver
echo OK.
echo.

echo [2/7] Verificando CURL...
where curl.exe >nul 2>&1

if errorlevel 1 (
    echo [ERRO] CURL nao encontrado.
    echo.
    echo O Windows precisa do CURL para realizar os downloads.
    echo.
    pause
    exit /b 1
)

echo CURL encontrado.
echo.

echo [3/7] Verificando espaco disponivel...
for /f "tokens=3" %%A in ('dir /-C "%CD%" ^| findstr /C:"bytes free"') do set "FREE=%%A"

echo Espaco livre:
echo %FREE% bytes
echo.

echo [4/7] Baixando llamafile 0.10.5...
echo.

if exist "%LLAMAFILE_FILE%" (
    echo llamafile ja existe.
) else (
    curl.exe -L --fail --retry 3 --retry-delay 2 ^
        -o "%LLAMAFILE_FILE%" ^
        "%LLAMAFILE_URL%"

    if errorlevel 1 (
        echo.
        echo [ERRO] Falha ao baixar o llamafile.
        echo.
        pause
        exit /b 1
    )
)

echo.
echo llamafile OK.
echo.

echo [5/7] Baixando modelo Qwen3 4B...
echo.
echo Arquivo:
echo %MODEL_FILE%
echo.
echo Este download pode demorar dependendo da velocidade da Internet.
echo.

if exist "%MODEL_FILE%" (
    echo Modelo ja existe.
) else (
    curl.exe -L --fail --retry 3 --retry-delay 3 ^
        -o "%MODEL_FILE%" ^
        "%MODEL_URL%"

    if errorlevel 1 (
        echo.
        echo [ERRO] Falha ao baixar o modelo Qwen.
        echo.
        echo Verifique sua conexao com a Internet.
        pause
        exit /b 1
    )
)

echo.
echo Modelo OK.
echo.

echo [6/7] Validando arquivos...
echo.

if not exist "%LLAMAFILE_FILE%" (
    echo [ERRO] llamafile nao encontrado.
    pause
    exit /b 1
)

if not exist "%MODEL_FILE%" (
    echo [ERRO] Modelo nao encontrado.
    pause
    exit /b 1
)

for %%A in ("%LLAMAFILE_FILE%") do set "LLAMA_SIZE=%%~zA"
for %%A in ("%MODEL_FILE%") do set "MODEL_SIZE=%%~zA"

if "!LLAMA_SIZE!"=="0" (
    echo [ERRO] O llamafile possui tamanho zero.
    pause
    exit /b 1
)

if "!MODEL_SIZE!"=="0" (
    echo [ERRO] O modelo possui tamanho zero.
    pause
    exit /b 1
)

echo llamafile:
echo !LLAMA_SIZE! bytes
echo.

echo modelo:
echo !MODEL_SIZE! bytes
echo.

echo Validacao concluida.
echo.

echo [7/7] Instalacao concluida!
echo.
echo ==========================================
echo          CHAT-IA-USB PRONTO
echo ==========================================
echo.
echo Arquivos instalados:
echo.
echo [OK] %LLAMAFILE_FILE%
echo [OK] %MODEL_FILE%
echo.
echo Para iniciar a IA execute:
echo.
echo     iniciar.bat
echo.
echo Servidor local:
echo.
echo     http://127.0.0.1:8080
echo.
echo A configuracao padrao utiliza somente
echo o computador local.
echo.
echo Nenhuma regra de firewall foi criada.
echo.
pause

exit /b 0