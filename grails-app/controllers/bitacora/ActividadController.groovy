package bitacora

import seguridad.Persona

class ActividadController {

    def dbConnectionService

    def list(){
    }

    def tablaActividades_ajax(){

        println("tabla atividades " + params)
        def datos;
        def sqlTx = ""
        def listaItems = ['actvreqm', 'actvclve' ]
        def bsca
        def tipoTx = ''
        def periodoTx = ''
        def usuarioTx = ''
        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }

        if(params.usuario && params.usuario != 'null'){
            def usuario = Usuario.get(params.usuario)
            usuarioTx = " and actv.usro__id = ${usuario?.id} "
        }

        if(params.periodo && params.periodo != 'null'){
            def periodo = Periodo.get(params.periodo)
            periodoTx = " and actv.prdo__id = ${periodo?.id} "
        }

        if(params.tipo && params.tipo != 'null'){
            def tipo = TipoMantenimiento.get(params.tipo)
            tipoTx = " and actv.tpmt__id = ${tipo?.id} "
        }

        def select  =  " select * from actv "
        def txwh = " where actv__id is not null and ${bsca} ilike '%${params.criterio}%' ${usuarioTx} ${periodoTx} ${tipoTx} "
        sqlTx = "${select} ${txwh} order by actvfcha limit 50 ".toString()
        println("tx " + sqlTx)
        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        [data: datos, tipo: params.tipo]
    }

    def verActividad(){
        def actividad = null
        if(params.id){
            actividad = Actividad.get(params.id)
        }
        return [actividad: actividad]
    }

    def buscarUsuario_ajax(){
        return [tipo: params.tipo]
    }

    def tablaBuscarUsuario_ajax(){

        println("tabla buscar usuario " + params)
        def usuarioActual = Persona.get(session.usuario.id)
        def empresa = usuarioActual.empresa

        def datos;
        def sqlTx = ""
        def listaItems = ['usrocdla', 'usronmbr', 'usroapll' ]
        def bsca
        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select  =  " select * from usro "
        def txwh = " where usro__id is not null and empr__id = '${empresa?.id}' and ${bsca} ilike '%${params.criterio}%'"
        sqlTx = "${select} ${txwh} order by usroapll limit 50 ".toString()
        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        [data: datos, tipo: params.tipo]
    }

    def form_ajax(){

        def actividad

        if(params.id){
            actividad = Actividad.get(params.id)
        }else{
            actividad = new Actividad()
        }

        return [actividad: actividad]
    }

    def save_ajax(){

        def actividad

        if(params.id){
            actividad = Actividad.get(params.id)
        }else{
            actividad = new Actividad()
        }

        if(params.fecha){
            params.fecha = new Date().parse("dd-MM-yyyy HH:mm", params.fecha)
        }

        actividad.properties = params

        if(!actividad.save(flush:true)){
            println("Error al guardar la actividad " + actividad.errors)
            render "no_Error al guardar la actividad"
        }else{
            render "ok_Actividad guardada correctamente"
        }
    }

    def borrar_ajax(){
        def actividad = Actividad.get(params.id)

        try{
            actividad.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la actividad " + actividad.errors)
            render "no"
        }
    }
}
