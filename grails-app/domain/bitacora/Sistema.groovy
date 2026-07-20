package bitacora

class Sistema {

    String siglas
    String nombre
    String base

    static mapping = {
        table 'stma'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'stma__id'
            siglas column: 'stmasgla'
            nombre column: 'stmanmbr'
            base column: 'stmabbdd'
        }
    }
    static constraints = {
        siglas(size: 1..15, blank: false, nullable: false)
        nombre(size: 3..255, blank: false, nullable: false)
        base(size: 3..15, blank: false, nullable: false)
    }
}
