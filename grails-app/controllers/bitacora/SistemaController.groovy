package bitacora


class SistemaController {

    def list(){

    }

    def form_ajax(){
        def sistema

        if (params.id) {
            sistema = Sistema.get(params.id)
        } else {
            sistema = new Sistema()
        }

        return [sistema: sistema]
    }


    def tablaSistemas_ajax(){
        def sistemas = Sistema.list()?.sort{it.nombre}
        return [sistemas: sistemas]
    }

    def save_ajax(){
        def sistema

        if (params.id) {
            sistema = Sistema.get(params.id)
        } else {
            sistema = new Sistema()
        }

        sistema.properties = params

        if (!sistema.save(flush: true)) {
            println("Error al guardar el sistema " + sistema.errors)
            render "no_Error al guardar el sistema"
        } else {
            render "ok_Sistema guardado correctamente"
        }
    }

    def delete_ajax(){
        def sistema = Sistema.get(params.id)

        try{
            sistema.delete(flush:true)
            render "ok_Sistema borrado correctamente"
        }catch(e){
            println("Error al borrar el sistema" + sistema.errors)
            render "no_Error al borrar el sistema"
        }
    }


}
