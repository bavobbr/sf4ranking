/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """Glacius
Jago
Orchid
Sabrewulf
Sadira
Thunder
"""

names.eachLine { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "${enumName}(\"${enumName}\", \"$line\", Version.KI),"

}