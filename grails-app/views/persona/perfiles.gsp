<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Perfiles de Usuario</title>
</head>

<body>

<div class="btn-group" style="margin-bottom: 15px">
    <g:link class="btn btn-primary" controller="persona" action="list"><i class="fa fa-arrow-left"></i> Regresar</g:link>
</div>

<div class="panel-group" id="accordion">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                Configuración de perfiles del usuario: <strong>${usuario.nombre} ${usuario.apellido}</strong>
            </h4>
        </div>

        <div id="collapsePerfiles" class="panel-collapse collapse in">
            <div class="panel-body">
                <p>
                    <a href="#" class="btn btn-warning " id="nonePerf"><i class="fa fa-exclamation-triangle"></i> Quitar todos los perfiles</a>
                    <a href="#" class="btn btn-success glow-on-hover" id="btnPerfiles">
                        <i class="fa fa-save"></i> Guardar
                    </a>
                </p>
                <g:form name="frmPerfiles" action="savePerfiles_ajax">
                    <ul class="fa-ul">
                        <g:each in="${seguridad.Prfl.list([sort: 'nombre'])}" var="perfil">
                            <li class="perfil" style="font-size: 16px">
                                <g:checkBox class="c2" name="c1" data-id="${perfil?.id}" value="${perfilesUsu.contains(perfil.id)}" checked="${perfilesUsu.contains(perfil.id) ? 'true' : 'false'}"/>
                                <span>${perfil.nombre} ${perfil.observaciones ? '(' + perfil.observaciones + ')' : ''}</span>
                            </li>
                        </g:each>
                    </ul>
                </g:form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $("#btnPerfiles").click(function () {
        verificarPerfiles();
    });

    function verificarPerfiles () {
        var usuario = '${usuario?.id}';
        var perfiles = [];

        $(".c2").each(function () {
            var id = $(this).data("id");

            if($(this).is(':checked')){
                perfiles += parseInt(id) + "_"
            }
        });

        if(perfiles.length > 0){
            guardarPerfiles(usuario, perfiles)
        }else{
            bootbox.dialog({
                title   : "<i class='fa fa-exclamation-triangle fa-2x pull-left text-info text-shadow'></i> Sin Perfiles seleccionados",
                message : "<p style='font-size: 14px'> No ha seleccionado ningún perfil. El usuario no podrá ingresar al sistema. ¿Desea continuar?</p>",
                buttons : {
                    cancelar : {
                        label     : "Cancelar",
                        className : "btn-primary",
                        callback  : function () {
                            location.href="${createLink(controller: 'persona', action: 'perfiles')}?id=" + '${usuario?.id}'
                        }
                    },
                    eliminar : {
                        label     : "<i class='fa fa-check-circle'></i> Aceptar",
                        className : "btn-success",
                        callback  : function () {
                            guardarPerfiles(usuario, perfiles)
                        }
                    }
                }
            });
        }
    }

    function guardarPerfiles (id, perfiles) {
        var dialog = cargarLoader("Guardando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'persona', action: 'guardarPerfiles_ajax')}',
            data:{
                perfiles: perfiles,
                id: id
            },
            success:function (msg) {
                dialog.modal('hide');
                var parts = msg.split("_");
                if(parts[0] === 'ok'){
                    log("Perfiles guardados correctamente","success");
                    setTimeout(function () {
                        location.href="${createLink(controller: 'persona', action: 'perfiles')}?id=" + '${usuario?.id}'
                    }, 1000);
                }else{
                    if(parts[0] === 'er'){
                        bootbox.alert({
                            message: '<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 12px">' + parts[1] + '</strong>',
                            callback: function () {
                                location.href="${createLink(controller: 'persona', action: 'perfiles')}?id=" + '${usuario?.id}'
                            }
                        });
                        return false;
                    }else{
                        log("Error al guardar los perfiles","error")
                    }
                }
            }
        });
    }

    $("#nonePerf").click(function () {
        $(".c2").attr('checked', false);
        $("#btnPerfiles").addClass("button-glow");
        return false;
    });

</script>

</body>
</html>