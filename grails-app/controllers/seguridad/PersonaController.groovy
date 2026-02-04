package seguridad

class PersonaController {

    def dbConnectionService

    def list(){

    }

    def tablaPersonas_ajax(){
        println("tabla personas " + params)
        def datos;
        def sqlTx = ""
        def listaItems = ['prsnlogn', 'prsnnmbr', 'prsnapll' ]
        def bsca
        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select  =  " select * from prsn "
        def txwh = " where prsn__id is not null and ${bsca} ilike '%${params.criterio}%'"
        sqlTx = "${select} ${txwh} order by prsnapll limit 50 ".toString()
        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        [data: datos, tipo: params.tipo]
    }

    def show_ajax(){
        def persona = Persona.get(params.id)
        return [personaInstance: persona]
    }

}
