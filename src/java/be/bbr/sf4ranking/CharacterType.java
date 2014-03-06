package be.bbr.sf4ranking;

/**
 * All enums should go to Groovy as Java is too verbose in the fromString part
 */
public enum CharacterType
{
    UNKNOWN("Not identified"),
    ABEL("Abel"),
    ADON("Adon"),
    AKUMA("Akuma"),
    BALROG("Balrog"),
    BLANKA("Blanka"),
    CAMMY("Cammy"),
    CHUN("Chun-Li"),
    CODY("Cody"),
    VIPER("Viper"),
    DAN("Dan"),
    DJ("Dee Jay"),
    DHALSIM("Dhalsim"),
    DUDLEY("Dudley"),
    HONDA("Honda"),
    FUERTE("Fuerte"),
    ERYU("Evil Ryu"),
    FEI("Fei Long"),
    GEN("Gen"),
    GOUKEN("Gouken"),
    GUILE("Guile"),
    GUY("Guy"),
    HAKAN("Hakan"),
    IBUKI("Ibuki"),
    JURI("Juri"),
    KEN("Ken"),
    MAKOTO("Makoto"),
    BISON("M. Bison"),
    ONI("Oni"),
    ROSE("Rose"),
    RUFUS("Rufus"),
    RYU("Ryu"),
    SAGAT("Sagat"),
    SAKURA("Sakura"),
    SETH("Seth"),
    HAWK("T. Hawk"),
    VEGA("Vega (Claw)"),
    YANG("Yang"),
    YUN("Yun"),
    ZANGIEF("Zangief");


    private final String value;

    CharacterType(String value)
    {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static CharacterType fromString(String input) {
        if (input == null || input.length() == 0) return null;
        input = input.trim();
        CharacterType[] characterTypes = CharacterType.values();
        for (CharacterType ct : characterTypes)
            if (ct.name().toLowerCase().equals(input.toLowerCase())) {
                return ct;
            }
        return null;
    }
}
