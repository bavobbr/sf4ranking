package be.bbr.sf4ranking

import grails.transaction.Transactional

/**
 * Specific queries to the database
 */
@Transactional
class QueryService
{

    /**
     * Search for players using parameters and paging
     */
    List<Player> findPlayers(CharacterType ctype, CountryCode countryCode, Integer max, Integer offset) {
        def playerIdQuery = Player.createCriteria()
        def playerids = playerIdQuery.list(order: "asc", sort: "rank", max: max, offset: offset) {
            projections {
                distinct 'id'
            }
            property("rank")
            gt("rank",0)
            if (countryCode) eq("countryCode", countryCode)
            if (ctype)
            {
                results {
                    pchars {
                        eq("characterType", ctype)
                    }
                }
            }
        }
        return Player.getAll(playerids)
    }

    Integer countPlayers(CharacterType ctype, CountryCode countryCode) {
        def playerCountQuery = Player.createCriteria()
        def playercount = playerCountQuery.list() {
            projections {
                countDistinct 'id'
            }
            gt("rank",0)
            if (countryCode) eq("countryCode", countryCode)
            if (ctype)
            {
                results {
                    pchars {
                        eq("characterType", ctype)
                    }
                }
            }
        }.first()
        return playercount
    }

    List<String> getActiveCountryNames() {
        def countries = Player.createCriteria().list {
            projections {
                distinct "countryCode"
            }
        }
        return countries.findResults() {it?.name()}
    }

    /**
     * Unused, but a useful reference
     */
    def findPlayersUsingHQL(CharacterType ctype, CountryCode countryCode, Integer max, Integer offset) {
            def allPlayerIds = Player.executeQuery("select distinct p.id, p.rank from Player as p left join p.results as result where result.pcharacter = ? order by p.rank asc", [ctype], [max: max, offset: offset])
            def totalPlayerIds = Player.executeQuery("select count(distinct p.id) from Player as p left join p.results as result where result.pcharacter = ?", [ctype])
            allPlayerIds = allPlayerIds.collect {it[0]}
            def players = Player.findAll {id in allPlayerIds}.sort {a, b -> a.rank <=> b.rank}
            def playercount = totalPlayerIds[0]
    }

}
