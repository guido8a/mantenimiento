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

    }


}
