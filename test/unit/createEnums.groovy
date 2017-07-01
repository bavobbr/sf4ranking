/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """
Answer
Axl
Bedman
Chipp
Elphelt
Faust
I-No
Jack-O
Jam
Johnny
Kum
Ky
Leo Whitefang
May
Millia
Potemkin
Ramlethal
Raven
Sin
Slayer
Sol Badguy
Venom
Zato-1
"""

names.readLines().sort().each { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "GG_${enumName}(\"${enumName}\", \"$line\", Version.GGXRD),"

}