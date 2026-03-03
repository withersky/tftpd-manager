#!/bin/bash

PKG_DIR="tftpd-manager"
CONTROL="$PKG_DIR/DEBIAN/control"

if [ ! -f "$CONTROL" ]; then
    echo "Ошибка: Файл control не найден!"
    exit 1
fi

NAME=$(grep "^Package:" "$CONTROL" | cut -d' ' -f2)
VERSION=$(grep "^Version:" "$CONTROL" | cut -d' ' -f2)
ARCH=$(grep "^Architecture:" "$CONTROL" | cut -d' ' -f2)

DEB_NAME="${NAME}_${VERSION}_${ARCH}.deb"
TAR_NAME="${NAME}_${VERSION}.tar.gz"

echo "--- Начинаю сборку версии $VERSION ---"

dpkg-deb --build "$PKG_DIR" "$DEB_NAME"
if [ $? -eq 0 ]; then
    echo -e "\e[32m[OK] Создан пакет: $DEB_NAME\e[0m"
else
    echo -e "\e[31m[FAIL] Ошибка сборки DEB\e[0m"
fi

tar -czf "$TAR_NAME" -C "$PKG_DIR" usr
if [ $? -eq 0 ]; then
    echo -e "\e[32m[OK] Создан архив: $TAR_NAME\e[0m"
else
    echo -e "\e[31m[FAIL] Ошибка сборки TAR.GZ\e[0m"
fi

echo "---------------------------------------"
