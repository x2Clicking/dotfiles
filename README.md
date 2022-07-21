# ARCH LINUX INSTALACION

## Particionado
Ejecutamos lsblk para ver los discos / particiones que tenemos en  nuestro equipo.
![](https://i.imgur.com/jve2Mb0.png)
 
Despues buscamos el disco que su tipo es EFI System, para comprobar esto podemos ejecutar fdisk -l.

![](https://i.imgur.com/r1uFYZo.png)

Seleccionamos el disco que queramos particionar: `fdisk /dev/nvme0n1`
Crearemos 2 particiones , una la crearemos para el Swap y otra para el boot , porque para el efi ya contamos con una.

* Por ejemplo : 
    * Swapfile 2GB
    * Boot (/) 300GB

## Formateado Particiones
Convertimos la particion en formato ext4 con el siguiente comando: `mkfs.ext4 /dev/{Disco}`

## Montaje de Particiones

**La particion que usaremos para el swap lo dejamos para mas adelante.**

Vamos a montar la particion root (/), para ello con lsblk buscaremos que particiones tenemos y nos quedamos con su nombre , en mi caso es /dev/nvme0n1p6 asi que ejecutamos el siguiente comando : `mount /dev/nvme0n1p6 /mnt`

Despues crearemos dos carpetas (boot y dentro de esta creamos una carpeta llamada EFI) en /mnt , por lo cual nos quedaria `/mnt/boot` y `/mnt/boot/EFI`

Ahora procederemos a montar la carpeta EFI en la particion que anteriormente hemos guardado.. `mount /dev/nvme0n1p1 /mnt/boot/EFI`


# Instalacion Base
Ahora procederemos a instalar los paquetes base con : `pacstrap /mnt base linux linux-firmware nano`
Despues generamos nuestro archivo fstab: `genfstab -U /mnt >> /mnt/etc/fstab`
Una vez hecho esto cambiamos de directorio raiz con `arch-chroot /mnt`

# Swap File

Para montar nuestro Swapfile primero deberemos crearlo con : `mkswap /dev/nvme0n1p4`
Luego activamos el swap mediante el comando : `swapon /dev/nvme0n1p4`

Para que estos cambios se queden de forma persistente deberemos modificar nuestro archivo fstab que se encuentra en /etc/fstab con nuestro editor preferido.

Agregaremos al final del archivo fstab lo siguiente: `/dev/nvme0n1p4 none swap defaults 0 0`


# TimeZone

Para cambiar la zona horaria creamos un enlace simbolico mediante el siguiente comando: `ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime`
Y despues ejecutamos : `hwclock --systohc & timedatectl set-ntp true`

# Idioma

Para cambiar el idioma de nuestro sistema tendremos que modificar /etc/locale.gen y selecionamos el idioma que queremos en mi caso es_ES.UTF-8 y lo desmarcamos.

Despues creamos el archivo /etc/locale.conf y agregamos LANG=es_ES.UTF-8 y lo guardamos.

Despues para acabar la configuracion y que nos genere el idioma usamos locale-gen

# Hostname 

Accedemos a /etc/hostname y ponemos el hostname que nosotros queremos por ejemplo `arch`, despues modificamos /etc/hosts y agregamos lo siguiente : 

```
127.0.0.1     localhost
::1           localhost
127.0.0.1     arch.localdomain    arch
```

**NO OLVIDARSE DE ESTO**
Para cambiar la contraseña del **root** ejecutamos passwd y ponemos la contraseña que deseamos.

# Install Boot Loader

1) Instalamos los paquetes base
`pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant os-prober mtools dosfstools base-devel linux-headers`

2) Instalamos el GRUB

    __Con Secureboot y TPM__
    Al realizar la instalacion con secureboot deberemos agregar el archivo .EFI a la UEFI/BIOS (Busca en internet como hacerlo , depende de tu placa)
    `grub-install --target=x86_64-efi --modules="tpm" --disable-shim-lock --efi-directory=/boot/efi --bootloader-id=GRUB`
    
    __Sin secureboot__
    `grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB`


    Para no recibir el error GRUB_DISABLE_OS_PROBER modificaremos el archivo GRUB.cfg que se encuentra en `/etc/defaults/grub` y desmarcamos la opcion GRUB_DISABLE_OS_PROBER=FALSE, despues creamos la config mediante `grub-mkconfig -o /boot/grub/grub.cfg`
    
    ![](https://i.imgur.com/J2eMvEZ.png)
    
    Si deseamos que se inicie por defecto windows dejaremos la configuracion tal cual esta , en cambio si queremos que se inicie por defecto linux cambiaremos el siguiente parametro : 
    
    ![](https://i.imgur.com/cITlnuB.png)

    Aqui podremos cambiar tambien el delay con el que el GRUB iniciara automaticamente el sistema si no lo hemos cambiado, en mi caso es 15s pero por defecto vendran 5



Una vez comprobado que nos ha detectado nuestro otro sistema operativos procedemos a salir de la instalacion , mediante los comandos :`exit` y `umount -a `

Una vez ejecutados todos estos comandos reiniciamos la maquina y quitamos el pincho.

# Activar Internet

Anteriormente hemos instalado un paquete llamado NetworkManager , ahora para poder tener conexion a internet debemos activarlo mediante el comando:  

`sudo systemctl enable NetworkManager`
`sudo systemctl start NetworkManager`

Una vez ejecutados estos comandos podemos comprobar que el equipo a sido asignado con una direccion ip mediante el comando : `ip a`

# New User 
Para crear un usuario lo primero que hacemos es lo siguiente : 
```
pacman --sync sudo 
useradd --create-home nombre
passwd nombre
usermod --append --groups wheel nombre
```

Para añadirlo al grupo de sudoers ejecutas lo siguiente->`EDITOR=NANO visudo` y buscamos `%wheel ALL=(ALL) ALL` y lo desmarcamos, si queremos que al ejecutar sudo nos pida la contraseña que tenemos asignada con el usuario root desmarcaremos la siguiente opcion `defaults targetpw

# Desktop Personalizacion

Empezamos instalando los siguientes paquetes : 

```
sudo pacman -S xorg-server xorg-xinit
sudo pacman -S python python-setuptools python-pip
sudo pacman -S qtile lightdm lightdm-gtk-greeter xterm
sudo systemctl enable lightdm
sudo pacman -S alacritty nvidia nvidia-settings firefox git rofi nitrogen thunar picom

mv /etc/X11/xinit/xinitrc .xsession
chmod 755 .xsession 
```

# Configuracion de pantalla

Primero que nada editamos en `/etc/lightdm/lightdm.conf` lo siguiente en el apartado de [LIGHTDM]:

`logind-check-graphical=true`

Y ejecutamos lo siguiente : 
```
sudo nvidia-xconfig

```
Reiniciamos la maquina y ejecutamos lo siguiente 

```
sudo nvidia-settings 
```
cambiamos los ajustes de las pantallas y lo guardamos en la config X


# Lighdm Config

Por defecto en el panel de login de lightdm usaremos la layout US para cambiarlo deberemos usar el siguiente comando
```
sudo localectl set-x11-keymap es
```

# Configuracion de pantalla de inicio

Instalamos lightdm-slick-greeter con :
```
pacman -S lightdm-slick-greeter

```
despues lo agregamos en /etc/lightdm/lighdm.conf en "greeter-session" en el apartado [Seat:*]

Despues creamos el archivo de config :
```
sudo nvim /etc/lightdm/slick-greeter.conf
```
Agregamos este contenido al archivo : 

```
# LightDM GTK+ Configuration
# Available configuration options listed below.
#
# activate-numlock=Whether to activate numlock. This features requires the installation of numlockx. (true or false)
# background=Background file to use, either an image path or a color (e.g. #772953)
# background-color=Background color (e.g. #772953), set before wallpaper is seen
# draw-user-backgrounds=Whether to draw user backgrounds (true or false)
# draw-grid=Whether to draw an overlay grid (true or false)
# show-hostname=Whether to show the hostname in the menubar (true or false)
# show-power=Whether to show the power indicator in the menubar (true or false)
# show-a11y=Whether to show the accessibility options in the menubar (true or false)
# show-keyboard=Whether to show the keyboard indicator in the menubar (true or false)
# show-clock=Whether to show the clock in the menubar (true or false)
# show-quit=Whether to show the quit menu in the menubar (true or false)
# logo=Logo file to use
# other-monitors-logo=Logo file to use for other monitors
# theme-name=GTK+ theme to use
# icon-theme-name=Icon theme to use
# font-name=Font to use
# xft-antialias=Whether to antialias Xft fonts (true or false)
# xft-dpi=Resolution for Xft in dots per inch
# xft-hintstyle=What degree of hinting to use (hintnone/hintslight/hintmedium/hintfull)
# xft-rgba=Type of subpixel antialiasing (none/rgb/bgr/vrgb/vbgr)
# onscreen-keyboard=Whether to enable the onscreen keyboard (true or false)
# high-contrast=Whether to use a high contrast theme (true or false)
# screen-reader=Whether to enable the screen reader (true or false)
# play-ready-sound=A sound file to play when the greeter is ready
# hidden-users=List of usernames that are hidden until a special key combination is hit
# group-filter=List of groups that users must be part of to be shown (empty list shows all users)
# enable-hidpi=Whether to enable HiDPI support (on/off/auto)
# only-on-monitor=Sets the monitor on which to show the login window, -1 means "follow the mouse"
# stretch-background-across-monitors=Whether to stretch the background across multiple monitors (false by default)
# clock-format=What clock format to use (e.g., %H:%M or %l:%M %p)
[Greeter]
```
Al insertar imagenes deben ser guardadas en /usr/share/pixmaps/
