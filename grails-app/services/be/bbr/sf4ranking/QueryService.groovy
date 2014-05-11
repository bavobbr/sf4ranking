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
    List<Player> findPlayers(CharacterType ctype, CountryCode countryCode, Integer max, Integer offset, Version game) {
        log.info "Looking for $max players of ctype ${ctype} from country ${countryCode} starting from $offset in game $game"
        def playerIdQuery = Player.createCriteria()
        def playerids = playerIdQuery.list(max: max, offset: offset) {
            createAlias("rankings", "rankAlias", CriteriaSpecification.LEFT_JOIN)
            projections {
                distinct 'id'
            }
            eq("rankAlias.game", game)
            property("rankAlias.rank")
            gt("rankAlias.rank",0)
            order("rankAlias.rank", "asc")
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
        return Player.getAll(playerids)
    }

    Integer countPlayers(CharacterType ctype, CountryCode countryCode, Version game) {
        def playerCountQuery = Player.createCriteria()
        def playercount = playerCountQuery.get() {
            createAlias("rankings", "rankAlias", CriteriaSpecification.LEFT_JOIN)
            projections {
                countDistinct 'id'
            }
            eq("rankAlias.game", game)
            gt("rankAlias.rank",0)
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

    Integer countPlayerResults(Player player, Version game) {
        def resultCountQuery = Result.createCriteria()
        def rcount = resultCountQuery.get() {
            projections {
                countDistinct 'id'
            }
            tournament {
                eq("game", game)
            }
            eq("player",player)
        }
        return rcount
    }

    List<String> getActiveCountryNames() {
        def countries = Player.createCriteria().list {
            projections {
                distinct "countryCode"
            }
        }
        return countries.findResults() {it?.name()}
    }

    List<Player> findOrphanedPlayers() {
        def playerQuery = Player.createCriteria()
        return playerQuery.list() {
            isEmpty("rankings")
        }
    }

}
