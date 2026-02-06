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
        def txwh = " where pcnt__id is not null and ${bsca} ilike '%${params.criterio}%'"
        sqlTx = "${select} ${txwh} order by pcntapll limit 50 ".toString()
        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        [data: datos, tipo: params.tipo]
    }

    def form_ajax(){
        def usuario

        if(params.id){
            usuario = Usuario.get(params.id)
        }else{
            usuario = new Usuario()
        }
        return [usuario: usuario]
    }


    def save_ajax(){

        def usuario

        if(params.fechaInicio){
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }

        if(params.fechaFin){
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }

        if(params.activoName){
            params.activo = '1'
        }else{
            params.activo = '0'
        }

        if(params.id){
            usuario = Usuario.get(params.id)
        }else{
            usuario = new Usuario()
        }

        usuario.properties = params

        if(!usuario.save(flush:true)){
            println("Error al guardar el usuario " + usuario.errors)
            render"no_Error al guardar el usuario"
        }else{
            render "ok_Guardado correctamente"
        }
    }

    def delete_ajax(){

        def usuario = Usuario.get(params.id)

        try{
            usuario.delete(flush:true)
            render "ok_Borrado correctamente"
        }catch(e){
            println("Error al borrar la persona " + usuario.errors)
            render"no_Error al borrar el usuario"
        }
    }

    def show_ajax(){
        def usuario = Usuario.get(params.id)
        return [usuario: usuario]
    }

}
