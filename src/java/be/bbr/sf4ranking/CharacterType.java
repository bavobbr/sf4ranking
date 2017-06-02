package be.bbr.sf4ranking;

import java.util.ArrayList;
import java.util.List;

/**
 * All enums should go to Groovy as Java is too verbose in the fromString part
 */
public enum CharacterType
{
    UNKNOWN("UNKNOWN", "Not identified", Version.USF4),
    ABEL("ABEL", "Abel", Version.USF4),
    ADON("ADON", "Adon", Version.USF4),
    AKUMA("AKUMA", "Akuma", Version.USF4),
    BALROG("BALROG", "Balrog", Version.USF4),
    BLANKA("BLANKA", "Blanka", Version.USF4),
    CAMMY("CAMMY", "Cammy", Version.USF4),
    CHUN("CHUN LI", "Chun-Li", Version.USF4),
    CODY("CODY", "Cody", Version.USF4),
    VIPER("C.VIPER", "C. Viper", Version.USF4),
    DAN("DAN", "Dan", Version.USF4),
    DJ("DJ", "Dee Jay", Version.USF4),
    DHALSIM("DHALSIM", "Dhalsim", Version.USF4),
    DUDLEY("DUDLEY", "Dudley", Version.USF4),
    HONDA("E. HONDA", "Honda", Version.USF4),
    FUERTE("EL FUERTE", "Fuerte", Version.USF4),
    ERYU("ERYU", "Evil Ryu", Version.USF4),
    FEI("FEI", "Fei Long", Version.USF4),
    GEN("GEN", "Gen", Version.USF4),
    GOUKEN("GOUKEN", "Gouken", Version.USF4),
    GUILE("GUILE", "Guile", Version.USF4),
    GUY("GUY", "Guy", Version.USF4),
    HAKAN("HAKAN", "Hakan", Version.USF4),
    IBUKI("IBUKI", "Ibuki", Version.USF4),
    JURI("JURI", "Juri", Version.USF4),
    KEN("KEN", "Ken", Version.USF4),
    MAKOTO("MAKOTO", "Makoto", Version.USF4),
    BISON("M.BISON", "M. Bison", Version.USF4),
    ONI("ONI", "Oni", Version.USF4),
    ROSE("ROSE", "Rose", Version.USF4),
    RUFUS("RUFUS", "Rufus", Version.USF4),
    RYU("RYU", "Ryu", Version.USF4),
    SAGAT("SAGAT", "Sagat", Version.USF4),
    SAKURA("SAKURA", "Sakura", Version.USF4),
    SETH("SETH", "Seth", Version.USF4),
    HAWK("T.HAWK", "T. Hawk", Version.USF4),
    VEGA("VEGA", "Claw", Version.USF4),
    YANG("YANG", "Yang", Version.USF4),
    YUN("YUN", "Yun", Version.USF4),
    ZANGIEF("ZANGIEF", "Zangief", Version.USF4),
    ROLENTO("ROLENTO", "Rolento", Version.USF4),
    HUGO("HUGO", "Hugo", Version.USF4),
    ELENA("ELENA", "Elena", Version.USF4),
    DECAPRE("DECAPRE", "Decapre", Version.USF4),
    POISON("POISON", "Poison", Version.USF4),


