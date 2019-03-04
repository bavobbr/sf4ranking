
def path = '/Users/bbr/Documents/projects/sf4ranking/web-app/images/chars/bbtag'
def file = new File(path)
file.listFiles().each {
    def namepart = it.name.split("\\.")[0].toUpperCase()
    def solo = namepart - "BBTAG_"
    def scribe = solo[0]+solo[1..-1].toLowerCase()
    println "$namepart(\"$solo\", \"$scribe\", Version.BBTAG),"
}
