import groovy.json.JsonSlurper

//def host = "http://localhost:8080/sf4ranking"
def host = "http://rank.shoryuken.com"


def scores_evo = [[1000], [700], [500], [400], [320] * 2, [250] * 2, [200] * 4, [160] * 4, [130] * 8, [100] * 8, [70] * 16, [40] * 16, [20] * 32, [10] * 32, [5] * 64, [1] * 64].flatten()
def scores_premier = [[400], [250], [200], [160], [130] * 2, [100] * 2, [70] * 4, [40] * 4, [20] * 8, [10] * 8, [5] * 16, [1] * 16].flatten()
def scores_regfinal = [[400], [250], [200], [160], [130] * 2, [100] * 2].flatten()
def scores_ranking = [[160], [100], [70], [40], [20] * 2, [10] * 2, [5] * 4, [1] * 4].flatten()

def evosum = scores_evo.sum()
def premiersum = scores_premier.sum()
def regsum = scores_regfinal.sum()
def rankingsum = scores_ranking.sum()

def evototal = evosum * 1
def premtotal = premiersum * (14)
def regfinaltotal = regsum * (4)
def ranktotal = rankingsum * (32+16)

println "EVO points: "+evototal
println "Premier points: "+premtotal
println "Regional Final points: "+regfinaltotal
println "Ranking points: "+ranktotal

println evototal+premtotal+ranktotal+regfinaltotal
