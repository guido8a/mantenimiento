package bitacora

class ModuloSistema {

    String codigo
    String descripcion

    static mapping = {
        table 'mdst'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'mdst__id'
            codigo column: 'mdstcdgo'
            descripcion column: 'mdstdscr'
        }
    }
    static constraints = {
        codigo(size: 1..4, blank: false)
        descripcion(size: 3..63, blank: false)
    }

}
