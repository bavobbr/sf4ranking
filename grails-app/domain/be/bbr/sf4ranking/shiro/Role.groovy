package be.bbr.sf4ranking.shiro

class Role {
    String name

    static hasMany = [ users: User, permissions: String ]
    static belongsTo = User

    static constraints = {
        name(nullable: false, blank: false, unique: true)
    }

    public String toString() {
        return "role $name ($permissions)"
    }
}
