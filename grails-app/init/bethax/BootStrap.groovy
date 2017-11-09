package bethax

import grails.converters.JSON
import org.irblleida.bethax.Institution
import org.irblleida.bethax.InstitutionType
import org.irblleida.bethax.Organization
import org.irblleida.bethax.Role
import org.irblleida.bethax.TypeOfQuery
import org.irblleida.bethax.User

class BootStrap {
    def springSecurityService

    def init = { servletContext ->

        TimeZone.setDefault(TimeZone.getTimeZone("Europe/Madrid"))

        JSON.registerObjectMarshaller(Date) {
            return it?.format("yyyy-MM-dd")
        }

        new Role(authority: 'ROLE_USER').save(flush: true)
        new Role(authority: 'ROLE_ADMIN').save(flush: true)

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



        def pau = User.findByUsername('pbalaguer@irblleida.cat')
        def jordi = User.findByUsername('jvilaplana@irblleida.cat')

        new Organization(name: "UBiostat", createdBy: pau, lastModifiedBy: pau).save(flush: true)
        def org = Organization.findByName("UBiostat")
        pau.organization = org
        jordi.organization = org
        pau.save(flush: true)
        jordi.save(flush: true)

        new TypeOfQuery(createdBy: pau, lastModifiedBy: pau, name: "Sol·licitud de projecte competitiu").save(flush: true)
        new TypeOfQuery(createdBy: pau, lastModifiedBy: pau, name: "Disseny d'estudi").save(flush: true)
        new TypeOfQuery(createdBy: pau, lastModifiedBy: pau, name: "Redacció d'articles").save(flush: true)
        new TypeOfQuery(createdBy: pau, lastModifiedBy: pau, name: "Disseny de bases de dades").save(flush: true)
        new TypeOfQuery(createdBy: pau, lastModifiedBy: pau, name: "Anàlisi de dades").save(flush: true)

        new Institution(createdBy: pau, lastModifiedBy: pau, name: "IRBLleida", institutionType: InstitutionType.INTERNAL).save(flush: true)
        new Institution(createdBy: pau, lastModifiedBy: pau, name: "ICS Lleida", institutionType: InstitutionType.INTERNAL).save(flush: true)
        new Institution(createdBy: pau, lastModifiedBy: pau, name: "GSS", institutionType: InstitutionType.INTERNAL).save(flush: true)
        new Institution(createdBy: pau, lastModifiedBy: pau, name: "UdL", institutionType: InstitutionType.INTERNAL).save(flush: true)

        new Institution(createdBy: pau, lastModifiedBy: pau, name: "CatSalut", institutionType: InstitutionType.PUBLIC_EXTERNAL).save(flush: true)
        new Institution(createdBy: pau, lastModifiedBy: pau, name: "HUGTP", institutionType: InstitutionType.PUBLIC_EXTERNAL).save(flush: true)
        new Institution(createdBy: pau, lastModifiedBy: pau, name: "Parc Taurí", institutionType: InstitutionType.PUBLIC_EXTERNAL).save(flush: true)

        new Institution(createdBy: pau, lastModifiedBy: pau, name: "GOC", institutionType: InstitutionType.PRIVATE_EXTERNAL).save(flush: true)



    }

    def destroy = {
    }
}
