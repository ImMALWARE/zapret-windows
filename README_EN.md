# A build of https://github.com/bol-van/zapret for Windows
[README на русском](https://github.com/ImMALWARE/zapret-windows/blob/master/README.md)

1. Download the archive: https://github.com/ImMALWARE/zapret-windows/releases/latest/download/zapret.zip
2. Unpack it into a folder (e.g., C:\zapret)

**start_now.cmd** — Runs the program in a window, zapret will be active as long as the command prompt window is open.

**start_stop_service.cmd** — Creates or deletes the service. When the service is created, zapret will run in the background (without a window) and will start automatically with Windows.

**autohosts.txt** — A list of domains for blocked sites. There must be an empty line at the end of the file.

**ipset.txt** — A list of blocked IP-addresses and CIDR.

**check.cmd** — Checks access to the sites listed in `autohosts.txt`.

**ignore.txt** — A list of domains for unblocked sites. If an unblocked site isn't working, add its domain here.

**config.txt** — The config file. Use {variables} instead of file paths.

## Variables in config.txt

`{hosts}` — Substitutes the path to `autohosts.txt`.

`{ipset}` — Substitutes the path to `ipset.txt`.

`{ignore}` — Substitutes the path to `ignore.txt`.

`{youtube}` — Substitutes the path to `youtube.txt`.

`{quicgoogle}` — Substitutes the path to `system\quic_initial_www_google_com.bin`.

`{tlsgoogle}` — Substitutes the path to `system\tls_clienthello_www_google_com.bin`.

## How to use on Windows 7?
To make zapret work on Windows 7, you need to disable driver signature verification. To do this, [run the following commands in a command prompt as an administrator](https://wiki.malw.link/windows/run) and then reboot your system:

```
bcdedit.exe -set loadoptions DISABLE_INTEGRITY_CHECKS
bcdedit.exe -set TESTSIGNING ON
```
After rebooting, zapret should work correctly.