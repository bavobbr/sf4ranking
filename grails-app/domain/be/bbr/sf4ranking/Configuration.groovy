package be.bbr.sf4ranking

class Configuration
{
    static constraints = {
        lastUpdateMessage nullable: true, maxSize: 1000
    }

    String lastUpdateMessage
}
