package org.irblleida.bethax

public enum InstitutionType {
    INTERNAL(1),
    PUBLIC_EXTERNAL(2),
    PRIVATE_EXTERNAL(3)

    private final Integer value

    private InstitutionType(Integer value) {
        this.value = value
    }

    Integer value() { value }
}

public enum ResearchProjectType {
    FIS(1),
    MINISTRY(2),
    MARATHON(3),
    OTHERS(4)

    private final Integer value

    private ResearchProjectType(Integer value) {
        this.value = value
    }

    Integer value() { value }
}

public enum StudyType {
    FUNDED_WITH_SUPPORT(1),
    FUNDED_WITHOUT_SUPPORT(2),
    NOT_FUNDED(3),
    NEW_PROJECT(4),
    OTHERS(5)

    private final Integer value

    private StudyType(Integer value) {
        this.value = value
    }

    Integer value() { value }
}

public enum ResearchGroup {
    OTHER_RESEARCH_LINES(1),
    BIOLOGY_STATISTICS(2),
    MOLECULAR_BIOLOGY(3),
    BIOCHEMISTRY(4)

    private final Integer value

    private ResearchGroup(Integer value) {
        this.value = value
    }

    Integer value() { value }
}

public enum NoWorkPlanReason {
    SPORADIC_CONSULTATION(1),
    REVIEWER_RESPONSE(2),
    OTHERS(3)

    private final Integer value

    private NoWorkPlanReason(Integer value) {
        this.value = value
    }

    Integer value() { value }
}
