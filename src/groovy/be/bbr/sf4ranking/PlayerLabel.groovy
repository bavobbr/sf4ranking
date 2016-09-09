package be.bbr.sf4ranking


enum PlayerLabel {

    TOP10("top10", "10"),
    TOP20("top20", "20"),
    TOP50("top50", "50"),
    TOP100("top100", "100"),
    TOP250("top250", ""),
    UPCOMING("top_upcoming",""),
    NONE("top_none", "")

    String cssClass
    String displayValue

    public PlayerLabel(String cssClass, String displayValue) {
        this.cssClass = cssClass
        this.displayValue = displayValue
    }

}