package bitacora

class Responsable {

    Contrato contrato
    String nombre
    String apellido
    Date fechaInicio
    Date fechaFin
    String mail
    String cargo
    String departamento
    String titulo
    String telefono
    String sexo

    static mapping = {
        table 'rspn'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'rspn__id'
            contrato column: 'cntr__id'
            nombre column: 'rspnnmbr'
            apellido column: 'rspnapll'
            fechaInicio column: 'rspnfcin'
            fechaFin column: 'rspnfcfn'
            mail column: 'rspnmail'
            cargo column: 'rspncrgo'
            departamento column: 'rspndpto'
            titulo column: 'rspntitl'
            telefono column: 'rspntelf'
            sexo column: 'rspnsexo'
        }
    }
    static constraints = {
        contrato(blank: false, nullable: false)
        nombre(size: 3..31, blank: false, nullable: false)
        apellido(size: 0..31, blank: true, nullable: true)
        fechaInicio(blank: true, nullable: true)
        fechaFin(blank: true, nullable: true)
        mail(size: 0..63, blank: true, nullable: true)
        cargo(size: 0..127, blank: true, nullable: true)
        departamento(size: 0..127, blank: true, nullable: true)
        titulo(size: 0..31, blank: true, nullable: true)
        telefono(size: 0..31, blank: true, nullable: true)
        sexo(size: 0..1, blank: true, nullable: true)
    }
}
