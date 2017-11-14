package bethax

import grails.converters.JSON
import org.irblleida.bethax.Institution
import org.irblleida.bethax.InstitutionSection
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
        new Institution(createdBy: pau, lastModifiedBy: pau, name: "Parc Taulí", institutionType: InstitutionType.PUBLIC_EXTERNAL).save(flush: true)

        new Institution(createdBy: pau, lastModifiedBy: pau, name: "GOC", institutionType: InstitutionType.PRIVATE_EXTERNAL).save(flush: true)

        def irb = Institution.findByName("IRBLleida")
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Altres línies de recerca").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Biologia de Sistemes i Mètodes Estadístics per a la Recerca Mèdica").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Biologia Molecular de Llevats").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Bioquímica de l'Estrès Oxidatiu").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Cicle Cel·lular").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Cirurgia Endocrina").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Cirurgia Experimental").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Desenvolupament i Evolució del Cervell").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Epidemiologia Aplicada").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Farmacoepidemiologia").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Fisiopatologia Metabòlica").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Fonaments Biològics dels Trastorns Mentals").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Genètica de Malalties Complexes").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "GRECS - Grup de Recerca de Cures de Salut").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Grup de Recerca en Immunologia i Metabolisme").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Grup de Recerca de Biomarcadors en Càncer (GReBiC)").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Recerca Translacional en Medicina Respiratòria").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Medicina Intensiva").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Neurobiologia Molecular i del Desenvolupament").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Clinical Neurosciences").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Neurocognició, psicobiologia de la personalitat i genètica de la conducta").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Neuroimmunologia").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Patologia Neuromuscular Experimental").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Patologia Oncològica").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Recerca Clínica i Experimental en Patologia Digestiva i Hematològica").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Senyalització Cel·lular i Apoptosi").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Senyalización en Levaduras").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Senyalització Oncogènica I Del Desenvolupament").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Senyalització Cel·lular per Calci").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Unitat de Farmacologia").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Unitat de Senyalització Neuronal").save(flush: true)
        new InstitutionSection(createdBy: pau, lastModifiedBy: pau, institution: irb, name: "Vascular and Renal Translational Research Group").save(flush: true)

        createUBiostatUsers()
    }

    def destroy = {
    }

    def createUBiostatUsers() {
        new User(
                username: 'montse.rue@cmb.udl.cat',
                password: springSecurityService.encodePassword('montse.rue'),
                authorities: [Role.findByAuthority('ROLE_USER')],
                givenName: 'Montse',
                familyName: 'Rué',
                isFemale: true,
                organization: Organization.findByName("UBiostat"),
                passwordExpired: true).save(flush: true)

        new User(
                username: 'cforne@irblleida.cat',
                password: springSecurityService.encodePassword('cforne'),
                authorities: [Role.findByAuthority('ROLE_USER')],
                givenName: 'Carles',
                familyName: 'Forné',
                isFemale: false,
                organization: Organization.findByName("UBiostat"),
                passwordExpired: true).save(flush: true)

        new User(
                username: 'hperpinan@irblleida.cat',
                password: springSecurityService.encodePassword('hperpinan'),
                authorities: [Role.findByAuthority('ROLE_USER')],
                givenName: 'Hèctor',
                familyName: 'Perpiñán',
                isFemale: false,
                organization: Organization.findByName("UBiostat"),
                passwordExpired: true).save(flush: true)

        new User(
                username: 'mmartinez@irblleida.cat',
                password: springSecurityService.encodePassword('mmartinez'),
                authorities: [Role.findByAuthority('ROLE_USER')],
                givenName: 'Montse',
                familyName: 'Martínez',
                isFemale: true,
                organization: Organization.findByName("UBiostat"),
                passwordExpired: true).save(flush: true)

        new User(
                username: 'jvalls@irblleida.cat',
                password: springSecurityService.encodePassword('jvalls'),
                authorities: [Role.findByAuthority('ROLE_USER')],
                givenName: 'Joan',
                familyName: 'Valls',
                isFemale: false,
                organization: Organization.findByName("UBiostat"),
                passwordExpired: true).save(flush: true)

        new User(
                username: 'ibenitez@irblleida.cat',
                password: springSecurityService.encodePassword('ibenitez'),
                authorities: [Role.findByAuthority('ROLE_USER')],
                givenName: 'Ivan',
                familyName: 'Benítez',
                isFemale: false,
                organization: Organization.findByName("UBiostat"),
                passwordExpired: true).save(flush: true)

        new User(
                username: 'sbertran@irblleida.cat',
                password: springSecurityService.encodePassword('sbertran'),
                authorities: [Role.findByAuthority('ROLE_USER')],
                givenName: 'Sandra',
                familyName: 'Bertran',
                isFemale: true,
                organization: Organization.findByName("UBiostat"),
                passwordExpired: true).save(flush: true)
    }
}
