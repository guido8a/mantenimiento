package bitacora

import javax.imageio.ImageIO

class EmpresaController {

    def list(){

    }

    def form_ajax(){
        def empresa
        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        return[empresa:empresa]
    }

    def tablaEmpresa_ajax() {
        def empresas = Empresa.list().sort{it.nombre}
        return[empresas: empresas]
    }

    def save_ajax(){

        def empresa

        if(params.fechaInicio){
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }

        if(params.fechaFin){
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }

        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        empresa.properties = params

        if(!empresa.save(flush:true)){
            println("error al guardar la empresa " + empresa.errors)
            render "no"
        }else{
            render "ok"
        }

    }

    def show_ajax(){
        def empresa
        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        return[empresa:empresa]
    }

    def borrar_ajax(){
        def empresa = Empresa.get(params.id)

        try{
            empresa.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar la empresa " + empresa.errors)
            render "no"
        }
    }

    def logo_ajax(){
        def empresa = Empresa.get(params.id)
        return [empresa: empresa]
    }

    def uploadFile() {
//        println "upload "+params

        def acceptedExt = ["jpg", "png", "jpeg"]

        def empresa = Empresa.get(params.empresa)
        def path = "/var/mantenimiento/empresa/emp_" + empresa.id + "/"
        new File(path).mkdirs()

        def f = request.getFile('file')  //archivo = name del input type file
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }
            if (acceptedExt.contains(ext.toLowerCase())) {
                fileName = fileName + "." + ext
                def pathFile = path + fileName
                def file = new File(pathFile)
                println "subiendo archivo: $fileName"

                f.transferTo(file)

                def old = empresa.logo
                if (old && old.trim() != "") {
                    def oldPath = "/var/mantenimiento/empresa/emp_" + empresa.id + "/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                empresa.logo = fileName
                empresa.save(flush: true)

            } else {
                render "no_Seleccione un archivo JPG, JPEG, PNG"
                return
            }
        } else {
            render "no_Seleccione un archivo JPG, JPEG, PNG"
            return
        }
        render "ok_Subido correctamente"
    }

    def deleteImagen_ajax() {
        def empresa = Empresa.get(params.id)
        def path = "/var/mantenimiento/empresa/emp_" + empresa.id + "/${empresa.logo}"

        try{
            empresa.logo = null
            empresa.save(flush: true)
            def file = new File(path).delete()
            render "ok"
        }catch(e){
            println("error al borrar la imagen " + e)
            render "no"
        }
    }

    def getImage() {
//        println "params get image $params"
        def empresa = Empresa.get(params.id)

        def nombreArchivo = empresa?.logo?.split("\\.")[0]
        def extensionArchivo = empresa?.logo?.split("\\.")[1]

        byte[] imageInBytes = im(nombreArchivo, extensionArchivo , empresa?.id)
        response.with{
            setHeader('Content-length', imageInBytes.length.toString())
            contentType = "image/${extensionArchivo}" // or the appropriate image content type
            outputStream << imageInBytes
            outputStream.flush()
        }
    }

    byte[] im(nombre,ext,empresa) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream()
        ImageIO.write(ImageIO.read(new File("/var/mantenimiento/empresa/emp_" + empresa + "/" + nombre + "." + ext)), ext.toString(), baos)
        baos.toByteArray()
    }

}
