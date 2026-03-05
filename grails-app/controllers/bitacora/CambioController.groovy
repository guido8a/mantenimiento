package bitacora

class CambioController {

    def list(){

    }

    def form_ajax(){

        def cambio

        if(params.id){
            cambio = Cambio.get(params.id)
        }else{
            cambio = new Cambio()
        }

        return [cambio: cambio]
    }

    def tablaCambios_ajax(){
        def usuario = Usuario.get(session.usuario.id)
        def cambios = Cambio.findAllByUsuario(usuario).sort{it.numero}

        return [cambios: cambios]
    }

    def save_ajax() {

        def cambio
        def usuario = Usuario.get(session.usuario.id)

        params.fecha = new Date()
        params.usuario = usuario

        if (params.impactoConfidencialidadName) {
            params.impactoConfidencialidad = '1'
        } else {
            params.impactoConfidencialidad = '0'
        }

        if (params.impactoDisponibilidadName) {
            params.impactoDisponibilidad = '1'
        } else {
            params.impactoDisponibilidad = '0'
        }

        if (params.impactoIntegridadName) {
            params.impactoIntegridad = '1'
        } else {
            params.impactoIntegridad = '0'
        }

        if (params.aceptadoName) {
            params.aceptado = '1'
        } else {
            params.aceptado = '0'
        }

        if (params.id) {
            cambio = Cambio.get(params.id)
        } else {
            cambio = new Cambio()
        }

        cambio.properties = params

        if (!cambio.save(flush: true)) {
            println("Error al guardar el usuario " + cambio.errors)
            render "no_Error al guardar el cambio"
        } else {
            render "ok_Cambio guardado correctamente"
        }
    }

    def borrar_ajax(){

        def cambio = Cambio.get(params.id)

        try{
            cambio.delete(flush:true)
            render "ok_Cambio borrado correctamente"
        }catch(e){
            println("Error al borrar el cambio" + cambio.errors)
            render "no_Error al borrar el cambio"
        }
    }


}
