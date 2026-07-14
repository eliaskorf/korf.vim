---
title: Основные конфигурационные файлы
tags: [neovim, linux, конфиг]
created: 2025-04-05
author: korf
status: draft
---

# 📁 Шпаргалка: Основные конфигурационные файлы

> [!abstract] 
> Где что лежит, за что отвечает и как используется.  
> Актуально для macOS, Neovim, LSP, shell, Git, языков и проектов. 
---

## 🖥️ 1. Shell (bash / zsh)

| Файл | Путь | Назначение |
|------|------|-----------|
| `.bash_profile` | `~/.bash_profile` | Запускается при входе. Для `PATH`, `JAVA_HOME`, `export`. Только `bash`. |
| `.zshrc` | `~/.zshrc` | Основной конфиг `zsh`. Алиасы, `nvm`, `pyenv`. |
| `.bashrc` | `~/.bashrc` | Алиасы и функции. На macOS **не запускается без `source` из `.bash_profile`**. |
| `.profile` | `~/.profile` | Общий для всех shell. Реже используется. |


> [!tip] 
>  На macOS: если `zsh` — правь `~/.zshrc`. Если `bash` — `~/.bash_profile` + `source ~/.bashrc`. 

---

## 🔧 2. Утилиты и менеджеры

| Файл | Путь | Назначение |
|------|------|-----------|
| `.gitconfig` | `~/.gitconfig` | Глобальные настройки Git: имя, email, алиасы. |
| `.gitignore_global` | `~/.gitignore_global` | Глобальный `.gitignore` (`.DS_Store`, логи). |
| `.editorconfig` | `~/.editorconfig` или в корне | Отступы, окончания строк. |
| `.curlrc` | `~/.curlrc` | Настройки `curl` (`--location`). |
| `.wgetrc` | `~/.wgetrc` | Настройки `wget`. |

---

## 💻 3. Языки программирования

### Python
| Файл | Путь | Назначение |
|------|------|-----------|
| `pyproject.toml` | корень | Современный стандарт: зависимости, линтинг. |
| `setup.py` | корень | Устаревший способ описания пакета. |
| `.python-version` | корень | Версия Python для `pyenv`. |
| `requirements.txt` | корень | Зависимости (`pip install -r`). |

### Node.js / JavaScript
| Файл                | Путь   | Назначение                         |
| ------------------- | ------ | ---------------------------------- |
| `package.json`      | корень | Зависимости, скрипты, мета-данные. |
| `package-lock.json` | корень | Точные версии пакетов.             |
| `.nvmrc`            | корень | Версия Node.js для `nvm use`.      |
| `.eslintrc.json`    | корень | Настройки ESLint.                  |
| `.prettierrc`       | корень | Настройки Prettier.                |
| `.node-version`     | корень | Альтернатива `.nvmrc`.             |

### Rust
| Файл | Путь | Назначение |
|------|------|-----------|
| `Cargo.toml` | корень | Зависимости, имя пакета. |
| `Cargo.lock` | корень | Точные версии. |

### Go
| Файл | Путь | Назначение |
|------|------|-----------|
| `go.mod` | корень | Модуль, зависимости. |
| `go.sum` | корень | Проверка целостности. |

### Java / JVM
| Файл | Путь | Назначение |
|------|------|-----------|
| `pom.xml` | корень | Maven-проект. |
| `build.gradle` | корень | Gradle-проект. |
| `.jvmopts` | корень | Аргументы JVM (например, `-Xmx2g`). |

---

## 🛠️ 4. Инструменты разработки

| Файл | Путь | Назначение |
|------|------|-----------|
| `.gitignore` | корень | Файлы, исключённые из Git. |
| `.env` | корень | Переменные окружения (не в Git!). |
| `.env.local` | корень | Локальные переменные. |
| `Makefile` | корень | Скрипты сборки. |
| `Dockerfile` | корень | Описание контейнера. |
| `.dockerignore` | корень | Что не копировать в образ. |

---

## 🖋️ 5. Форматирование и линтинг

| Файл | Путь | Инструмент |
|------|------|-----------|
| `.editorconfig` | корень | Отступы, окончания строк |
| `.prettierrc` | корень | Prettier |
| `.eslintrc.json` | корень | ESLint |
| `.stylelintrc` | корень | Stylelint (CSS) |
| `.rubocop.yml` | корень | Ruby |
| `.flake8` | корень | Python |
| `.pylintrc` | корень | Pylint |
| `.luarc.json` | корень | Lua Language Server (Neovim) |
| `.textlsp.json` | корень | Настройки `textlsp` (язык, анализаторы) |
| `.languagetool.json` | корень | Настройки LanguageTool |

---

## 🖥️ 6. Neovim / LSP

| Файл | Путь | Назначение |
|------|------|-----------|
| `init.lua` | `~/.config/nvim/init.lua` | Главный конфиг Neovim. |
| `lua/` | `~/.config/nvim/lua/` | Модули (например, `opts.lua`, `plugins.lua`). |
| `.nvim.lua` | корень | Проект-специфичные настройки Neovim. |
| `.vimrc` | `~/.vimrc` | Старый конфиг Vim. |
| `.exrc` | корень | Локальные настройки Vim/Neovim (`:set exrc`). |

---

## 🌐 7. Сеть и SSH

| Файл | Путь | Назначение |
|------|------|-----------|
| `config` | `~/.ssh/config` | Алиасы, порты, ключи для SSH. |
| `id_rsa`, `id_ed25519` | `~/.ssh/` | Приватные ключи. |
| `known_hosts` | `~/.ssh/` | Известные хосты. |

---

## 🗂️ 8. macOS / Система

| Файл | Путь | Назначение |
|------|------|-----------|
| `~/Library/Preferences/` | папка | Настройки приложений (iTerm2, VS Code). |
| `~/Library/Application Support/` | папка | Данные приложений (DaVinci Resolve, Neovim). |
| `.DS_Store` | в каждой папке | Настройки отображения в Finder. |
| `.hushlogin` | `~/.hushlogin` | Отключает приветствие в терминале. |

---

## 🧩 9. Маркеры корня проекта

| Файл             | Зачем                                  |
| ---------------- | :------------------------------------- |
| `.git`           | Git-репозиторий — основной маркер      |
| `package.json`   | JS/TS-проект                           |
| `Cargo.toml`     | Rust                                   |
| `pyproject.toml` | Python                                 |
| `.nvmrc`         | Автозапуск нужной версии Node.js       |
| `.textlsp.json`  | Включает `textlsp` только здесь        |
| `.org-project`   | Искусственный маркер для Org-файлов    |
| `.nvim/`         | Папка с настройками Neovim для проекта |

---

## ⚠️ Поддержка Homebrew: Tier 3

Ты используешь **macOS 10.15 (Catalina)** — это **Tier 3** для Homebrew:

- ❌ Нет бинарных пакетов (bottles)
- ❌ `brew install openjdk` будет **собирать из исходников** (часто падает)
- ❌ Не рекомендуется для разработки

> [!tip] 
>  Решение: устанавливай JDK вручную через [Eclipse Temurin](https://adoptium.net) или [Azul Zulu](https://www.azul.com/downloads/).
---

