dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
            logSql = false
        }
    }
    test {
        dataSource {
            dialect = 'org.hibernate.dialect.MySQL5InnoDBDialect'
            pooled = true
            dbCreate = "create-drop"
            url = "jdbc:mysql://localhost/sf4rank"
            driverClassName = "com.mysql.jdbc.Driver"
            username = "root"
            password = ""
        }
    }
    production {
        dataSource {
            dialect = 'org.hibernate.dialect.MySQL5InnoDBDialect'
            pooled = true
            //dbCreate = "create-drop"
            dbCreate = "update"
            url = ""
            driverClassName = "com.mysql.jdbc.Driver"
            username = ""
            password = ""
            properties {
                maxActive = 50
                maxIdle = 25
                minIdle = 1
                initialSize = 1

                numTestsPerEvictionRun = 3
                maxWait = 10000

                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = true

                validationQuery = "select now()"

                minEvictableIdleTimeMillis = 1000 * 60 * 5
                timeBetweenEvictionRunsMillis = 1000 * 60 * 5
            }
        }
    }
}
