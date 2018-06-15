# bsk (basic space kit)
This kit of scripts and programs is necessary for survive in microgravity environments. Here are all scripts and programs that hasn't a own repository, because of its simplicity.

## Explaining
In the next table you can see a simple explanation for these scripts and programs

Folder | Filename | Function
--- | --- | ---
anuaris | anuari.sh | Generate a calendar for one given year
anuaris | anuari_escolar.sh | Generete a calendar from september to august
c_fitxers | hont.c | Simple C program to calculate D'Hondt method
c_fitxers | mcd.c | Calculate the greatest common divisor of two integers given from the shell
c_fitxers | mitjana.c | Calculate the mean of two or more numbers given from the shell
crear | crear.sh | Create new files with comments
filmaffinity | filmaffinity.py | Extract film information from filmaffinity
genmake | genmake.sh | Very simple generator of Makefiles for C/C++ and LaTeX
imprimirCodi | imprimirCodi.sh | Generate pdf from source code files
informacio | informacio.sh | Shell command for information in Debian GNU/Linux
latex_print | latex_print.sh | Shell command for generate empyt latex tables
orgMusica | orgMusica.sh | Organize audio files in folders using their tags
reanomenarJPG | reanomenarJPG.sh | Rename jpg files using their dates 
## Getting Started
For this kit you need some packages. These packages can be install in GNU/Linux Debian 9.0 with the next command in a root enviroment:
```
apt install gcc jhead mediainfo texlive-base python-requests python-html5lib python-lxml 
```
After, you can install all of these scripts and programs with:
```
sudo ./install.sh
```
This last command install all of these scripts and programs in "/usr/local/bin" folder.
## Autors
* **Cosmo Cat**  [cosmogat](https://github.com/cosmogat)
## License
See the [LICENSE](LICENSE)
