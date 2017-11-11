package bethax

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/" {
            controller = "home"
            action = "index"
        }
        "/.well-known/acme-challenge/$id" {
            controller = "home"
            action = "acmeChallenge"
        }
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
