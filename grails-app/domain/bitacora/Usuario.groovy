package bitacora

class Usuario {

    Empresa empresa
    Area area
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
    Usuario jefe

    static mapping = {
        table 'usro'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'usro__id'
            empresa column: 'empr__id'
            area column: 'area__id'
            cedula column: 'usrocdla'
            nombre column: 'usronmbr'
            apellido column: 'usroapll'
            fechaInicio column: 'usrofcin'
            fechaFin column: 'usrofcfn'
            mail column: 'usromail'
            telefono column: 'usrotelf'
            titulo column: 'usrotitl'
            activo column: 'usroactv'
            sexo column: 'usrosexo'
            jefe column: 'usrojefe'
        }
    }
    static constraints = {
        empresa(blank: false, nullable: false)
        area(blank: true, nullable: true)
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
        jefe(blank: true, nullable: true)
    }
}
