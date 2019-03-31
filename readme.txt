ejecutar comandos en este orden:
apt-get install lex -y
apt-get install gcc -y
lex -o LAB01_DEMARCHENA_MARTINEZ.yy.c LAB01_DEMARCHENA_MARTINEZ.l
cc LAB01_DEMARCHENA_MARTINEZ.yy.c -o LAB01_DEMARCHENA_MARTINEZ -ll
./LAB01_DEMARCHENA_MARTINEZ <script.c> salida.txt
