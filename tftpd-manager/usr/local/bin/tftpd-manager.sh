#!/bin/bash

CONF_FILE="/etc/default/tftpd-hpa"

get_status() {
    if systemctl is-active --quiet tftpd-hpa; then
        echo -e "Сервер: \e[32mВКЛЮЧЕН\e[0m"
    else
        echo -e "Сервер: \e[31mВЫКЛЮЧЕН\e[0m"
    fi
}

get_current_dir() {
    grep "TFTP_DIRECTORY" "$CONF_FILE" | cut -d'"' -f2
}

list_files() {
    local dir=$(get_current_dir)
    echo -e "\e[34mФайлы в ($dir):\e[0m"
    if [ -d "$dir" ]; then
        ls -F --color=always "$dir" | grep -v / || echo "  [Пуста]"
    else
        echo -e "\e[31m[!] Путь не найден\e[0m"
    fi
}

watch_log() {
    clear
    echo -e "\e[33m--- МОНИТОРИНГ (Ctrl+C для выхода) ---\e[0m"
    sudo journalctl -u tftpd-hpa -f -n 0 &
    LOG_PID=$!
    trap "kill $LOG_PID 2>/dev/null; trap - SIGINT" SIGINT
    wait $LOG_PID 2>/dev/null
}

open_mc() {
    local dir=$(get_current_dir)
    if [ -d "$dir" ]; then
        mc "$dir"
    else
        echo -e "\e[31mОшибка: Директория не найдена!\e[0m"
        sleep 2
    fi
}

while true; do
    clear
    echo "=========================================="
    echo "       TFTPD CONTROL PANEL"
    echo "=========================================="
    get_status
    list_files
    echo "------------------------------------------"
    echo " 1) СТАРТ               4) ИЗМЕНИТЬ ПУТЬ"
    echo " 2) СТОП                5) МОНИТОРИНГ"
    echo " 3) ПЕРЕЗАПУСК          6) ОТКРЫТЬ В MC (Root)"
    echo " 7) ВЫХОД"
    echo "------------------------------------------"
    read -p "Выбор: " choice

    case $choice in
        1) sudo systemctl start tftpd-hpa ;;
        2) sudo systemctl stop tftpd-hpa ;;
        3) sudo systemctl restart tftpd-hpa ;;
        4) 
            read -e -p "Новый путь: " new_dir
            if [ -d "$new_dir" ]; then
                sudo sed -i "s|TFTP_DIRECTORY=\".*\"|TFTP_DIRECTORY=\"$new_dir\"|" "$CONF_FILE"
                sudo chown -R tftp:tftp "$new_dir"
                echo -e "\e[33mПуть изменен. Не забудьте ПЕРЕЗАПУСТИТЬ сервер (п.3)\e[0m"
                sleep 2
            fi ;;
        5) watch_log ;;
        6) open_mc ;;
        7) exit 0 ;;
    esac
done
