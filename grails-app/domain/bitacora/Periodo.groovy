package bitacora

class Periodo {
    Contrato contrato
    String numero
    Date fechads
    Date fechahs
    int lineas = 0

    static mapping = {
        table 'prdo'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'prdo__id'
            contrato column: 'cntr__id'
            numero column: 'prdonmro'
            fechads column: 'prdofcds'
            fechahs column: 'prdofchs'
            lineas column: 'prdolnea'
        }
    }
    static constraints = {
        contrato(blank: false, nullable: false)
        numero(size: 1..15, blank: false)
        fechads(blank: false, nullable: false)
        fechahs(blank: false, nullable: false)
    }
}