    AKUMA_MVC3("AKUMA", "Akuma", Version.UMVC3),
    AMATERASU("AMATERASU", "Amaterasu", Version.UMVC3),
    ARTHUR("ARTHUR", "Arthur", Version.UMVC3),
    VIPER_MVC3("VIPER", "C. Viper", Version.UMVC3),
    CHRIS("CHRIS", "Chris", Version.UMVC3),
    CHUN_LI("CHUN", "Chun-Li", Version.UMVC3),
    DANTE("DANTE", "Dante", Version.UMVC3),
    FELICIA("FELICIA", "Felicia", Version.UMVC3),
    FIREBRAND("FIREBRAND", "Firebrand", Version.UMVC3),
    FRANK_WEST("FRANK", "Frank West", Version.UMVC3),
    HAGGAR("HAGGAR", "Haggar", Version.UMVC3),
    HSIEN_KO("HSIEN", "Hsien Ko", Version.UMVC3),
    JILL("JILL", "Jill", Version.UMVC3),
    MORRIGAN("MORRIGAN", "Morrigan", Version.UMVC3),
    NEMESIS("NEMESIS", "Nemesis", Version.UMVC3),
    PHOENIX_WRIGHT("Wright", "Phoenix Wright", Version.UMVC3),
    RYU_MVC3("RYU", "Ryu", Version.UMVC3),
    SPENCER("SPENCER", "Spencer", Version.UMVC3),
    STRIDER("STRIDER", "Strider Hiryu", Version.UMVC3),
    TRISH("TRISH", "Trish", Version.UMVC3),
    TRON_BONNE("TRON", "Tron Bonne", Version.UMVC3),
    VERGIL("VERGIL", "Vergil", Version.UMVC3),
    VIEWTIFUL_JOE("VIEWTIFUL", "Viewtiful Joe", Version.UMVC3),
    WESKER("WESKER", "Wesker", Version.UMVC3),
    ZERO("ZERO", "Zero", Version.UMVC3),
    CAPTAIN_AMERICA("CAPTAIN", "Captain America", Version.UMVC3),
    DEADPOOL("DEADPOOL", "Deadpool", Version.UMVC3),
    DOCTOR_DOOM("DR. DOOM", "Doctor Doom", Version.UMVC3),
    DOCTOR_STRANGE("DR. STRANGE", "Doctor Strange", Version.UMVC3),
    DORMAMMU("DORMAMMU", "Dormammu", Version.UMVC3),
    GHOST_RIDER("GHOSTRIDER", "Ghost Rider", Version.UMVC3),
    HAWKEYE("HAWKEYE", "Hawkeye", Version.UMVC3),
    HULK("HULK", "Hulk", Version.UMVC3),
    IRON_FIST("IRONFIST", "Iron Fist", Version.UMVC3),
    IRON_MAN("IRONMAN", "Iron Man", Version.UMVC3),
    MAGNETO("MAGNETO", "Magneto", Version.UMVC3),
    MODOK("M.O.D.O.K", "M.O.D.O.K.", Version.UMVC3),
    NOVA("NOVA", "Nova", Version.UMVC3),
    PHOENIX("PHOENIX", "Phoenix", Version.UMVC3),
    ROCKET_RACCOON("RACCOON", "Rocket Raccoon", Version.UMVC3),
    SENTINEL("SENTINEL", "Sentinel", Version.UMVC3),
    SHE_HULK("SHEHULK", "She-Hulk", Version.UMVC3),
    SHUMA_GORATH("SHUMA", "Shuma-Gorath", Version.UMVC3),
    SPIDER_MAN("SPIDERMAN", "Spider-Man", Version.UMVC3),
    STORM("STORM", "Storm", Version.UMVC3),
    SUPER_SKRULL("SUPER SKRULL", "Super-Skrull", Version.UMVC3),
    TASKMASTER("TASKMASTER", "Taskmaster", Version.UMVC3),
    THOR("THOR", "Thor", Version.UMVC3),
    WOLVERINE("WOLVERINE", "Wolverine", Version.UMVC3),
    X_23("X23", "X-23", Version.UMVC3),

