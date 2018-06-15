#!/usr/bin/env python
# -*- coding: utf-8 -*- 
# 06-12-2017
# billy
# filmaffinity.py

from lxml import html
#import os
import requests
#import MySQLdb
import sys

def info(cad):
    pagina = requests.get("https://www.filmaffinity.com/es/search.php?stext=" + cad + "&stype=all")
    arbre = html.fromstring(pagina.content)
    pelicules = arbre.xpath('//div[@class="mc-title"]//a//text()')
    if (len(pelicules) != 0):
        peli_num = 0
        for i in range(0, len(pelicules)):
            pelicules[i] = pelicules[i].encode('latin-1')
            if (pelicules[i] == cad):
                peli_num = i
        pelicules = arbre.xpath('//div[@class="mc-title"]//@href')
        pagina = requests.get("https://www.filmaffinity.com" + pelicules[peli_num])
        arbre = html.fromstring(pagina.content)
    titols = arbre.xpath('//h1//span[@itemprop="name"]//text()')
    if (len(titols) == 0):
        return ["", "", "", "", "", "", "", ""]
    titol = titols[0].encode('utf-8')
    lis_nota = arbre.xpath('//div[@id="movie-rat-avg"]//@content')
    if not lis_nota:
        nota = ""
    else:
        nota = lis_nota[0]
    lis_direccio = arbre.xpath('//span[@itemprop="director"]//span[@itemprop="name"]//text()')
    if not lis_direccio:
        direccio = ""
    else:
        direccio = lis_direccio[0].encode('utf-8')
    lis_pais = arbre.xpath('//span[@id="country-img"]//img//@title')
    if not lis_pais:
        pais = ""
    else:
        pais = lis_pais[0].encode('utf-8')
    lis_actuacio = arbre.xpath('//span[@itemprop="actor"]//span[@itemprop="name"]//text()')
    if not lis_actuacio:
        act = ""
    else:
        act = ""
        for i in range(0, len(lis_actuacio) - 1):
            act = act + lis_actuacio[i].encode('utf-8') + ", "
        act = act + lis_actuacio[len(lis_actuacio) - 1].encode('utf-8')
    lis_genere = arbre.xpath('//span[@itemprop="genre"]//text()')
    if not lis_genere:
        gen = ""
    else:
        gen = ""
        for i in range(0, len(lis_genere) - 1):
            gen = gen + lis_genere[i].encode('utf-8') + ", "
        gen = gen + lis_genere[len(lis_genere) - 1].encode('utf-8')
    lis_sinopsi = arbre.xpath('//dd[@itemprop="description"]//text()')
    if not lis_sinopsi:
        sinopsi = ''
    else:
        sinopsi = lis_sinopsi[0].encode('utf-8')
    lis_an = arbre.xpath('//dd[@itemprop="datePublished"]//text()')
    if not lis_an:
        an = ""
    else:
        an = lis_an[0].encode('utf-8')
    titol = titol.replace("\"", "'")
    direccio = direccio.replace("\"", "'")
    pais = pais.replace("\"", "'")
    act = act.replace("\"", "'")
    gen = gen.replace("\"", "'")
    sinopsi = sinopsi.replace("\"", "'")
    return [titol, direccio, pais, act, gen, nota, sinopsi, an]

if __name__ == '__main__':
    if (len(sys.argv) != 2):
        sys.exit("Passeu en un únic argument el nom de la pel·lícula.")
    ret = info(sys.argv[1])
    if (ret[0] == ""):
        print "No s'han trobat dades."
    else:
        print "Nom:      ", ret[0]
        print "Direcció: ", ret[1]
        print "País:     ", ret[2]
        print "Elenc:    ", ret[3]
        print "Gènere:   ", ret[4]
        print "Nota:     ", ret[5]
        print "Any:      ", ret[7]
        print "Sinopsi:  ", ret[6]
