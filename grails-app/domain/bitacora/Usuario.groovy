package bitacora

class Usuario {

    Empresa empresa
    String cedula
    String nombre
    String apellido
    Date fechaInicio
    Date fechaFin
    String titulo
    String mail
    String telefono
    String activo
    String sexo

    static mapping = {
        table 'usro'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'pcnt__id'
            empresa column: 'empr__id'
            cedula column: 'pcntcdla'
            nombre column: 'pcntnmbr'
            apellido column: 'pcntapll'
            fechaInicio column: 'pcntfcin'
            fechaFin column: 'pcntfcfn'
            mail column: 'pcntmail'
            telefono column: 'pcnttelf'
            titulo column: 'pcnttitl'
            activo column: 'pcntactv'
            sexo column: 'pcntsexo'
        }
    }
    static constraints = {
        empresa(blank: false, nullable: false)
        cedula(size: 10..10, blank: false, nullable: false)
        nombre(size: 3..31, blank: false, nullable: false)
        apellido(size: 3..31, blank: false, nullable: false)
        sexo(inList: ["F", "M"], size: 1..1, blank: false, attributes: ['mensaje': 'Sexo del usuario'])
        mail(size: 3..63, blank: true, nullable: true)
        titulo(size: 1..4, blank: true, nullable: true)
        activo(blank: false,  attributes: [title: 'activo'])
        telefono(blank: true, nullable: true,  attributes: [title: 'teléfono'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'Fecha de inicio'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'Fecha de finalización'])
    }
}
