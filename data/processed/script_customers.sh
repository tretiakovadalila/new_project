#!/bin/bash
log_file="log.txt"
log() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$log_file"
}
if [ ! -f customers_processed.csv ]; then
	echo "Файл customers_processed.csv не найден."
	exit 1
fi
if [ $# -eq 0 ]; then
	log "Фильтр не указан."
	echo "Укажите хотя бы один фильтр, например: ./script_customers.sh Москва"
	exit 1
fi
for filter in "$@"; do
	count=$(grep -c "$filter" customers_processed.csv)
	if [ "$count" -ge 2 ]; then
	if echo "$filter" | grep -q "[0-9]"; then
		echo "Фильтр содержит цифры. Возможно, это возраст - указывайте точное значение."
		log "Фильтр '$filter' содержит цифры. Возможно, это возраст."
		continue
	fi
	count=$(grep -c "$filter" customers_processed.csv)
	if [ "$count" -gt 0 ]; then
		grep "$filter" customers_processed.csv > "filtered_${filter}.csv"
		msg="Сохранено в файл filtered_${filter}.csv"
		echo "$msg"
		log "$msg"
	else
		msg="Совпадений для фильтра '$filter' не найдено. Пропущено."
		echo "$msg"
		log "$msg"
	fi
done

