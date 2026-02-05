package bitacora

class UsuarioController {

    def dbConnectionService

    def list(){

    }

    def tablaUsuarios_ajax(){
        println("tabla usuarios " + params)
        def datos;
        def sqlTx = ""
        def listaItems = ['pcntcdla', 'pcntnmbr', 'pcntapll' ]
        def bsca
        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select  =  " select * from usro "
        def txwh = " where usro__id is not null and ${bsca} ilike '%${params.criterio}%'"
        sqlTx = "${select} ${txwh} order by pcntapll limit 50 ".toString()
        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        [data: datos, tipo: params.tipo]
    }




}
