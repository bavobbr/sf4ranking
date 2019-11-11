package be.bbr.sf4ranking.smash

import groovy.transform.ToString

@ToString
class SmashAttendee {
    String name
    String gamertag
    Integer id
    Integer attendeeId
    String country
    String state
    String twitter
    String tag
    List<SmashEvent> events = []
}