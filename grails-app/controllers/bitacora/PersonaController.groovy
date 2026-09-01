package bitacora

import seguridad.Persona

class PersonaController {

    def personal() {
        def usuario = Persona.get(session.usuario?.id)
        return [usuario: usuario]
    }

    def savePass_ajax() {
        def persona = Persona.get(params.id)

        if(params.nuevoPass.trim() == params.passConfirm.trim()){

            persona.password = params.nuevoPass.encodeAsMD5()
            if(!persona.save(flush: true)){
                println("error al guardar el nuevo password " + persona.errors)
                render "no_Error al guardar el password"
            }else{
                render "ok_La contraseña ha sido modificada exitosamente"
            }
        }else{
            render "no_El password ingresado y su confirmación no coinciden"
        }
    }
}
