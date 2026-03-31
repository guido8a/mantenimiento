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
        def listaItems = ['actvdscr', 'actvclve', 'actvreqm', 'usronmbr', 'usroapll']
        def bsca
        def tipoTx = ''
        def periodoTx = ''
        def usuarioTx = ''
        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }

//        if(params.usuario && params.usuario != 'null'){
//            def usuario = Usuario.get(params.usuario)
//            usuarioTx = " and actv.usro__id = ${usuario?.id} "
//        }

        if(params.periodo && params.periodo != 'null'){
            def periodo = Periodo.get(params.periodo)
            periodoTx = " and actv.prdo__id = ${periodo?.id} "
        }

        if(params.tipo && params.tipo != 'null'){
            def tipo = TipoMantenimiento.get(params.tipo)
            tipoTx = " and actv.tpmt__id = ${tipo?.id} "
        }

        def select  =  "select actv__id, usronmbr||' '||usroapll usuario, tpmtcdgo, actvfcha, actvdscr, actvreqm from actv, tpmt, usro "
        def txwh = " where tpmt.tpmt__id = actv.tpmt__id and usro.usro__id = actv.usro__id and " +
                "${bsca} ilike '%${params.criterio}%' ${usuarioTx} ${periodoTx} ${tipoTx} "
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
        return [tipo: params.tipo, usuarioId: params.usuario]
    }

    def tablaBuscarUsuario_ajax(){

        println("tabla buscar usuario " + params)
        def usuarioActual = Persona.get(session.usuario.id)
        def empresa = usuarioActual.empresa
        def usuario
        def textoAd = ''
        if(params.usuario){
            usuario = Usuario.get(params.usuario)
            textoAd = " and usro__id != '${usuario?.id}' "
        }

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
        def txwh = " where usro__id is not null and empr__id = '${empresa?.id}' ${textoAd} and ${bsca} ilike '%${params.criterio}%'"
        sqlTx = "${select} ${txwh} order by usroapll limit 50 ".toString()
        def cn = dbConnectionService.getConnection()
        datos = cn.rows(sqlTx)
        println("sql " + sqlTx)
        [data: datos, tipo: params.tipo]
    }

    def form_ajax(){

        def actividad
        def contrato
        def cn = dbConnectionService.getConnection()
        def sql = "select cntr__id from cntr where now()::date between cntrfcin and cntrfcfn"
        println "SQL: $sql"
        contrato = cn.rows(sql.toString())[0].cntr__id

        def contratos = Contrato.list([sort: 'fechaSubscripcion'])
        if(params.id){
            actividad = Actividad.get(params.id)
        }else{
            actividad = new Actividad()
        }

        return [actividad: actividad, contratos: contratos, contrato: contrato]
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

        if(params.descripcion){
            String cc = util.clean(str: params.descripcion)
            params.descripcion = cc
        }

        if(params.algoritmo){
            String cc2 = util.clean(str: params.algoritmo)
            params.algoritmo = cc2
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

    def periodo_ajax(){
        def contrato = Contrato.get(params.contrato)
        def periodos = Periodo.findAllByContrato(contrato).sort{it.numero}
        def actividad
        if(params.actividad){
            actividad = Actividad.get(params.actividad)
        }else{
            actividad = new Actividad()
        }

        return [periodos: periodos, actividad: actividad]
    }

    def buscarContrato_ajax(){

    }

    def tablaPeriodos_ajax(){

        def contrato
        def periodos

        if(params.contrato != 'null'){
            contrato = Contrato.get(params.contrato)
            periodos = Periodo.findAllByContrato(contrato).sort{it.numero}
        }else{
            periodos = Periodo.list().sort{it.numero}
        }

        return [periodos: periodos]
    }

    def showActividad_ajax(){
        def actividad = Actividad.get(params.id)
        return [actividad: actividad]
    }

    def reporte(){
        def datos;
        def claves = []
        def cn = dbConnectionService.getConnection()
        def sql = "SELECT palabra, COUNT(*) as cantidad FROM ( " +
                "SELECT unnest(string_to_array(lower( replace(actvclve, ' de ', ' ')), ' ')) as palabra from actv ) as palabras " +
                "GROUP BY palabra having count(*) > 1 ORDER BY 2 desc"
        datos = cn.rows(sql)

        datos.each {
            def mp = [:]
            mp['palabra'] = it.palabra
            mp['cantidad'] = it.cantidad
            //claves += mp
            claves.add(mp)
        }

        println "claves: $claves"
        return [claves: claves]
    }

    def tablaReporteActividades_ajax(){
        def actividades = Actividad.findAllByClaveIlike('%' + params.clave + '%').sort{it.fecha}
        return [actividades: actividades]
    }

    def ocurrencias_ajax(){

        println("--> " + params)



        def datos;
        def cantidad
        def cn = dbConnectionService.getConnection()
        def sql = "SELECT palabra, COUNT(*) as cantidad FROM ( " +
                "SELECT unnest(string_to_array(lower( replace(actvclve, ' de ', ' ')), ' ')) as palabra from actv ) as palabras " +
                "GROUP BY palabra having count(*) > 1 ORDER BY palabra;"
        datos = cn.rows(sql)

        datos.each {
            if(it.palabra == params.clave){
                cantidad = it.cantidad
            }
        }

        println("datos " + cantidad)

       render "${cantidad}"
    }
}
