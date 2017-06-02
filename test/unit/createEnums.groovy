/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """
Harley Quinn
Supergirl
Robin
Black Canary
Black Adam
Scarecrow
Green Arrow
Atrocitus
Joker
Bane
Batman
Captain Cold
Poison Ivy
Flash
Doctor Fate
Deadshot
Catwoman
Green Lantern
Wonder Woman
Blue Beetle
Gorilla Grodd
Firestorm
Swamp Thing
Superman
Cheetah
Darkseid
Brainiac
Cyborg
Aquaman
"""

names.readLines().sort().each { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "INJ2_${enumName}(\"${enumName}\", \"$line\", Version.INJUSTICE2),"

}