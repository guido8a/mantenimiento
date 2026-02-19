package bitacora

class ResponsableController {

    def list(){

    }

    def form_ajax(){

        def responsable

        if(params.id){
            responsable = Responsable.get(params.id)
        }else{
            responsable = new Responsable()
        }

        return [responsable: responsable]
    }

    def tablaResponsables_ajax(){
        def resposanbles = Responsable.list().sort{it.apellido}
        return [responsables: resposanbles]
    }

    def save_ajax(){
        def responsable

        if(params.fechaInicio){
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }

        if(params.fechaFin){
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }

        if(params.id){
            responsable = Responsable.get(params.id)
        }else{
            responsable = new Responsable()
        }

        responsable.properties = params

        if(!responsable.save(flush:true)){
            println("error al guardar el contrato " + responsable.errors)
            render "no_Error al guardar el responsable"
        }else{
            render "ok_Responsable guardado correctamente"
        }
    }

    def borrar_ajax(){
        def responsable = Responsable.get(params.id)

        try{
            responsable.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el responsable " + contrato.responsable)
            render "no"
        }
    }

    def show_ajax(){
        def responsable = Responsable.get(params.id)
        return [responsable: responsable]
    }
}
