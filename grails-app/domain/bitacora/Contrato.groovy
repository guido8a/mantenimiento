package bitacora

class Contrato {

    Empresa empresa
    String numero
    Date fechaSubscripcion
    Date fechaInicio
    Date fechaFin
    String objeto

    static mapping = {
        table 'cntr'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'cntr__id'
            empresa column: 'empr__id'
            numero column: 'cntrnmro'
            fechaSubscripcion column: 'cntrfcsb'
            fechaInicio column: 'cntrfcin'
            fechaFin column: 'cntrfcfn'
            objeto column: 'cntrnobjt'
        }
    }
    static constraints = {
        empresa(blank: false, nullable: false)
        numero(size: 1..20, blank: false, nullable: false)
        fechaSubscripcion(blank: true, nullable: true)
        fechaInicio(blank: true, nullable: true)
        fechaFin(blank: true, nullable: true)
        objeto(size: 0..255, blank: true, nullable: true)
    }
}
