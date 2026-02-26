package bitacora

class Periodo {

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
            numero column: 'prdonmro'
            fechads column: 'prdofcds'
            fechahs column: 'prdofchs'
            lineas column: 'prdolnea'
        }
    }
    static constraints = {
        numero(size: 1..15, blank: false)
        fechads(blank: false, nullable: false)
        fechahs(blank: false, nullable: false)
    }
}
