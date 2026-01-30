package bitacora

class TipoMantenimiento {

    String codigo
    String descripcion

    static mapping = {
        table 'tpmt'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'tpmt__id'
            codigo column: 'tpmtcdgo'
            descripcion column: 'tpmtdscr'
        }
    }
    static constraints = {
        codigo(size: 1..2, blank: false)
        descripcion(size: 3..63, blank: false)
    }

}
