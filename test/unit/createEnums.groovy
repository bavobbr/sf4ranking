/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """
Katarina Alves
Claudio Serafino
Lucky Chloe
Shaheen
Josie Rizal
Gigas
Jack-7
Kazumi Mishima
Akuma 
Master Raven
Alisa Bosconovitch
Asuka Kazama
Bob
Bryan Fury
Devil Jin
Eddy Gordo
Eliza
Feng Wei
Heihachi Mishima
Hwoarang
Jin Kazama
Kazuya Mishima
King
Kuma
Lars Alexandersson
Lee Chaolan
Leo
Lili
Ling Xiaoyu
Marshall Law
Miguel Caballero
Nina Williams
Panda
Paul Phoenix
Sergei Dragunov
Steve Fox
Yoshimitsu
"""

names.readLines().sort().each { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "T7_${enumName}(\"${enumName}\", \"$line\", Version.SF5),"

}