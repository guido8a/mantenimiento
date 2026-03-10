package bitacora

class Sistema {

    String siglas
    String nombre

    static mapping = {
        table 'stma'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'stma__id'
            siglas column: 'stmasgla'
            nombre column: 'stmanmbr'
        }
    }
    static constraints = {
        siglas(size: 1..15, blank: false, nullable: false)
        nombre(size: 3..255, blank: false, nullable: false)
    }
}
