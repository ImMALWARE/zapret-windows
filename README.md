# Сборка https://github.com/bol-van/zapret для Windows

1. Скачиваем архив: https://github.com/ImMALWARE/zapret-windows/releases/download/8/zapret.zip
2. Распаковываем в какую-нибудь папку (например, C:\zapret)

**start_now.cmd** — запустить в окне, блокировки будут обходиться пока открыта командная строка

**start_stop_service.cmd** — создать или удалить службу. При создании службы, zapret будет запущен без окна и будет автоматически запускаться при запуске Windows.

**autohosts.txt** — список доменов заблокированных сайтов. Обязательно должна быть пустая строка в конце файла.

**check.cmd** — проверить доступ к сайтам из autohosts.txt.

**ignore.txt** — список доменов незаблокированных сайтов. Если не работает незаблокированный сайт, добавьте его домен сюда.

**cofig.txt** — конфиг winws. Вместо путей к файлам используйте {переменные}.

## Переменные в config.txt

`{hosts}` — подставит путь к autohosts.txt

`{ignore}` — подставит путь к ignore.txt

`{youtube}` — подставить путь к youtube.txt

`{quicgoogle}` — подставит путь к system\quic_initial_www_google_com.bin

`{tlsgoogle}` — подставит путь к system\tls_clienthello_www_google_com.bin

## Как использовать на Windows 7?
Чтобы zapret работал на Windows 7, необходимо отключить проверку подписи драйверов. Для этого выполните команды в командной строке от имени администратора и перезагрузите систему:

```
bcdedit.exe -set loadoptions DISABLE_INTEGRITY_CHECKS
bcdedit.exe -set TESTSIGNING ON
```
После перезагрузки, zapret должен работать корректно.