#!/bin/bash


echo "Guardando datos de sniffeo "

ettercap -T -i wlan0 > sniffeo.txt &

echo -ne '[->                        ]  '
sleep 5
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[--->                      ]  '
sleep 5
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[----->                    ]  '
sleep 5
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[-------->                 ]  '
sleep 5
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[--------->                ]   '
sleep 10
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[------------->            ]   '
sleep 5
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[------------------>       ]   '
sleep 5
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[---------------------->   ]'
sleep 10
echo -e '\0033\0143'
echo "Guardando datos de sniffeo"
echo -ne '[------------------------->]'
echo " "

echo "Escaneo completo"
kill $!

./proyecto sniffeo.txt
