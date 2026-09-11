package seguridad

import seguridad.ShieldController

class WardInterceptor {

    WardInterceptor () {
//        matchAll().excludes(controller: 'login')
        matchAll().excludes(controller:'login')
                .excludes(controller:'shield')
                .excludes(controller:'prfl')  /** todo: poner acciones base para incluir prfl **/
    }

    boolean before() {
        println "us: " + session?.usuario?.login + " - ac: " + actionName + " ct: " + controllerName + " p: " + params + " " + new Date()
//        println "shield sesión: " + session
//        println "usuario: " + session.usuario
        session.an = actionName
        session.cn = controllerName
        session.pr = params
        def usro
        if(session) {
            usro = session.usuario
        }

        if( actionName.toString().toLowerCase().contains('save') ){
            if(!session){
                println("graba sin sesión")
            } else {
                println "session: ${session.usuario}"
            }
            flash.clase = "alert-success"
            flash.message = "Se han guardado los datos y terminado la sesión por inactividad en el sistema"

            return true
        }

        if(session) {
            usro = session.usuario
        }


        def app = ""

        if (grails.util.Environment.getCurrent().name == 'development') {
            app = '/'
        } else {
            app = '/mntn/'
        }


        if(session.an == 'saveTramite' && session.cn == 'tramite'){
            return true
        } else {
            if (!session?.usuario || !session?.perfil) {
                println "...sin sesión"
                if(controllerName != "inicio" && actionName != "index") {
                }
//                render "<script type='text/javascript'> window.location.href = '/' </script>"
                render "<script type='text/javascript'> window.location.href = '${app}' </script>"
                session.finalize()
                return false
            }

            if (isAllowed()) {
                return true
            } else {
                println "******Dar permisos a prfl: ${session?.perfil?.codigo} en acción: $actionName controlador: $controllerName"
                return true   /** quitar para manejar permisos **/
            }
        }

        //true
    }

    boolean after() {
//        println "+++++después"
        true
    }

    void afterView() {
//        println "+++++afterview"
        // no-op
    }


    boolean isAllowed() {
//        println "--> ${session.permisos[controllerName.toLowerCase()]} --> ${actionName}"
//
//        try {
//            if((request.method == "POST") || (actionName.toLowerCase() =~ 'ajax')) {
//                println "es post no audit"
//                return true
//            }
////            println "is allowed Accion: ${actionName.toLowerCase()} ---  Controlador: ${controllerName.toLowerCase()} --- Permisos de ese controlador: "+session.permisos[controllerName.toLowerCase()]
//            if (!session.permisos[controllerName.toLowerCase()]) {
//                return false
//            } else {
//                if (session.permisos[controllerName.toLowerCase()].contains(actionName.toLowerCase())) {
//                    return true
//                } else {
//                    return false
//                }
//            }
//
//        } catch (e) {
//            println "Shield execption e: " + e
//            return false
//        }

        return true

    }

}
