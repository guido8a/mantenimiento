package bitacora

class Oficio {

    Contrato contrato
    Periodo periodo
    String numero
    Date fecha
    String texto

    static mapping = {
        table 'ofco'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'ofco__id'
            contrato column: 'cntr__id'
            periodo column: 'prdo__id'
            numero column: 'ofconmro'
            fecha column: 'ofcofcha'
            texto column: 'ofcotxto'
        }
    }
    static constraints = {
        contrato(blank: false, nullable: false)
        periodo(blank: false, nullable: false)
        numero(size: 0..31, blank: true, nullable: true)
        fecha(blank: true, nullable: true)
        texto(blank: true, nullable: true)
    }
}
