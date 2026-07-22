package bitacora


class QueryController {

    def dbConnectionService

    def list(){

    }

    def tablaQuerys_ajax() {
        println("tabla " + params)
        def listaItems = ['sqlsprbl', 'sqlsclve', 'sqlsalgr', 'sqlsrefe']
        def bsca = listaItems[params.buscarPor?.toInteger()-1]
        def select = " select * from sqls where sqls__id is not null and stma__id = ${params.sistema} and ${bsca} ilike '%${params.criterio}%' "
        def sqlTx = "${select} order by sqlsprbl limit 50 ".toString()
        println("tx " + sqlTx)
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)
        return [data: datos, tipo: params.tipo]
    }

    def form_ajax(){
        def query

        if(params.id){
            query = Query.get(params.id)
        }else{
            query = new Query()
        }

        return [query: query]
    }

    def save_ajax() {
        def query

        if(params.id){
            query = Query.get(params.id)
        }else{
            query = new Query()
        }

        params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        query.properties = params

        if(!query.save(flush:true)){
           println("error al guardar el query " + query.errors)
            render "no_Error al guardar"
        }else{
            render "ok_Guardado correctamente"
        }
    }

    def borrar_ajax() {
        def query = Query.get(params.id)

        try{
            query.delete(flush: true)
            render "ok_Registro borrado correctamente"
        }catch(e){
            println("error al borrar el query " + query.errors)
            render "no_Error al borrar el registro"
        }
    }

    def showQuery_ajax(){
        def query = Query.get(params.id)
        return [query: query]
    }

}
