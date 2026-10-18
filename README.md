# Linyux OS — конфиг сборки live-build

Конфигурация образа **Linyux** для [live-build](https://live-team.pages.debian.net/live-build/).
Чистый GNOME на 32-битном Debian (i686) с полноценной установкой на жёсткий диск.

## Требования и где они реализованы

| # | Требование | Реализация |
|---|-----------|------------|
| 1 | Архитектура i686 (32-bit) | `auto/config`: `lb architecture i386`, `lb bootstrap-qemu-architecture i386`, `lb binary-images iso-hybrid`; `config/lb_architecture`; `config/architectures/bootloaders.cfg` |
| 2 | Установка на жёсткий диск | `auto/config`: `lb debian-installer enabled` + `lb debian-installer live` (`--debian-installer live`) |
| 3 | Минимальный старт (debootstrap) | `auto/config`: стандартный debootstrap (без variant-флагов) — сборка начинается с чистого Debian Minimal install |
| 4 | Локализация | По умолчанию `en_US.UTF-8` (`lb locale en_US.UTF-8`, `/etc/default/locale` в хуке). Хук `config/hooks/normal/0020-locales.hook.chroot` генерирует `en_US.UTF-8`, `ru_RU.UTF-8`, `tt_RU.UTF-8`. Дефолт пользователя + список доступных языков: `config/includes.chroot/etc/skel/.config/locales/user-file`. Шрифты: `fonts-dejavu`, `fonts-liberation` (`config/package-lists/linyux.base.list.chroot`) |
| 5 | Чистый GNOME | `config/package-lists/linyux.gnome.list.chroot`: только `gdm3`, `gnome-core`, `nautilus`, `gnome-terminal`, `gedit` (в bookworm это и есть gnome-text-editor), `gnome-control-center`, `network-manager-gnome`. Без игр и тяжёлого софта |
| 6 | Браузер | `firefox-esr` (`linyux.gnome.list.chroot`) |
| 7 | Программы | `htop`, `cava`, `xorg`, `fastfetch`, `gnome-system-monitor` (вместо mission-center) |

Базовые пакеты (ядро `linux-image-686-pae`, X, локали, шрифты, раскладки) —
в `config/package-lists/linyux.base.list.chroot`.

Дополнительное зеркало bookworm (для корректного resolvable-списка пакетов):
`config/archives/bookworm.d/debian.list`.

## Сборка

```bash
# внутри репозитория linyux
lb config        # применит auto/config автоматически
sudo lb build    # результат: гибрид-ISO (linyux-...-i386.hybrid.iso)
```

Либо явным прогоном скрипта с параметрами `lb config` напрямую:

```bash
./linyux-config.sh
sudo lb build
```

## Примечания

- Дистрибутив: **Debian 12 (bookworm)** — последняя стабильная ветка с полной
  поддержкой i386 и пакетами `fastfetch`, `cava`, `firefox-esr`.
- `iso-hybrid` — образ можно записать и на CD/DVD, и на USB.
- Установщик появляется в меню загрузчика («Install Linyux»); режим
  `debian-installer live` ставит систему с live-носителя на жёсткий диск.
- Переключение языка: GNOME Settings → Region & Language (или язык на экране
  входа GDM). Русский и татарский доступны сразу — локали сгенерированы при сборке.
