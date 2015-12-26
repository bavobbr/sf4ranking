/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """
Birdie
 Cammy
 Chun-Li
 Dhalsim
 Karin
 Ken
 Laura
 M. Bison
 Nash
 Necalli
 Rashid
 R. Mika
 Ryu
 Vega
 Zangief
 FANG
"""

names.eachLine { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "SF5_${enumName}(\"${enumName}\", \"$line\", Version.SF5),"

}