package be.bbr.sf4ranking

import grails.transaction.Transactional
import org.hibernate.criterion.CriteriaSpecification

/**
 * Specific queries to the database
 */
@Transactional
class QueryService
{

    /**
     * Search for players using parameters and paging
     */
    List<Player> findPlayers(CharacterType ctype, CountryCode countryCode, Integer max, Integer offset, Version game, boolean alltime = false)
    {
        log.info "Looking for $max players of ctype ${ctype} from country ${countryCode} starting from $offset in game $game"
        def rankType = alltime? "totalScore" : "rank"
        def playerIdQuery = Player.createCriteria()
        def playerids = playerIdQuery.list(max: max, offset: offset) {
            createAlias("rankings", "rankAlias", CriteriaSpecification.LEFT_JOIN)
            projections {
                distinct 'id'
            }
            eq("rankAlias.game", game)
            property("rankAlias.${rankType}")
            gt("rankAlias.${rankType}", 0)
            if (alltime) {
                order("rankAlias.${rankType}", "desc")
            }
            else {
                order("rankAlias.rank", "asc")
            }

            if (countryCode) eq("countryCode", countryCode)
            if (ctype)
            {
                and {
                    results {
                        characterTeams {
                            pchars {
                                eq("characterType", ctype)
                            }
                        }
                    }
                }
            }
        }
        def players = Player.getAll(playerids)
        players.retainAll { it.findRanking(game) != null }
        return players

    }

    List<Player> findCptPlayers()
    {
        log.info "Looking for all CPT players"
        def playerIdQuery = Player.createCriteria()
        def playerids = playerIdQuery.list(max: 150) {
            createAlias("rankings", "rankAlias", CriteriaSpecification.LEFT_JOIN)
            projections {
                distinct 'id'
            }
            eq("rankAlias.game", Version.USF4)
            property("cptScore")
            gt("cptScore", 0)
            order("cptScore", "desc")
        }
        def players = Player.getAll(playerids)
        log.info "Returned all CPT players ${players.size()}"
        return players
    }

    Integer countPlayers(CharacterType ctype, CountryCode countryCode, Version game)
    {
        def playerCountQuery = Player.createCriteria()
        def playercount = playerCountQuery.get() {
            createAlias("rankings", "rankAlias", CriteriaSpecification.LEFT_JOIN)
            projections {
                countDistinct 'id'
            }
            eq("rankAlias.game", game)
            gt("rankAlias.rank", 0)
            if (countryCode) eq("countryCode", countryCode)
            if (ctype)
            {
                results {
                    characterTeams {
                        pchars {
                            eq("characterType", ctype)
                        }
                    }
                }
            }
        }
        return playercount
    }

    Integer countPlayerResults(Player player, Version game)
    {
        def resultCountQuery = Result.createCriteria()
        def rcount = resultCountQuery.get() {
            projections {
                countDistinct 'id'
            }
            tournament {
                eq("game", game)
            }
            eq("player", player)
        }
        return rcount
    }

    Integer countPlayerResultsAfter(Player player, Version game, Date date)
    {
        def resultCountQuery = Result.createCriteria()
        def rcount = resultCountQuery.get() {
            projections {
                countDistinct 'id'
            }
            tournament {
                eq("game", game)
                gt("date", date)
            }
            eq("player", player)
        }
        return rcount
    }

    List<String> getActiveCountryNames()
    {
        def countries = Player.createCriteria().list {
            projections {
                distinct "countryCode"
            }
        }
        return countries.findResults() {it?.name()}
    }

    List<Player> findOrphanedPlayers()
    {
        def playerQuery = Player.createCriteria()
        return playerQuery.list() {
            isEmpty("rankings")
        }
    }

    Tournament lastTournament(Version game) {
        def query = Tournament.createCriteria()
        def last = query.list(max: 1) {
            eq("game", game)
            eq("finished", true)
            order("date", "desc")
        }
        return last.size() > 0? last.first() : null
    }

}
