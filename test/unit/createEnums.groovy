/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """Aquaman
Ares
Bane
Batgirl (DLC)
Batman
Black Adam
Catwoman
Cyborg
Deathstroke
Doomsday
Flash
Green Arrow
Green Lantern
Harley Quinn
Hawkgirl
Joker
Killer Frost
Lex Luthor
Lobo (DLC)
Martian Manhunter (DLC)
Nightwing
Raven
Scorpion (DLC)
Shazam
Sinestro
Solomon Grundy
Superman
Wonder Woman
Zatanna (DLC)
Zod (DLC)
"""

names.eachLine { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "${enumName}(\"${enumName}\", \"$line\", Version.IGAU),"

}