package bitacora

class ContratoController {

    def list(){

    }

    def form_ajax(){

        def contrato

        if(params.id){
            contrato = Contrato.get(params.id)
        }else{
            contrato = new Contrato()
        }

        return [contrato:contrato]
    }

    def tablaContratos_ajax(){
        def contratos = Contrato.list().sort{it.fechaSubscripcion}
        return [contratos: contratos]
    }

    def save_ajax(){
        def contrato

        if(params.fechaInicio){
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }

        if(params.fechaFin){
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }

        if(params.fechaSubscripcion){
            params.fechaSubscripcion = new Date().parse("dd-MM-yyyy", params.fechaSubscripcion)
        }

        if(params.id){
            contrato = Contrato.get(params.id)
        }else{
            contrato = new Contrato()
        }

        contrato.properties = params

        if(!contrato.save(flush:true)){
            println("error al guardar el contrato " + contrato.errors)
            render "no_Error al guardar el contrato"
        }else{
            render "ok_Contrato guardado correctamente"
        }
    }

    def borrar_ajax(){
        def contrato = Contrato.get(params.id)

        try{
            contrato.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el contrto " + contrato.errors)
            render "no"
        }
    }

}