    FULGORE("FULGORE", "Fulgore", Version.KI),
    GLACIUS("GLACIUS", "Glacius", Version.KI),
    JAGO("JAGO", "Jago", Version.KI),
    SHADOWJAGO("SHADOWJAGO", "Shadow Jago", Version.KI),
    ORCHID("ORCHID", "Orchid", Version.KI),
    SABREWULF("SABREWULF", "Sabrewulf", Version.KI),
    SADIRA("SADIRA", "Sadira", Version.KI),
    SPINAL("SPINAL", "Spinal", Version.KI),
    THUNDER("THUNDER", "Thunder", Version.KI),
    TJCOMBO("TJCOMBO", "TJ Combo", Version.KI),
    MAYA("MAYA", "Maya", Version.KI),
    KANRA("KANRA", "Kan-ra", Version.KI),
    RIPTOR("RIPTOR", "Riptor", Version.KI),
    CINDER("CINDER", "Cinder", Version.KI),
    OMEN("OMEN", "Omen", Version.KI),
    AGANOS("AGANOS", "Aganos", Version.KI),
    HISAKO("HISAKO", "Hisako", Version.KI),
    ARIA("ARIA", "Aria", Version.KI),
    RASH("RASH", "Rash", Version.KI),
    KIMWU("KIM-WU", "Kim Wu", Version.KI),
    ARBITER("ARBITER", "Arbiter", Version.KI),
    TUSK("TUSK", "Tusk", Version.KI),
    MIRA("MIRA", "Mira", Version.KI),
    GARGOS("GARGOS", "Gargos", Version.KI),
    KILGORE("KILGORE", "Kilgore", Version.KI),

    BIG_BAND("BIGBAND", "Big Band", Version.SKULLGIRLS),
    CEREBELLA("CEREBELLA", "Cerebella", Version.SKULLGIRLS),
    DOUBLE("DOUBLE", "Double", Version.SKULLGIRLS),
    FILIA("FILIA", "Filia", Version.SKULLGIRLS),
    MS_FORTUNE("FORTUNE", "Ms. Fortune", Version.SKULLGIRLS),
    PAINWHEEL("PAINWHEEL", "Painwheel", Version.SKULLGIRLS),
    PARASOUL("PARASOUL", "Parasoul", Version.SKULLGIRLS),
    PEACOCK("PEACOCK", "Peacock", Version.SKULLGIRLS),
    SQUIGLY("SQUIGLY", "Squigly", Version.SKULLGIRLS),
    VALENTINE("VALENTINE", "Valentine", Version.SKULLGIRLS),
    ELIZA("ELIZA", "Eliza", Version.SKULLGIRLS),
    BEOWULF("BEOWULF", "Beowulf", Version.SKULLGIRLS),
    ROBO_FORTUNE("ROBO", "Robo Fortune", Version.SKULLGIRLS),
    FUKUA("FUKUA", "Fukua", Version.SKULLGIRLS),

    AQUAMAN("AQUAMAN", "Aquaman", Version.IGAU),
    ARES("ARES", "Ares", Version.IGAU),
    BANE("BANE", "Bane", Version.IGAU),
    BATGIRL_("BATGIRL", "Batgirl", Version.IGAU),
    BATMAN("BATMAN", "Batman", Version.IGAU),
    BLACK_ADAM("BLACK_ADAM", "Black Adam", Version.IGAU),
    CATWOMAN("CATWOMAN", "Catwoman", Version.IGAU),
    CYBORG("CYBORG", "Cyborg", Version.IGAU),
    DEATHSTROKE("DEATHSTROKE", "Deathstroke", Version.IGAU),
    DOOMSDAY("DOOMSDAY", "Doomsday", Version.IGAU),
    FLASH("FLASH", "The Flash", Version.IGAU),
    GREEN_ARROW("GREEN_ARROW", "Green Arrow", Version.IGAU),
    GREEN_LANTERN("GREEN_LANTERN", "Green Lantern", Version.IGAU),
    HARLEY_QUINN("HARLEY_QUINN", "Harley Quinn", Version.IGAU),
    HAWKGIRL("HAWKGIRL", "Hawkgirl", Version.IGAU),
    JOKER("JOKER", "Joker", Version.IGAU),
    KILLER_FROST("KILLER_FROST", "Killer Frost", Version.IGAU),
    LEX_LUTHOR("LEX_LUTHOR", "Lex Luthor", Version.IGAU),
    LOBO("LOBO", "Lobo", Version.IGAU),
    MARTIAN_MANHUNTER("MARTIAN_MANHUNTER", "Martian Manhunter", Version.IGAU),
    NIGHTWING("NIGHTWING", "Nightwing", Version.IGAU),
    RAVEN("RAVEN", "Raven", Version.IGAU),
    SCORPION("SCORPION", "Scorpion", Version.IGAU),
    SHAZAM("SHAZAM", "Shazam", Version.IGAU),
    SINESTRO("SINESTRO", "Sinestro", Version.IGAU),
    SOLOMON_GRUNDY("SOLOMON_GRUNDY", "Solomon Grundy", Version.IGAU),
    SUPERMAN("SUPERMAN", "Superman", Version.IGAU),
    WONDER_WOMAN("WONDER_WOMAN", "Wonder Woman", Version.IGAU),
    ZATANNA("ZATANNA", "Zatanna", Version.IGAU),
    ZOD("ZOD", "Zod", Version.IGAU),

