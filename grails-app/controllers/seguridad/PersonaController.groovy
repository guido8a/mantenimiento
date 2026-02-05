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
        def perfiles = Sesn.findAllByUsuarioAndFechaFinIsNull(persona)
        return [personaInstance: persona, perfiles: perfiles]
    }

    def form_ajax(){
        def personaInstance

        if(params.id){
            personaInstance = Persona.get(params.id)
        }else{
            personaInstance = new Persona()
        }
        return [personaInstance: personaInstance]
    }

    def save_ajax(){

        def persona

        if(params.activoName){
            params.activo = '1'
        }else{
            params.activo = '0'
        }

        if(params.id){
            persona = Persona.get(params.id)
        }else{
            persona = new Persona()
            params.password =  '123'.encodeAsMD5()
            params.autorizacion = '123'.encodeAsMD5()
        }

        persona.properties = params

        if(!persona.save(flush:true)){
            println("Error al guardar la persona " + persona.errors)
            render"no_Error al guardar la persona"
        }else{
            render "ok_Guardado correctamente"
        }
    }

    def delete_ajax(){

        def persona = Persona.get(params.id)

        try{
            persona.delete(flush:true)
            render "ok_Borrado correctamente"
        }catch(e){
            println("Error al borrar la persona " + persona.errors)
            render"no_Error al borrar la persona"
        }
    }

    def restablecer_ajax(){
        def persona = Persona.get(params.id)

        persona.password = '123'.encodeAsMD5()
        persona.autorizacion = '123'.encodeAsMD5()

        if(!persona.save(flush:true)){
            println("Error al guardar la persona " + persona.errors)
            render"no_Error al guardar la persona"
        }else{
            render "ok_Guardado correctamente"
        }
    }

    def perfiles() {
        def usu = Persona.get(params.id)
        def perfilesUsu = Sesn.findAllByUsuario(usu)
        def pers = []
        perfilesUsu.each {
            if (it.estaActivo) {
                pers.add(it.perfil.id)
            }
        }

        def permisosUsu = PermisoUsuario.findAllByPersona(usu).permisoTramite.id
        return [usuario: usu, perfilesUsu: pers, permisosUsu: permisosUsu]
    }

    def guardarPerfiles_ajax () {
        println("params prfl " + params)

        def personaInstance = Persona.get(params.id)
        def perfilActual = Prfl.get(session.perfil.id)
        def sesionActual = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfilActual, personaInstance)
        def perfilesOld = Sesn.findAllByUsuarioAndFechaFinIsNull(personaInstance)

        if (params.perfiles) {

            def perfiles = params.perfiles.split("_")
            def perfilesSelected = []
            def perfilesInsertar = []

            perfiles.each { perfId ->
                def perf = Prfl.get(perfId.toLong())
                if (!perfilesOld.perfil.id.contains(perf.id)) {
                    perfilesInsertar += perf
                } else {
                    perfilesSelected += perf
                }
            }
            def commons = perfilesOld.perfil.intersect(perfilesSelected)
            def perfilesDelete = perfilesOld.perfil.plus(perfilesSelected)
            perfilesDelete.removeAll(commons)

            def errores = ''

            if(perfilesInsertar){
                perfilesInsertar.each { perfil ->
                    def sesion = new Sesn()
                    sesion.usuario = personaInstance
                    sesion.perfil = perfil
                    sesion.fechaInicio = new Date();
                    if (!sesion.save(flush: true)) {
                        errores += sesion.errors
                        println "error al guardar sesion: " + sesion.errors
                        render "no"
                    }
                }
            }

            def bandera = false

            if(errores == ''){
                if(perfilesDelete){
                    if(session.usuario.id == personaInstance.id){
                        if(perfilesDelete.contains(sesionActual.perfil)){
                            bandera = true
                        }else{
                            perfilesDelete.each { perfil ->
                                def perfilB = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfil, personaInstance)

                                if(perfilB){
                                    perfilB.fechaFin = new Date()

                                    if(!perfilB.save(flush: true)){
                                        errores += "Ha ocurrido un error al eliminar el perfil " + perfilB.errors
                                        println "error al eliminar perfil: " + perfilB.errors
                                    }
                                }
                            }
                        }
                    }else{
                        perfilesDelete.each { perfil ->
                            def perfilB = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfil, personaInstance)

                            if(perfilB){
                                perfilB.fechaFin = new Date()

                                if(!perfilB.save(flush: true)){
                                    errores += "Ha ocurrido un error al eliminar el perfil " + perfilB.errors
                                    println "error al eliminar perfil: " + perfilB.errors
                                }
                            }
                        }
                    }

                    if(bandera){
                        render "er_No puede borrar el perfil ${sesionActual}, está actualmente en uso"
                    }else{
                        if(errores != ''){
                            render "no"
                        }else{
                            render "ok"
                        }
                    }
                }else{
                    render "ok"
                }
            }else{
                render "no"
            }
        }else{
            def errores2 = ""

            if(session.usuario == personaInstance){
                render "er_No puede borrar el perfil ${sesionActual}, está actualmente en uso"
            }else{

                def perfilesBorrar = Sesn.findAllByUsuario(personaInstance)
                perfilesBorrar.each { perfil ->
                    def perfilB = Sesn.findByPerfilAndUsuarioAndFechaFinIsNull(perfil.perfil, personaInstance)

                    if(perfilB){
                        perfilB.fechaFin = new Date()

                        if(!perfilB.save(flush: true)){
                            errores2 += "Ha ocurrido un error al eliminar el perfil " + perfilB.errors
                            println "error al eliminar perfil: " + perfilB.errors
                        }
                    }
                }

                if(errores2 != ''){
                    render "no"
                }else{
                    render "ok"
                }

            }
        }
    }


}
