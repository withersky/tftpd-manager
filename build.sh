#!/bin/bash

# Путь к файлу control
CONTROL_FILE="tftpd-manager/DEBIAN/control"

# Извлекаем версию из файла control
VERSION=$(grep "^Version:" "$CONTROL_FILE" | awk '{print $2}')
PACKAGE_NAME=$(grep "^Package:" "$CONTROL_FILE" | awk '{print $2}')
ARCH=$(grep "^Architecture:" "$CONTROL_FILE" | awk '{print $2}')

# Формируем имя файла по стандартам Debian: имя_версия_архитектура.deb
DEB_FILE="${PACKAGE_NAME}_${VERSION}_${ARCH}.deb"

echo "Сборка пакета: $PACKAGE_NAME версии $VERSION..."

# Собираем пакет
dpkg-deb --build tftpd-manager "$DEB_FILE"

if [ $? -eq 0 ]; then
    echo "-------------------------------------------"
    echo -e "\e[32mУспешно! Файл создан: $DEB_FILE\e[0m"
    echo "-------------------------------------------"
else
    echo -e "\e[31mОшибка при сборке пакета.\e[0m"
    exit 1
fi