    AMANE("AMANE", "Amane", Version.BBCP),
    ARAKUNE("ARAKUNE", "Arakune", Version.BBCP),
    AZRAEL("AZRAEL", "Azrael", Version.BBCP),
    BANG("BANG", "Bang", Version.BBCP),
    BULLET("BULLET", "Bullet", Version.BBCP),
    CARL("CARL", "Carl", Version.BBCP),
    CELICA("CCELICAARL", "Celica", Version.BBCP),
    ES("ES", "Es", Version.BBCP),
    HADES("HADES", "Hades", Version.BBCP),
    HAKUMEN("HAKU-MEN", "Hakumen", Version.BBCP),
    HAZAMA("HAZAMA", "Hazama", Version.BBCP),
    HIBIKI("HIBIKI", "Hibiki", Version.BBCP),
    IZAYOI("IZAYOI", "Izayoi", Version.BBCP),
    JIN("JIN", "Jin", Version.BBCP),
    KAGURA("KAGURA", "Kagura", Version.BBCP),
    KOKONOE("KOKONOE", "Kokonoe", Version.BBCP),
    KONOE("KONOE", "Kokonoe", Version.BBCP),
    LITCHI("LITCHI", "Litchi", Version.BBCP),
    LAMBDA11("LAMBDA", "Lambda", Version.BBCP),
    MAKOTO_BBCP("MAKOTO", "Makoto", Version.BBCP),
    MAI("MAI", "Mai", Version.BBCP),
    MU_12("MU-12", "12", Version.BBCP),
    NAOTO("NAOTO", "Naoto", Version.BBCP),
    NOEL("NOEL", "Noel", Version.BBCP),
    NU_13("NU-13", "13", Version.BBCP),
    PLATINUM("PLATINUM", "Platinum", Version.BBCP),
    RACHEL("RACHEL", "Rachel", Version.BBCP),
    RAGNA("RAGNA", "Ragna", Version.BBCP),
    RELIUS("RELIUS", "Relius", Version.BBCP),
    SHISHIGAMI("SHISHIGAMI", "Shishigami", Version.BBCP),
    SUSANO("SUSANO", "Susano", Version.BBCP),
    TAGER("TAGER", "Tager", Version.BBCP),
    TAOKAKA("TAOKAKA", "Taokaka", Version.BBCP),
    TERUMI("TERUMI", "Terumi", Version.BBCP),
    TSUBAKI("TSUBAKI", "Tsubaki", Version.BBCP),
    VALKENHAYN("VALKENHAYN", "Valkenhayn", Version.BBCP),
    NINE("NINE", "Nine", Version.BBCP),

