package org.irblleida.bethax

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import org.bson.types.ObjectId

@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class User implements Serializable {

    private static final long serialVersionUID = 1

    transient springSecurityService

    Date dateCreated

    ObjectId id
    String username
    String password
    Organization organization
    String givenName
    String familyName
    String position
    String website
    String biography
    Boolean isFemale
    String lang = 'ca'
    String passwordResetToken = null
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    Date lastLogin
    Integer loginCount = 0

    Set<Role> authorities
    static embedded = ['authorities']

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

    static transients = ['springSecurityService']

    //static hasMany = [oAuthIDs: OAuthID]

    static constraints = {
        password nullable: false, blank: false, password: true, size: 6..64
        username nullable: false, blank: false, unique: true, email: true
        organization nullable: true
        position nullable: true, blank: true
        website nullable: true, blank: true
        biography nullable: true, blank: true
        isFemale nullable: false
        passwordResetToken nullable: true
        lastLogin nullable: true
        loginCount nullable: false, min: 0
    }

    static mapping = {
	    password column: '`password`'
    }

    String toString() {
        givenName + " " + familyName
    }
}
