                 /*----- Seccion de Declaraciones --------------*/
%{
#include <stdio.h>
#include <string.h>

int con1,con2,udpc,tcpc,petic,mozc,con3,asc,apc,petc;

char **fechas, **ip, **mac, **copia, **proto, **plug;

int tfechas, tip, tmac, cfechas, cip, cmac, cproto, cplug, tproto, tplug;

void guardar_datos(int num_expresion);
void escribir_datos(int num_expresion);
void liberar_memoria();
void au();

%}


proto    [0-9]+" protocol dissectors"
fecha	 [0-9]+" ports monitored"
plug     [0-9]+" plugins"
peti     "NOTIFY * HTTP"
udp      "UDP"
tcp      "TCP"
AP       "AP"
AS       "AS"
Goo      "Google Chrome"
Moz      "Mozilla"
ip	     [0-9][0-9]*[0-9]*[.][0-9][0-9]*[0-9]*[.][0-9][0-9]*[0-9]*[.][0-9][0-9]*[0-9]*[:][0-9][0-9]*[0-9]*[0-9]*
mac	     [0-9A-Z][0-9A-Z][:][0-9A-Z][0-9A-Z][:][0-9A-Z][0-9A-Z][:][0-9A-Z][0-9A-Z][:][0-9A-Z][0-9A-Z][:][0-9A-Z][0-9A-Z]
resto    (.|\n)

%%
                 /*----- Seccion de Reglas ----------------*/

{fecha}			{guardar_datos(1);}
{plug}			{guardar_datos(4);}
{proto}			{guardar_datos(5);}
{ip}		    {guardar_datos(2);con2++;}
{mac}	      {guardar_datos(3);}
{Goo}       {con1++;}
{Moz}       {mozc++;}
{tcp}       {tcpc++;}
{udp}       {udpc++;}
{AS}        {asc++;}
{AP}        {apc++;}
{peti}      {petc++;}
{resto}     {;}


