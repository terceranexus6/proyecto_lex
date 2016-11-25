# Proyecto de Lex para la asignatura de MC de 3GII
###### Con este analizador pretendo hacer un estudio sobre los datos que se recogen en un sniffing básico de Ettercap

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

![Alt Text](https://github.com/terceranexus6/proyecto_lex/blob/master/images/photo_2016-11-12_17-59-21.jpg)

##NUEVO: SCRIPT
He añadido recientemente un script que realiza la captura y muestra el resultado solo. 

```
$ sudo ./captura.sh
```

## Por programar:
Aún está en proceso. Pretendo añadir una norma para analizar los protocolos y los tipos de paquetes.  

## Extra: Concepto de Sniffing, tipos de paquetes y Protocolos. 

##1.Sniffing
Los datos recogidos y analizados son posibles gracias a algo llamado Sniffing. Ésto es “escuchar” las diversas comunicaciones que se establecen entre ordenadores a través de una red (física o inalámbrica) sin necesidad de acceder física ni virtualmente a su ordenador.

##2.Paquetes 
Los tipos de paquetes posibles son:
S = SYN (petición de conexión)
A = ACK (anterior paquete recibido)
P = PUSH 
R = RESET (conexión cortada abruptamente)
F = FIN (conexión cortada de forma normal)
U = URGENT 

##3.Protocolos
Encontraremos dos protocolos: TCP y UDP

1. UDP
>UDP es un protocolo no orientado a conexión. Es decir cuando una maquina A envía paquetes a una maquina B, el flujo es unidireccional.

2. TCP
>Contrariamente a UDP, el protocolo TCP está orientado a conexión. Cuando una máquina A envía datos a una máquina B, la máquina B es informada de la llegada de datos, y confirma su buena recepción.
