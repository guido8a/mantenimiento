package bitacora

class Area {

    Area padre
    String nombre

    static mapping = {
        table 'area'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'area__id'
            padre column: 'areapdre'
            nombre column: 'areanmbr'
        }
    }
    static constraints = {
        padre(blank: true, nullable: true)
        nombre(size: 1..127, blank: false, nullable: false)
    }
}
