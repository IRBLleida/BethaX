package org.irblleida.bethax

import grails.plugin.springsecurity.userdetails.GrailsUser
import org.bson.types.ObjectId
import org.springframework.security.core.GrantedAuthority

class MyUserDetails extends GrailsUser {

    final String givenName
    final String familyName
    final Organization organization
    final String lang

    MyUserDetails(String username, String password, boolean enabled,
                  boolean accountNonExpired, boolean credentialsNonExpired,
                  boolean accountNonLocked,
                  Collection<GrantedAuthority> authorities,
                  ObjectId id, String givenName, String familyName, Organization organization, String lang) {
        super(username, password, enabled, accountNonExpired,
                credentialsNonExpired, accountNonLocked, authorities, id)

        this.givenName = givenName
        this.familyName = familyName
        this.organization = organization
        this.lang = lang
    }
}
