/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """Amane
Arakune
Azrael
Bang
Bullet
Carl
Hakumen
Hazama
Izayoi
Jin
Kagura
Kokonoe
Litchi
Makoto
Mu-12
Noel
Nu-13
Platinum
Rachel
Ragna
Relius
Tager
Taokaka
Terumi
Tsubaki
Valkenhayn
"""

names.eachLine { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "${enumName}(\"${enumName}\", \"$line\", Version.BBCP),"

}