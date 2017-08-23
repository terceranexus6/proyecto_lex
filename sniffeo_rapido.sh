#!/bin/bash


echo "Guardando datos de sniffeo "

ettercap -T -i wlan0 > sniffeo_r.txt &

echo -ne '[->                        ]  '
sleep 1
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[--->                      ]  '
sleep 5
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[-------->                 ]  '
sleep 1
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[------------->            ]   '
sleep 1
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[---------------------->   ]'
sleep 1
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[------------------------->]'
echo " "

echo "Escaneo completo"
kill $!

./proyecto sniffeo_r.txt
