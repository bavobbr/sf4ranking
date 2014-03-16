/**
 * User: bbr
 * Date: 3/11/14
 */
def names = """
Captain America
Deadpool
Doctor Doom
Doctor Strange
Dormammu
Ghost Rider
Hawkeye
Hulk
Iron Fist
Iron Man
Magneto
MODOK
Nova
Phoenix
Rocket Raccoon
Sentinel
She-Hulk
Shuma Gorath
Spider-Man
Storm
Super-Skrull
Taskmaster
Thor
Wolverine
X-23
"""

names.eachLine { String line ->
    line = line.trim()
    def enumName = line.replace(" ","_").replace(".","_").toUpperCase()
    println "${enumName}(\"${enumName}\", \"$line\", Version.UMVC3),"

}