package bitacora

class PeriodoController {

    def list(){

    }

    def tablaPeriodos_ajax(){
        def periodos = Periodo.list().sort{it.numero}
        return [periodos: periodos]
    }

    def form_ajax(){
        def periodo

        if(params.id){
            periodo = Periodo.get(params.id)
        }else{
            periodo = new Periodo()
        }

        return [periodo: periodo]
    }

    def save_ajax(){
        def periodo

        if(params.fechaInicio){
            params.fechads = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }

        if(params.fechaFin){
            params.fechahs = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }

        if(params.id){
            periodo = Periodo.get(params.id)
        }else{
            periodo = new Periodo()
        }

        periodo.properties = params

        if(!periodo.save(flush:true)){
            println("error al guardar el período " + periodo.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def borrar_ajax(){
        def periodo = Periodo.get(params.id)

        try{
            periodo.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el período " + periodo.errors)
            render "no"
        }
    }

}
