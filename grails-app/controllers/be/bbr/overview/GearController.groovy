package be.bbr.overview

import be.bbr.sf4ranking.Hardware

/**
 * Renders the FAQ and provides some statistical data about the database
 */
class GearController
{

    def index() {
        [controllers: Hardware.list()]
    }

    def show(Hardware hardware) {
        [controller: hardware]
    }
}
