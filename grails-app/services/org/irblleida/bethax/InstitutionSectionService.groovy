package org.irblleida.bethax

import grails.gorm.services.Service

@Service(InstitutionSection)
interface InstitutionSectionService {

    InstitutionSection get(Serializable id)

    List<InstitutionSection> list(Map args)

    Long count()

    void delete(Serializable id)

    InstitutionSection save(InstitutionSection institutionSection)

}