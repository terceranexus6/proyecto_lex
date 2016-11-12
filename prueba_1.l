                 /*----- Seccion de Declaraciones --------------*/
%{
#include <stdio.h>
#include <string.h>


char **fechas, **ip, **mac, **copia;

int tfechas, tip, tmac, cfechas, cip, cmac;

void guardar_datos(int num_expresion);
void escribir_datos(int num_expresion);
void liberar_memoria();

%}

fecha		 (0[1-9]|[1-2][0-9]|3[0-1])[-\/](0[1-9]|1[0-2])[-\/][0-9][0-9]
ip	     [0-9][0-9][0-9][.][0-9][0-9][.][0-9][0-9][0-9][.][0-9][0-9]
mac	     [0-9][0-9][:][0-9][0-9][:][0-9][0-9][:][0-9][0-9][:][0-9][0-9][:][0-9][0-9]
resto		 [a-zA-Z0-9\n]+|[^a-zA-Z0-9\n]+

%%
                 /*----- Seccion de Reglas ----------------*/

{fecha}			{guardar_datos(1);}
{ip}		    {guardar_datos(2);}
{mac}	      {guardar_datos(3);}
{resto}			{}

%%
                /*----- Seccion de Procedimientos --------*/
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
                			break;
                		case 3:
                			if(cmac>=10){
                				tmac+=(tmac/2);
                				copia=(char**)realloc(mac,tmac*sizeof(char*));
                				mac=copia;
                			}
                			mac[cmac]=malloc(strlen(yytext)+1);
                			strcpy(mac[cmac],yytext);
                			cmac++;
                			break;
                	}
                }

                void escribir_datos(int num_expresion){
                	int i;

                	switch(num_expresion){
                		case 1:
                			printf("\nFechas encontradas:\n");
                			for (i=0;i<cfechas;i++)
                				printf("\t%s\n",fechas[i]);
                		  	break;
                		case 2:
                			printf("\nIP encontrados:\n");
                			for (i=0;i<cip;i++)
                				printf("\t%s\n",ip[i]);
                		  	break;
                		case 3:
                			printf("\nMAC encontrados:\n");
                			for (i=0;i<cmac;i++)
                				printf("\t%s\n",mac[i]);
                		  	break;
                	}
                }

                void liberar_memoria(){
                	int i;

                	for (i=0;i<tfechas;i++)
                		free(fechas[i]);

                	for (i=0;i<tip;i++)
                		free(ip[i]);

                	for (i=0;i<tmac;i++)
                		free(mac[i]);


                	free(fechas);
                	free(ip);
                	free(mac);

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


  cfechas=cip=cmac=0;

  yylex();

  escribir_datos(1);
  escribir_datos(2);
  escribir_datos(3);

  liberar_memoria();

  return 0;
}

           
              

