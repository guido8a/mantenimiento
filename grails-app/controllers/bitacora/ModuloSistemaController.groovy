package bitacora

class ModuloSistemaController {

    def list(){

    }

    def tablaSistemas_ajax(){
        def modulos = ModuloSistema.list().sort{it.codigo}
        return [modulos: modulos]
    }

    def form_ajax(){
        def modulo

        if(params.id){
            modulo = ModuloSistema.get(params.id)
        }else{
            modulo = new ModuloSistema()
        }

        return [modulo: modulo]
    }

    def save_ajax(){

        def modulo

        if(params.id){
            modulo = ModuloSistema.get(params.id)
        }else{
            modulo = new ModuloSistema()
        }

        params.codigo = params.codigo.toUpperCase();

        modulo.properties = params

        if(!modulo.save(flush:true)){
            println("Error al guardar el módulo " + modulo.errors)
            render "no_Error al guardar el módulo"
        }else{
            render "ok_Módulo guardado correctamente"
        }
    }

    def borrar_ajax(){
        def modulo = ModuloSistema.get(params.id)

        try{
            modulo.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el modulo " + modulo.errors)
            render "no"
        }
    }

}