    CASSIE_CAGE("CASSIE_CAGE", "Cassie Cage", Version.MKX),
    DVORAH("DVORAH", "D'Vorah", Version.MKX),
    ERMAC("ERMAC", "Ermac", Version.MKX),
    ERRON_BLACK("ERRON_BLACK", "Erron Black", Version.MKX),
    FERRA_TORR("FERRA-TORR", "Ferra Torr", Version.MKX),
    GORO("GORO", "Goro", Version.MKX),
    JACQUELINE_BRIGGS("JACQUI BRIGGS", "Jacqueline Briggs", Version.MKX),
    JASON_VOORHEES("JASON_VOORHEES", "Jason", Version.MKX),
    JAX_BRIGGS("JAX", "Jax Briggs", Version.MKX),
    JOHNNY_CAGE("JOHNNY_CAGE", "Johnny Cage", Version.MKX),
    KANO("KANO", "Kano", Version.MKX),
    KENSHI("KENSHI", "Kenshi", Version.MKX),
    KITANA("KITANA", "Kitana", Version.MKX),
    KOTAL_KAHN("KOTAL KHAN", "Kotal Kahn", Version.MKX),
    KUNG_LAO("KUNG_LAO", "Kung Lao", Version.MKX),
    KUNG_JIN("KUNG_JIN", "Kung Jin", Version.MKX),
    LIU_KANG("LIU_KANG", "Liu Kang", Version.MKX),
    MILEENA("MILEENA", "Mileena", Version.MKX),
    PREDATOR("PREDATOR", "Predator", Version.MKX),
    QUAN_CHI("QUAN_CHI", "Quan Chi", Version.MKX),
    RAIDEN("RAIDEN", "Raiden", Version.MKX),
    REPTILE("REPTILE", "Reptile", Version.MKX),
    SCORPION_MKX("SCORPION", "Scorpion", Version.MKX),
    SHINNOK("SHINNOK", "Shinnok", Version.MKX),
    SONYA_BLADE("SONYA_BLADE", "Sonya", Version.MKX),
    SUB_ZERO("SUB-ZERO", "Sub-Zero", Version.MKX),
    TAKEDA_TAKESHI("TAKEDA_TAKESHI", "Takeda", Version.MKX),
    TANYA("TANYA", "Tanya", Version.MKX),
    TREMOR("TREMOR", "Tremor", Version.MKX),
    ALIEN("ALIEN", "Alien", Version.MKX),
    BORAICHO("BO RAI CHO", "Bo Rai Cho", Version.MKX),
    LEATHERFACE("LEATHERFACE", "Leatherface", Version.MKX),
    TRIBORG("TRIBORG", "Triborg", Version.MKX),

    SF5_BIRDIE("BIRDIE", "Birdie", Version.SF5),
    SF5_CAMMY("CAMMY", "Cammy", Version.SF5),
    SF5_CHUNLI("CHUN-LI", "Chun", Version.SF5),
    SF5_DHALSIM("DHALSIM", "Dhalsim", Version.SF5),
    SF5_KARIN("KARIN", "Karin", Version.SF5),
    SF5_KEN("KEN", "Ken", Version.SF5),
    SF5_LAURA("LAURA", "Laura", Version.SF5),
    SF5_MBISON("M. BISON", "Bison", Version.SF5),
    SF5_NASH("NASH", "Nash", Version.SF5),
    SF5_NECALLI("NECALLI", "Necalli", Version.SF5),
    SF5_RASHID("RASHID", "Rashid", Version.SF5),
    SF5_RMIKA("R. MIKA", "Mika", Version.SF5),
    SF5_RYU("RYU", "Ryu", Version.SF5),
    SF5_VEGA("VEGA", "Vega", Version.SF5),
    SF5_ZANGIEF("ZANGIEF", "Gief", Version.SF5),
    SF5_FANG("F.A.N.G", "FANG", Version.SF5),
    SF5_ALEX("ALEX", "Alex", Version.SF5),
    SF5_GUILE("GUILE", "Guile", Version.SF5),
    SF5_IBUKI("IBUKI", "Ibuki", Version.SF5),
    SF5_BALROG("BALROG", "Balrog", Version.SF5),
    SF5_URIEN("URIEN", "Urien", Version.SF5),
    SF5_JURI("JURI", "Juri", Version.SF5),
    SF5_AKUMA("AKUMA", "Akuma", Version.SF5),
    SF5_KOLIN("KOLIN", "Kolin", Version.SF5),

