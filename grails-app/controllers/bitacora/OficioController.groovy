package bitacora

class OficioController {

    def list(){

    }

    def tablaOficios_ajax(){
        def oficios = Oficio.list().sort{it.numero}
        return [oficios: oficios]
    }

    def form_ajax(){

        def oficio

        if(params.id){
            oficio = Oficio.get(params.id)
        }else{
            oficio = new Oficio()
        }

        return [oficio: oficio]
    }

    def save_ajax(){

        println("params  " + params)

        def oficio

        if(params.id){
            oficio = Oficio.get(params.id)
        }else{
            oficio = new Oficio()
        }

        if(params.fecha){
            params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        }

        oficio.properties = params

        if(!oficio.save(flush:true)){
            println("Error al guardar el oficio " + oficio.errors)
            render "no_Error al guardar el oficio"
        }else{
            render "ok_Oficio guardado correctamente"
        }
    }

    def show_ajax(){
       def oficio = Oficio.get(params.id)
        return [oficio: oficio]
    }

    def borrar_ajax(){
        def oficio = Oficio.get(params.id)

        try{
            oficio.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el oficio " + oficio.errors)
            render "no"
        }
    }

}
