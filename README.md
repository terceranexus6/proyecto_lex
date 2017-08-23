# Proyecto de Lex para la asignatura de MC de 3GII
###### Con este analizador pretendo hacer un estudio sobre los datos que se recogen en un sniffing básico de Ettercap.

## 1. Instalando dependencias

La aplicación está basada en datos volcados por Ettercap, un sniffer de código libre. Para descargarlo en linux primero debemos instalar sus dependencias:
```
# apt-get install build-essential libtool libnet-dev libncurses5-dev libssl-dev \
libpcap-dev libgtk2.0-dev gawk flex bison checkinstall
```

Descargar y extraer paquete:
```
$ wget http://prdownloads.sourceforge.net/ettercap/ettercap-0.7.4.1.tar.gz
$ tar xvfz ./ettercap-0.7.4.1.tar.gz && cd ./ettercap
```

Configurar:
```
$ ./configure --enable-debug
$ make
```

Hacer un paquete deb:
```
$ checkinstall -D --install=no --pkgname ettercap --pkgversion 0 --pkgrelease 7.4.1 \
--maintainer "admin@example.com" --strip=no --stripso=no --addso=yes --nodoc
```

Instalar:
```
# dpkg -i ettercap_0-7.4.1_amd64.deb
```

Ejecutar:
```
$ ettercap -C
```

## 2. Ejecución
### 2.1. Generación de datos
Usaremos los datos de ettercap que consigamos durante el tiempo que queramos, para usamos la siguiente línea en una terminal:
```
$ sudo ettercap -T -i wlan0 > prueba.txt
```

### 2.2. Compilación y análisis de datos
Para ello debemos generar un ejecutable usando el código de extensión .l

Los pasos para compilar y ejecutar el programa en base al archivo lex son:
```
$ lex proyecto.l
$ gcc lex.yy.c -o proyecto -ll
$ ./proyecto prueba.txt
```

Y finalmente nos devolverá el resultado.

![Alt Text](https://github.com/terceranexus6/proyecto_lex/blob/master/images/capt.jpg)

### 2.3. NUEVO: SCRIPT
He añadido recientemente un script que realiza la captura y muestra el resultado solo.

```
$ sudo ./captura.sh
```
También tenemos la opción de sniffeo rápido, para una catura más limitada de datos.
```
$ sudo ./sniffeo_rapido.sh
```
> IMPORTANTE: Para que funcione debe haberse realizado la compilación del código y el ejecutable debe llamarse 'proyecto'


## 3. Extra: Concepto de Sniffing, tipos de paquetes y Protocolos.

### 3.1. Sniffing
Los datos recogidos y analizados son posibles gracias a algo llamado Sniffing. El Sniffing permite “escuchar” las diversas comunicaciones que se establecen entre ordenadores a través de una red (física o inalámbrica) sin necesidad de acceder física ni virtualmente a su ordenador.

### 3.2. Paquetes
Los tipos de paquetes posibles son:

| Abreviatura | Descripción |
|----|--
| S | SYN (petición de conexión) |
| A | ACK (anterior paquete recibido) |
| P | PUSH |
| R | RESET (conexión cortada abruptamente) |
| F | FIN (conexión cortada de forma normal) |
| U | URGENT |

### 3.3. Protocolos
Encontraremos dos protocolos: TCP y UDP

1. UDP
>UDP es un protocolo no orientado a conexión. Es decir cuando una maquina A envía paquetes a una maquina B, el flujo es unidireccional.

2. TCP
>Contrariamente a UDP, el protocolo TCP está orientado a conexión. Cuando una máquina A envía datos a una máquina B, la máquina B es informada de la llegada de datos, y confirma su buena recepción.
