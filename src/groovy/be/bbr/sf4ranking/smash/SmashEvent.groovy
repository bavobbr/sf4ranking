package be.bbr.sf4ranking.smash

import groovy.transform.ToString

@ToString
class SmashEvent {
    Integer id
    String name
    List<SmashPool> pools = []
    Integer entrantId
    Integer seed
}