    T7_AKUMA("AKUMA", "Akuma", Version.T7),
    T7_ALISA_BOSCONOVITCH("ALISA BOSCONOVITCH", "Alisa", Version.T7),
    T7_ASUKA_KAZAMA("ASUKA KAZAMA", "Asuka", Version.T7),
    T7_BOB("BOB", "Bob", Version.T7),
    T7_BRYAN_FURY("BRYAN FURY", "Bryan", Version.T7),
    T7_CLAUDIO_SERAFINO("CLAUDIO SERAFINO", "Claudio", Version.T7),
    T7_DEVIL_JIN("DEVIL JIN", "Devil Jin", Version.T7),
    T7_EDDY_GORDO("EDDY GORDO", "Eddy", Version.T7),
    T7_ELIZA("ELIZA", "Eliza", Version.T7),
    T7_FENG_WEI("FENG WEI", "Feng", Version.T7),
    T7_GIGAS("GIGAS", "Gigas", Version.T7),
    T7_HEIHACHI_MISHIMA("HEIHACHI MISHIMA", "Heihachi", Version.T7),
    T7_HWOARANG("HWOARANG", "Hwoarang", Version.T7),
    T7_JACK7("JACK 7", "Jack-7", Version.T7),
    T7_JIN_KAZAMA("JIN KAZAMA", "Jin", Version.T7),
    T7_JOSIE_RIZAL("JOSIE RIZAL", "Josie", Version.T7),
    T7_KATARINA_ALVES("KATARINA ALVES", "Katarina", Version.T7),
    T7_KAZUMI_MISHIMA("KAZUMI MISHIMA", "Kazumi", Version.T7),
    T7_KAZUYA_MISHIMA("KAZUYA MISHIMA", "Kazuya", Version.T7),
    T7_KING("KING", "King", Version.T7),
    T7_KUMA("KUMA", "Kuma", Version.T7),
    T7_LARS_ALEXANDERSSON("LARS ALEXANDERSSON", "Lars", Version.T7),
    T7_LEE_CHAOLAN("LEE CHAOLAN", "Lee", Version.T7),
    T7_LEO("LEO", "Leo", Version.T7),
    T7_LILI("LILI", "Lili", Version.T7),
    T7_LING_XIAOYU("LING XIAOYU", "Xiaoyu", Version.T7),
    T7_LUCKY_CHLOE("LUCKY CHLOE", "Chloe", Version.T7),
    T7_MARSHALL_LAW("MARSHALL LAW", "Law", Version.T7),
    T7_MASTER_RAVEN("MASTER RAVEN", "Raven", Version.T7),
    T7_MIGUEL_CABALLERO("MIGUEL CABALLERO", "Miguel", Version.T7),
    T7_NINA_WILLIAMS("NINA WILLIAMS", "Nina", Version.T7),
    T7_PANDA("PANDA", "Panda", Version.T7),
    T7_PAUL_PHOENIX("PAUL PHOENIX", "Paul", Version.T7),
    T7_SERGEI_DRAGUNOV("SERGEI DRAGUNOV", "Dragunov", Version.T7),
    T7_SHAHEEN("SHAHEEN", "Shaheen", Version.T7),
    T7_STEVE_FOX("STEVE FOX", "Steve", Version.T7),
    T7_VIOLET("VIOLET", "Violet", Version.T7),
    T7_YOSHIMITSU("YOSHIMITSU", "Yoshimitsu", Version.T7),

