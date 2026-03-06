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
        def cambios = Cambio.list().sort{it.numero}
        return [cambios: cambios]
    }

    def save_ajax() {

        def cambio

        if(params.fecha){
            params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
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
