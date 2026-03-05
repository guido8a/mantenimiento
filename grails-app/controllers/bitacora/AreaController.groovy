package bitacora

class AreaController {

    def list(){

    }

    def form_ajax(){

        def area

        if(params.id){
            area = Area.get(params.id)
        }else{
            area = new Area()
        }

        return [area: area]
    }

    def tablaAreas_ajax(){
        def areas = Area.list().sort{it.nombre}
        return [areas: areas]
    }

    def save_ajax(){

        def area

        if(params.id){
            area = Area.get(params.id)
        }else{
            area = new Area()
        }

        area.properties = params

        if(!area.save(flush:true)){
            println("Error al guardar el área" + area.errors)
            render "no_Error al guardar el área"
        }else{
            render "ok_Área guardada correctamente"
        }
    }

    def borrar_ajax(){

        def area = Area.get(params.id)

        try{
            area.delete(flush:true)
            render "ok_Área borrada correctamente"
        }catch(e){
            println("Error al borrar el área" + area.errors)
            render "no_Error al borrar el área"
        }
    }

}
