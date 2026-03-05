package bitacora

class Cambio {

    Responsable responsable
    Usuario usuario
    String numero
    Date fecha
    String descripcion
    String descripcionSeguridad
    String justificacion
    String impactoConfidencialidad
    String impactoDisponibilidad
    String impactoIntegridad
    String planPruebas
    String analisisTecnico
    String aceptado
    String observaciones

    static mapping = {
        table 'cmbo'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'cmbo__id'
            responsable column: 'rspn__id'
            usuario column: 'usro__id'
            numero column: 'cmbonmro'
            fecha column: 'cmbofcsl'
            descripcion column: 'cmbodscr'
            descripcionSeguridad column: 'cmbodssg'
            justificacion column: 'cmbojust'
            impactoConfidencialidad column: 'cmboipcf'
            impactoDisponibilidad column: 'cmboipds'
            planPruebas column: 'cmboplpb'
            analisisTecnico column: 'cmboantc'
            aceptado column: 'cmboacpt'
            impactoIntegridad column: 'cmboipin'
            observaciones column: 'cmboobsr'
        }
    }
    static constraints = {
        responsable(blank: true, nullable: true)
        usuario(blank: true, nullable: true)
        numero(size: 0..20, blank: true, nullable: true)
        fecha(blank: true, nullable: true)
        descripcion(size: 0..255, blank: true, nullable: true)
        descripcionSeguridad(size: 0..255, blank: true, nullable: true)
        justificacion(size: 0..255, blank: true, nullable: true)
        impactoConfidencialidad(blank: true, nullable: true)
        impactoDisponibilidad(blank: true, nullable: true)
        planPruebas(size: 0..255, blank: true, nullable: true)
        analisisTecnico(size: 0..255, blank: true, nullable: true)
        aceptado(blank: true, nullable: true)
        impactoIntegridad(blank: true, nullable: true)
        observaciones(size: 0..255, blank: true, nullable: true)
    }
}
