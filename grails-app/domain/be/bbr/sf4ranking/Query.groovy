package be.bbr.sf4ranking

class Query
{

    static constraints = {
        name nullable: false, unique: false
        date nullable: false
        source nullable: true
    }

    String name
    Date date
    String source


    public String toString() {
        def props = []
        if (name) props << name
        if (date) props << date
        if (source) props << source
        return props.join(", ")
    }
}
