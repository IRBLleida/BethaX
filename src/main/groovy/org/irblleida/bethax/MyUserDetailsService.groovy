package org.irblleida.bethax

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.userdetails.GrailsUserDetailsService
import grails.plugin.springsecurity.userdetails.NoStackUsernameNotFoundException
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails

class MyUserDetailsService implements GrailsUserDetailsService {

    /**
     * Some Spring Security classes (e.g. RoleHierarchyVoter) expect at least
     * one role, so we give a user with no granted roles this one which gets
     * past that restriction but doesn't grant anything.
     */
    static final List NO_ROLES = [new SimpleGrantedAuthority(SpringSecurityUtils.NO_ROLE)]

    UserDetails loadUserByUsername(String username, boolean loadRoles) {
        def user = User.findByUsername(username)
        if (!user) {
            throw new NoStackUsernameNotFoundException()
        }

        def roles
        if (loadRoles) {
            roles = user.authorities?.collect {new SimpleGrantedAuthority(it.authority)}
        }

        new MyUserDetails(user.username, user.password, user.enabled,
                !user.accountExpired, !user.passwordExpired,
                !user.accountLocked, roles ?: NO_ROLES, user.id,
                user.givenName, user.familyName, user.organization, user.lang)
    }

    UserDetails loadUserByUsername(String username) {
        loadUserByUsername username, true
    }
}
