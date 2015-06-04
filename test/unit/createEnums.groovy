/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """Cassie Cage
DVorah
Ermac
Erron Black
Ferra Torr
Goro
Jacqueline Briggs
Jason Voorhees
Jax Briggs
Johnny Cage
Kano
Kenshi
Kitana
Kotal Kahn
Kung Lao
Kung Jin
Liu Kang
Mileena
Predator
Quan Chi
Raiden
Reptile
Scorpion
Shinnok
Sonya Blade
Sub-Zero
Takeda Takeshi
Tanya
Tremor
"""

names.eachLine { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "${enumName}(\"${enumName}\", \"$line\", Version.MKX),"

}