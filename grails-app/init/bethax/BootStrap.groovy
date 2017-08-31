package bethax

import org.irblleida.bethax.Role
import org.irblleida.bethax.User

class BootStrap {
    def springSecurityService

    def init = { servletContext ->
        new Role(authority: 'ROLE_USER').save(flush: true)
        new Role(authority: 'ROLE_ADMIN').save(flush: true)

        // Admin user
        new User(
                username: 'jvilaplana@irblleida.cat',
                password: springSecurityService.encodePassword('changeme'),
                authorities: [Role.findByAuthority('ROLE_ADMIN')],
                givenName: 'Jordi',
                familyName: 'Vilaplana',
                isFemale: false,
                passwordExpired: false).save(flush: true)
    }
    def destroy = {
    }
}
