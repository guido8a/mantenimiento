package bitacora

class TipoMantenimientoController {

    def list() {

    }

    def tablaTipo_ajax() {
        def tipos = TipoMantenimiento.list().sort { it.codigo }
        return [tipos: tipos]
    }

    def form_ajax() {
        def tipo

        if (params.id) {
            tipo = TipoMantenimiento.get(params.id)
        } else {
            tipo = new TipoMantenimiento()
        }

        return [tipo: tipo]
    }

    def save_ajax() {

        def tipo

        if (params.id) {
            tipo = TipoMantenimiento.get(params.id)
        } else {
            tipo = new TipoMantenimiento()
        }

        params.codigo = params.codigo.toUpperCase();

        tipo.properties = params

        if (!tipo.save(flush: true)) {
            println("Error al guardar el módulo " + tipo.errors)
            render "no_Error al guardar el tipo"
        } else {
            render "ok_Tipo guardado correctamente"
        }
    }

    def borrar_ajax() {
        def tipo = TipoMantenimiento.get(params.id)

        try {
            tipo.delete(flush: true)
            render "ok"
        } catch (e) {
            println("error al borrar el tipo " + tipo.errors)
            render "no"
        }
    }


}