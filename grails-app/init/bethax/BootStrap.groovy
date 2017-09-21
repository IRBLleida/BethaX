package bethax

import org.irblleida.bethax.Institution
import org.irblleida.bethax.InstitutionType
import org.irblleida.bethax.Organization
import org.irblleida.bethax.Role
import org.irblleida.bethax.TypeOfQuery
import org.irblleida.bethax.User

class BootStrap {
    def springSecurityService

    def init = { servletContext ->
        new Role(authority: 'ROLE_USER').save(flush: true)
        new Role(authority: 'ROLE_ADMIN').save(flush: true)


        new Organization(name: "UBiostat").save(flush: true)

        // Admin user
        new User(
                username: 'jvilaplana@irblleida.cat',
                password: springSecurityService.encodePassword('changeme'),
                authorities: [Role.findByAuthority('ROLE_USER'), Role.findByAuthority('ROLE_ADMIN')],
                givenName: 'Jordi',
                familyName: 'Vilaplana',
                isFemale: false,
                organization: Organization.findByName("UBiostat"),
                passwordExpired: false).save(flush: true)

        new User(
                username: 'pbalaguer@irblleida.cat',
                password: springSecurityService.encodePassword('changeme'),
                authorities: [Role.findByAuthority('ROLE_USER'), Role.findByAuthority('ROLE_ADMIN')],
                givenName: 'Pau',
                familyName: 'Balaguer',
                isFemale: false,
                organization: Organization.findByName("UBiostat"),
                passwordExpired: false).save(flush: true)

        new TypeOfQuery(name: "Sol·licitud de projecte competitiu").save(flush: true)
        new TypeOfQuery(name: "Disseny d'estudi").save(flush: true)
        new TypeOfQuery(name: "Redacció d'articles").save(flush: true)
        new TypeOfQuery(name: "Disseny de bases de dades").save(flush: true)
        new TypeOfQuery(name: "Anàlisi de dades").save(flush: true)

        new Institution(name: "IRBLleida", institutionType: InstitutionType.INTERNAL).save(flush: true)
        new Institution(name: "ICS Lleida", institutionType: InstitutionType.INTERNAL).save(flush: true)
        new Institution(name: "GSS", institutionType: InstitutionType.INTERNAL).save(flush: true)
        new Institution(name: "UdL", institutionType: InstitutionType.INTERNAL).save(flush: true)

        new Institution(name: "CatSalut", institutionType: InstitutionType.PUBLIC_EXTERNAL).save(flush: true)
        new Institution(name: "HUGTP", institutionType: InstitutionType.PUBLIC_EXTERNAL).save(flush: true)
        new Institution(name: "Parc Taurí", institutionType: InstitutionType.PUBLIC_EXTERNAL).save(flush: true)

        new Institution(name: "GOC", institutionType: InstitutionType.PRIVATE_EXTERNAL).save(flush: true)
    }

    def destroy = {
    }
}
