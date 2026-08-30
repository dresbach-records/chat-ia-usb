@echo off
title CHAT-IA-USB - Qwen 3 4B

cd /d "%~dp0"

echo ==========================================
echo        CHAT-IA-USB - QWEN 3 4B
echo ==========================================
echo.
echo Pasta: %CD%
echo.
echo Iniciando modelo...
echo.

llamafile-0.10.5.exe --server --model "qwen3-4b-thinking-2507.Q4_K_M.gguf" --host 127.0.0.1 --port 8080

echo.
echo O servidor foi encerrado.
pause