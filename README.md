# Proyecto de Lex para la asignatura de MC de 2GII
###### Con esteanalizador pretendo hacer un estudio sobre los datos que se recogen en un sniffing básico de Ettercap

##1. Ettercap

La aplicación está basada en datos volcados por la aplicación de Ettercap, un sniffer de código libre. Para descargarlo en linux usaremos:

Instalar dependencias:
```
# apt-get install build-essential libtool libnet-dev libncurses5-dev libssl-dev \
libpcap-dev libgtk2.0-dev gawk flex bison checkinstall
```

Descargar y extraer paquete:
```
$ wget http://prdownloads.sourceforge.net/ettercap/ettercap-0.7.4.1.tar.gz
$ tar xvfz ./ettercap-0.7.4.1.tar.gz && cd ./ettercap
```

Configurar
```
$ ./configure --enable-debug
$ make
```

Hacer un paquete deb
```
$ checkinstall -D --install=no --pkgname ettercap --pkgversion 0 --pkgrelease 7.4.1 \
--maintainer "admin@example.com" --strip=no --stripso=no --addso=yes --nodoc
```

Instalar
```
# dpkg -i ettercap_0-7.4.1_amd64.deb
```

Ejecutar
```
$ ettercap -C
```

##2.Volcar los datos en un .txt
Usaremos los datos de ettercap que consigamos en un tiempo que queramos, para usamos la siguiente línea en una terminal:
```
$ sudo ettercap -T -i wlan0 > prueba.txt
```

##3.Usar prueba.txt para analizarlo
Para ello debemos general un ejecutable con el codigo de extensión .l

Los pasos para crearel ejecutable en base al archivo lex son:
```
$ lex proyecto.l
$ gcc lex.yy.c -o proyecto -ll
$ ./proyecto prueba.txt
```

Y finalmente nos devolverá el resultado.  
