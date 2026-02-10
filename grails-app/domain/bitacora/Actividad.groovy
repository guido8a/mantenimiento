package bitacora

import audita.Auditable

class Actividad implements Auditable{

    Usuario usuario
    TipoMantenimiento tipoMantenimiento
    ModuloSistema moduloSistema
    Periodo periodo
    String requerimiento
    Date fecha
    String descripcion
    String algoritmo
    String clave

    static mapping = {
        table 'actv'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false
        columns {
            id column: 'actv__id'
            usuario column: 'usro__id'
            tipoMantenimiento column: 'tpmt__id'
            moduloSistema column: 'mdst__id'
            periodo column: 'prdo__id'
            requerimiento column: 'actvreqm'
            fecha column: 'actvfcha'
            descripcion column: 'actvdscr'
            algoritmo column: 'actvalgr'
            clave column: 'actvclve'
        }
    }

    static constraints = {
        usuario(blank: false, nullable: false)
        tipoMantenimiento(blank: true, nullable: true)
        moduloSistema(blank: true, nullable: true)
        periodo(blank: true, nullable: true)
        requerimiento(size: 0..15, blank: true, nullable: true)
        fecha(blank: true, nullable: true)
        descripcion(size: 0..512, blank: true, nullable: true)
        algoritmo(size: 0..512, blank: true, nullable: true)
        clave(size: 0..63, blank: true, nullable: true)
    }

}
