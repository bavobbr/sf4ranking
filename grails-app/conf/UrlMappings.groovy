class UrlMappings {

	static mappings = {
        name playerByName: "/$controller/player/byname/$name"{
            action = "playerByName"
        }
        name tournamentByName: "/$controller/tournament/byname/$name"{
            action = "tournamentByName"
        }
        name teamByName: "/$controller/team/byname/$name"{
            action = "teamByName"
        }
        "/$controller/$action?/$id?(.${format})?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "/rankings")
        "500"(view:'/error')
	}
}
