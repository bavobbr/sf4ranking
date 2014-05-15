package be.bbr.sf4ranking

class HitMap<T> {

    public Map<T, Integer> mappedHits = [:]

    public void addHit(T key) {
        addHits(key, 1)
    }

    public void addHits(T key, Integer hits) {
        Integer hitsOfKey = mappedHits[key]
        if (!hitsOfKey) {
            hitsOfKey = hits
        }
        else {
            hitsOfKey+=hits
        }
        mappedHits.put(key, hitsOfKey)
    }

    public Integer getHitCount(T key) {
        if (!mappedHits[key]) return 0
        else return mappedHits[key]
    }

    public void each(Closure c) {
        mappedHits.each { k, v ->
            c(k, v)
        }
    }

    public def leftShift(T key) {
        addHit(key)
    }

    public Map<T, Integer> asMap() {
        def map = [:]
        mappedHits.each { k, v ->
            map.put(k, v)
        }
        return map
    }

    public LinkedHashMap<T, Integer> toSortedMap() {
        return asMap().sort { a, b -> b.value <=> a.value} as LinkedHashMap
    }

    public String toString() {
        return mappedHits.toString()
    }
}
