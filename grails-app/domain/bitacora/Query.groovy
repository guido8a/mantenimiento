package bitacora

import audita.Auditable

class Query implements Auditable{

    Sistema sistema
    Date fecha
    String problema
    String algoritmo
    String referencia
    String clave

    static mapping = {
        table 'sqls'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false
        columns {
            id column: 'sqls__id'
            sistema column: 'stma__id'
            fecha column: 'sqlsfcha'
            problema column: 'sqlsprbl'
            algoritmo column: 'sqlsalgr'
            referencia column: 'sqlsrefe'
            clave column: 'sqlsclve'
        }
    }

    static constraints = {
        sistema(blank: false, nullable: false)
        fecha(blank: true, nullable: true)
        problema(blank: false, nullable: false)
        algoritmo(blank: true, nullable: true)
        referencia(blank: true, nullable: true)
        clave(size: 0..63, blank: true, nullable: true)
    }

}
