# TFTP Server Control Panel
<img alt="Shell Script" src="https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white"/>  <img src="https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white">  <img src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white">  <img src="https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white">  <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black"> 

Универсальное интерактивное Bash-меню для управления TFTP-сервером. Позволяет забыть о ручном вводе команд в терминале и предоставляет удобный интерфейс для настройки путей, мониторинга логов и управления файлами.



```bash
==========================================
       TFTP SERVER CONTROL v1.2.0
==========================================
Статус: ВКЛЮЧЕН
Файлы в (/srv/tftp):
  owrt2410-wr1045ndv2_recovery.bin
  uboot_dump.bin
------------------------------------------
 1) СТАРТ               4) ИЗМЕНИТЬ ПУТЬ
 2) СТОП                5) МОНИТОРИНГ
 3) ПЕРЕЗАПУСК          6) ОТКРЫТЬ В MC
 7) ВЫХОД
------------------------------------------
Выбор:
```

## 🚀 Основные возможности
* Универсальность: Одинаковая работа на Debian, Ubuntu, ALT Linux, Fedora и Astra Linux.

* Прямое управление: Запуск `in.tftpd` напрямую с флагами `--listen` `--secure` `--verbose`, что гарантирует предсказуемость работы на любом дистрибутиве.

* Отображение файлов: Список файлов в рабочей директории выводится прямо в главном меню.

* Единый конфиг: Настройки пути сохраняются в `/etc/tftpd-manager.conf`.

* Безопасность: Скрипт проверяет наличие прав root при запуске и работает без лишних вызовов `sudo` внутри.

* Чистота системы: При установке менеджер отключает конфликтующие службы, а при удалении — возвращает штатный TFTP-сервер в режим автозапуска.

## 📦 Сборка и получение пакетов

Проект поддерживает автоматическую и ручную сборку пакетов для Debian (DEB), ALT Linux (RPM), Fedora (RPM) и универсальных архивов (TAR.GZ).

### 1. Готовые релизы (Рекомендуется)
Самый простой способ — перейти в раздел [Releases](https://github.com/withersky/tftpd-manager/releases) и скачать стабильную версию пакета для вашего дистрибутива. Каждая версия снабжена списком изменений.

### 2. Получение свежих сборок (GitHub Actions)
Если вам нужны пакеты из последнего коммита (даже если релиз еще не опубликован):
1. Перейдите на вкладку **Actions** в репозитории.
2. Выберите последний успешный запуск workflow **Build and Release**.
3. В нижней части страницы в разделе **Artifacts** скачайте архив `tftpd-manager-packages`.
4. Внутри архива вы найдете все 4 типа пакетов.
   
**P.S. Артефакты хранятся 30 дней после сборки и доступны только контрибьютерам репозитория!**

### 3. Ручная сборка локально
Если вы вносите правки в код и хотите собрать пакет самостоятельно:
```bash
git clone [https://github.com/withersky/tftpd-manager.git](https://github.com/withersky/tftpd-manager.git)
cd tftpd-manager
chmod +x build
./build
```

## 🛠 Зависимости
Программа автоматически использует следующие пакеты:

* `tftpd` или `tftp-server` (бинарник `in.tftpd`).

* `mc` (Midnight Commander).

* `systemd`, `grep`, `procps`.
  

📂 Структура проекта
* `usr/local/bin/tftpd-manager` — основной скрипт управления.

* `etc/tftpd-manager.conf` — конфигурационный файл (путь к папке).

* `usr/share/applications/tftpd-manager.desktop` — ярлык для графического меню.

* `DEBIAN/` — скрипты управления пакетом (Debian).

* `tftpd-manager.spec` — спецификация для сборки RPM.

## 🖥 Использование
### В терминале:
Для работы с сетевыми портами и системными конфигами запуск производится через `sudo`:
```Bash
sudo tftpd-manager
```

### Через меню приложений:
Найдите `TFTP Server Control`. При запуске система запросит пароль через `pkexec`.