    INJ2_AQUAMAN("AQUAMAN", "Aquaman", Version.INJUSTICE2),
    INJ2_ATROCITUS("ATROCITUS", "Atrocitus", Version.INJUSTICE2),
    INJ2_BANE("BANE", "Bane", Version.INJUSTICE2),
    INJ2_BATMAN("BATMAN", "Batman", Version.INJUSTICE2),
    INJ2_BLACK_ADAM("ADAM", "Black Adam", Version.INJUSTICE2),
    INJ2_BLACK_CANARY("CANARY", "Black Canary", Version.INJUSTICE2),
    INJ2_BLUE_BEETLE("BEETLE", "Blue Beetle", Version.INJUSTICE2),
    INJ2_BRAINIAC("BRAINIAC", "Brainiac", Version.INJUSTICE2),
    INJ2_CAPTAIN_COLD("CAPTAIN_COLD", "Captain Cold", Version.INJUSTICE2),
    INJ2_CATWOMAN("CATWOMAN", "Catwoman", Version.INJUSTICE2),
    INJ2_CHEETAH("CHEETAH", "Cheetah", Version.INJUSTICE2),
    INJ2_CYBORG("CYBORG", "Cyborg", Version.INJUSTICE2),
    INJ2_DARKSEID("DARKSEID", "Darkseid", Version.INJUSTICE2),
    INJ2_DEADSHOT("DEADSHOT", "Deadshot", Version.INJUSTICE2),
    INJ2_DOCTOR_FATE("DOCTOR_FATE", "Doctor Fate", Version.INJUSTICE2),
    INJ2_FIRESTORM("FIRESTORM", "Firestorm", Version.INJUSTICE2),
    INJ2_FLASH("FLASH", "Flash", Version.INJUSTICE2),
    INJ2_GORILLA_GRODD("GORILLA_GRODD", "Gorilla Grodd", Version.INJUSTICE2),
    INJ2_GREEN_ARROW("GREEN_ARROW", "Green Arrow", Version.INJUSTICE2),
    INJ2_GREEN_LANTERN("GREEN_LANTERN", "Green Lantern", Version.INJUSTICE2),
    INJ2_HARLEY_QUINN("HARLEY_QUINN", "Harley Quinn", Version.INJUSTICE2),
    INJ2_JOKER("JOKER", "Joker", Version.INJUSTICE2),
    INJ2_POISON_IVY("POISON_IVY", "Poison Ivy", Version.INJUSTICE2),
    INJ2_ROBIN("ROBIN", "Robin", Version.INJUSTICE2),
    INJ2_SCARECROW("SCARECROW", "Scarecrow", Version.INJUSTICE2),
    INJ2_SUPERGIRL("SUPERGIRL", "Supergirl", Version.INJUSTICE2),
    INJ2_SUPERMAN("SUPERMAN", "Superman", Version.INJUSTICE2),
    INJ2_SWAMP_THING("SWAMP_THING", "Swamp Thing", Version.INJUSTICE2),
    INJ2_WONDER_WOMAN("WONDER_WOMAN", "Wonder Woman", Version.INJUSTICE2);


    private final String value;
    private final Version game;
    private final String shortname;

    CharacterType(String shortname, String value, Version game)
    {
        this.value = value;
        this.shortname = shortname;
        this.game = game;
    }

    public static List<CharacterType> forGame(Version game)
    {
        List<CharacterType> chars = new ArrayList<CharacterType>();
        for (CharacterType ct : CharacterType.values())
        {
            if (ct.game == Version.generalize(game) && ct != CharacterType.UNKNOWN)
            {
                chars.add(ct);
            }
        }
        return chars;
    }

    public static Integer count(Version game)
    {
        switch (game)
        {
            case VANILLA:
                return 25;
            case SUPER:
                return 35;
            case AE:
                return 39;
            case AE2012:
                return 39;
            default:
                return forGame(game).size();
        }
    }

    public String getValue()
    {
        return value;
    }

    public Version getGame()
    {
        return game;
    }

    public String getShortname()
    {
        return shortname;
    }

    public static CharacterType fromString(String input, Version game)
    {
        if (input == null || input.length() == 0 || game == null) return null;
        input = input.trim();
        if (input.toLowerCase().equals("unknown"))
        {
            return CharacterType.UNKNOWN;
        }
        CharacterType[] characterTypes = CharacterType.values();
        for (CharacterType ct : characterTypes)
        {
            if (game.equals(ct.game) &&
                (ct.shortname.toLowerCase().equals(input.toLowerCase()) || ct.name().toLowerCase().equals(input.toLowerCase())))
            {
                return ct;
            }
            else if (game.equals(ct.game) && (ct.value.toLowerCase().equals(input.toLowerCase())))
            {
                return ct;
            }
        }
        return null;
    }
}
