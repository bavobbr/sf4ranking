/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """
Big Band
Cerebella
Double
Filia
Ms Fortune
Painwheel
Parasoul
Peacock
Squigly
Valentine
Eliza
Beowulf
Robo Fortune
"""

names.eachLine { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "${enumName}(\"${enumName}\", \"$line\", Version.SKULLGIRLS),"

}