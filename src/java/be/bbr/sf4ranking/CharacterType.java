package be.bbr.sf4ranking;

/**
 * All enums should go to Groovy as Java is too verbose in the fromString part
 */
public enum CharacterType
{
    UNKNOWN("UNKNOWN", "Not identified", Version.AE2012),
    ABEL("ABEL", "Abel", Version.AE2012),
    ADON("ADON", "Adon", Version.AE2012),
    AKUMA("AKUMA", "Akuma", Version.AE2012),
    BALROG("BALROG", "Balrog", Version.AE2012),
    BLANKA("BLANKA", "Blanka", Version.AE2012),
    CAMMY("CAMMY", "Cammy", Version.AE2012),
    CHUN("CHUN", "Chun-Li", Version.AE2012),
    CODY("CODY", "Cody", Version.AE2012),
    VIPER("VIPER", "Viper", Version.AE2012),
    DAN("DAN", "Dan", Version.AE2012),
    DJ("DJ", "Dee Jay", Version.AE2012),
    DHALSIM("DHALSIM", "Dhalsim", Version.AE2012),
    DUDLEY("DUDLEY", "Dudley", Version.AE2012),
    HONDA("HONDA", "Honda", Version.AE2012),
    FUERTE("FUERTE", "Fuerte", Version.AE2012),
    ERYU("ERYU", "Evil Ryu", Version.AE2012),
    FEI("FEI", "Fei Long", Version.AE2012),
    GEN("GEN", "Gen", Version.AE2012),
    GOUKEN("GOUKEN", "Gouken", Version.AE2012),
    GUILE("GUILE", "Guile", Version.AE2012),
    GUY("GUY", "Guy", Version.AE2012),
    HAKAN("HAKAN", "Hakan", Version.AE2012),
    IBUKI("IBUKI", "Ibuki", Version.AE2012),
    JURI("JURI", "Juri", Version.AE2012),
    KEN("KEN", "Ken", Version.AE2012),
    MAKOTO("MAKOTO", "Makoto", Version.AE2012),
    BISON("BISON", "M. Bison", Version.AE2012),
    ONI("ONI", "Oni", Version.AE2012),
    ROSE("ROSE", "Rose", Version.AE2012),
    RUFUS("RUFUS", "Rufus", Version.AE2012),
    RYU("RYU", "Ryu", Version.AE2012),
    SAGAT("SAGAT", "Sagat", Version.AE2012),
    SAKURA("SAKURA", "Sakura", Version.AE2012),
    SETH("SETH", "Seth", Version.AE2012),
    HAWK("HAWK", "T. Hawk", Version.AE2012),
    VEGA("VEGA", "Vega (Claw)", Version.AE2012),
    YANG("YANG", "Yang", Version.AE2012),
    YUN("YUN", "Yun", Version.AE2012),
    ZANGIEF("ZANGIEF", "Zangief", Version.AE2012),


    AKUMA_MVC3("AKUMA", "Akuma", Version.UMVC3),
    AMATERASU("AMATERASU", "Amaterasu", Version.UMVC3),
    ARTHUR("ARTHUR", "Arthur", Version.UMVC3),
    VIPER_MVC3("VIPER", "C. Viper", Version.UMVC3),
    CHRIS("CHRIS", "Chris", Version.UMVC3),
    CHUN_LI("CHUN", "Chun Li", Version.UMVC3),
    DANTE("DANTE", "Dante", Version.UMVC3),
    FELICIA("FELICIA", "Felicia", Version.UMVC3),
    FIREBRAND("FIREBRAND", "Firebrand", Version.UMVC3),
    FRANK_WEST("FRANK", "Frank West", Version.UMVC3),
    HAGGAR("HAGGAR", "Haggar", Version.UMVC3),
    HSIEN_KO("HSIEN", "Hsien Ko", Version.UMVC3),
    JILL("JILL", "Jill", Version.UMVC3),
    MORRIGAN("MORRIGAN", "Morrigan", Version.UMVC3),
    NEMESIS("NEMESIS", "Nemesis", Version.UMVC3),
    PHOENIX_WRIGHT("PHOENIX", "Phoenix Wright", Version.UMVC3),
    RYU_MVC3("RYU", "Ryu", Version.UMVC3),
    SPENCER("SPENCER", "Spencer", Version.UMVC3),
    STRIDER("STRIDER", "Strider", Version.UMVC3),
    TRISH("TRISH", "Trish", Version.UMVC3),
    TRON_BONNE("TRON", "Tron Bonne", Version.UMVC3),
    VERGIL("VERGIL", "Vergil", Version.UMVC3),
    VIEWTIFUL_JOE("VIEWTIFUL", "Viewtiful Joe", Version.UMVC3),
    WESKER("WESKER", "Wesker", Version.UMVC3),
    ZERO("ZERO", "Zero", Version.UMVC3),
    CAPTAIN_AMERICA("CAPTAIN", "Captain America", Version.UMVC3),
    DEADPOOL("DEADPOOL", "Deadpool", Version.UMVC3),
    DOCTOR_DOOM("DRDOOM", "Doctor Doom", Version.UMVC3),
    DOCTOR_STRANGE("DRSTRANGE", "Doctor Strange", Version.UMVC3),
    DORMAMMU("DORMAMMU", "Dormammu", Version.UMVC3),
    GHOST_RIDER("GHOSTRIDER", "Ghost Rider", Version.UMVC3),
    HAWKEYE("HAWKEYE", "Hawkeye", Version.UMVC3),
    HULK("HULK", "Hulk", Version.UMVC3),
    IRON_FIST("IRONFIST", "Iron Fist", Version.UMVC3),
    IRON_MAN("IRONMAN", "Iron Man", Version.UMVC3),
    MAGNETO("MAGNETO", "Magneto", Version.UMVC3),
    MODOK("MODOK", "MODOK", Version.UMVC3),
    NOVA("NOVA", "Nova", Version.UMVC3),
    PHOENIX("PHOENIX", "Phoenix", Version.UMVC3),
    ROCKET_RACCOON("RACCOON", "Rocket Raccoon", Version.UMVC3),
    SENTINEL("SENTINEL", "Sentinel", Version.UMVC3),
    SHE_HULK("SHEHULK", "She-Hulk", Version.UMVC3),
    SHUMA_GORATH("SHUMA", "Shuma Gorath", Version.UMVC3),
    SPIDER_MAN("SPIDERMAN", "Spider-Man", Version.UMVC3),
    STORM("STORM", "Storm", Version.UMVC3),
    SUPER_SKRULL("SUPERSKRULL", "Super-Skrull", Version.UMVC3),
    TASKMASTER("TASKMASTER", "Taskmaster", Version.UMVC3),
    THOR("THOR", "Thor", Version.UMVC3),
    WOLVERINE("WOLVERINE", "Wolverine", Version.UMVC3),
    X_23("X23", "X-23", Version.UMVC3);


    private final String value;
    private final Version game;
    private final String shortname;

    CharacterType(String shortname, String value, Version game)
    {
        this.value = value;
        this.shortname = shortname;
        this.game = game;
    }

    public String getValue() {
        return value;
    }
    public Version getGame() {
        return game;
    }

    public static CharacterType fromString(String input, Version game) {
        if (input == null || input.length() == 0 || game == null) return null;
        input = input.trim();
        CharacterType[] characterTypes = CharacterType.values();
        for (CharacterType ct : characterTypes)
            if (game.equals(ct.game) && (ct.shortname.toLowerCase().equals(input.toLowerCase()) || ct.name().toLowerCase().equals(input.toLowerCase()))) {
                return ct;
            }
        return null;
    }
}
