package be.bbr.sf4ranking

class Configuration
{
    static constraints = {
        lastUpdateMessage nullable: true, maxSize: 1000, widget: 'textarea'
        lastCptSnapshot nullable: true, editable: false
    }

    String lastUpdateMessage
    Date lastCptSnapshot
}