%%
                /*----- Seccion de Procedimientos --------*/
              /*  void au()
                {
                  con1++;
                }*/
                void guardar_datos(int num_expresion){
                	switch(num_expresion){
                		case 1:
                			if(cfechas>=10)
                      {
                				tfechas+=(tfechas/2);
                				copia=(char**)realloc(fechas,tfechas*sizeof(char*));
                				fechas=copia;
                			}
                			fechas[cfechas]=malloc(strlen(yytext)+1);
                			strcpy(fechas[cfechas],yytext);
                			cfechas++;
                			break;
                		case 2:
                			if(cip>=10)
                      {
                				tip+=(tip/2);
                				copia=(char**)realloc(ip,tip*sizeof(char*));
                				ip=copia;
                			}
                			ip[cip]=malloc(strlen(yytext)+1);
                			strcpy(ip[cip],yytext);
                			cip++;
                      if(ip[cip-1]!=ip[cip])
                      {
                        con3++;
                      }
                			break;
                		case 3:
                			if(cmac>=10)
                      {
                				tmac+=(tmac/2);
                				copia=(char**)realloc(mac,tmac*sizeof(char*));
                				mac=copia;
                			}
                			mac[cmac]=malloc(strlen(yytext)+1);
                			strcpy(mac[cmac],yytext);
                			cmac++;
                			break;
                    case 4:
                      if(cplug>=10)
                      {
                        tplug+=(tplug/2);
                        copia=(char**)realloc(plug,tplug*sizeof(char*));
                        plug=copia;
                      }
                      plug[cplug]=malloc(strlen(yytext)+1);
                      strcpy(plug[cplug],yytext);
                      cplug++;
                      break;
                    case 5:
                    if(cproto>=10)
                    {
                      tproto+=(tproto/2);
                      copia=(char**)realloc(proto,tproto*sizeof(char*));
                      proto=copia;
                    }
                    proto[cproto]=malloc(strlen(yytext)+1);
                    strcpy(proto[cproto],yytext);
                    cproto++;
                    break;

                	}
                }

                void escribir_datos(int num_expresion){
                	int i;

                	switch(num_expresion){
                		case 1:
                			printf("\nNúmero de veces que sale protocolo TCP:\n");
                				printf("\t%i\n",tcpc);
                      printf("\nNúmero de veces que sale protocolo UDP:\n");
                        printf("\t%i\n",udpc);
                        printf("\nPetición standard UPnP:\n ");
                          printf("\t%i\n",petc);

                      printf("\nNúmero de veces que sale paquete tipo A(ck)S(yn):\n");
                        printf("\t%i\n",asc);

                        printf("\nNúmero de veces que sale paquete tipo A(ck)P(ush):\n");
                          printf("\t%i\n",apc);
                          break;
                		case 2:
                			printf("\nIPs encontradas:\n");
                			for (i=0;i<cip;i++)
                				printf("\t%s\n",ip[i]);
                		  	break;
                		case 3:
                      printf("\nMAC encontrados:\n");
                      for (i=0;i<cmac;i++)
                        printf("\t%s\n",mac[i]);
                        break;
                    case 4:
                      printf("\nVeces que se ha usado USER AGENT de Google Chrome:\n");
                      printf("\t%i\n",con1);
                      printf("\nVeces que se ha usado USER AGENT de Mozilla:\n");
                      printf("\t%i\n",mozc);
                      break;

                    case 5:
                      printf("\nNúmero de IPs capturadas:\n");
                      printf("\t%i\n",con2);
                      break;

                    case 6:
                      printf("\nOtros datos de interés:\n\n");
                      for (i=0;i<cfechas;i++)
                      {
                        printf("\t%s\n",fechas[i]);
                      }
                      for (i=0;i<cproto;i++)
                      {
                        printf("\t%s\n",proto[i]);
                      }
                      for (i=0;i<cplug;i++)
                      {
                        printf("\t%s\n",plug[i]);
                      }
                      printf("\n\n");

                      break;
                    case 7:
                      printf("\nPaquetes AS: \n");
                      printf("\t%i\n",asc);
                      printf("\nPaquetes AP: \n");
                      printf("\t%i\n",apc);

                      break;

                	}
                }

                void liberar_memoria(){
                	int i;

                	for (i=0;i<tfechas;i++)
                		free(fechas[i]);

					for (i=0;i<tproto;i++)
						free(proto[i]);

					for (i=0;i<tplug;i++)
						free(plug[i]);

                	for (i=0;i<tip;i++)
                		free(ip[i]);

                	for (i=0;i<tmac;i++)
                		free(mac[i]);


                	free(fechas);
                	free(ip);
                	free(mac);
                  free(plug);
                  free(proto);

                }

                void inicio()
                {
                  printf("\nResultados de Unified Sniffing con ETTERCAP:\n\n");
                }

int main (int argc, char *argv[]){
  if (argc == 2)
  {
    yyin = fopen (argv[1], "rt");

    if (yyin == NULL)
    {
      printf ("El fichero %s no se puede abrir\n", argv[1]);
      exit (-1);
    }
  }
  else yyin = stdin;

  tfechas=tip=tmac=10;

  fechas=(char**)malloc(tfechas*sizeof(char*));
  ip=(char**)malloc(tip*sizeof(char*));
  mac=(char**)malloc(tmac*sizeof(char*));
  proto=(char**)malloc(tproto*sizeof(char*));
  plug=(char**)malloc(tplug*sizeof(char*));

  tcpc=udpc=0;

  cfechas=cip=cmac=cplug=cproto=0;

  yylex();

  inicio();
  escribir_datos(1);
  escribir_datos(2);
  escribir_datos(3);
  escribir_datos(4);
  escribir_datos(5);
  //escribir_datos(7);
  escribir_datos(6);

  liberar_memoria();

  return 0;
}
