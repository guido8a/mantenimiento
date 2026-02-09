<%@ page import="bitacora.Periodo" %>
<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}

th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
</style>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla" style="width: 100%; background-color: #a39e9e">
    <thead>
    <tr style="text-align: center">
        <th style="width: 15%">Usuario</th>
        <th style="width: 17%">Tipo</th>
        <th style="width: 28%">Período</th>
        <th style="width: 30%">Requerimiento</th>
        <th style="width: 9%"></th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%; height: 350px; overflow-y: auto;float: right;">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
        <g:if test="${data.size() > 0}">
            <g:each in="${data}" var="actividad">
                <g:set var="actividadId" value="${actividad?.actv__id}"/>
                <tr data-id="${actividad.actv__id}" style="width: 100%">
                    <td style="width: 15%">${bitacora.Usuario.get(actividad.pcnt__id)?.apellido + "  " + bitacora.Usuario.get(actividad.pcnt__id)?.nombre}</td>
                    <td style="width: 17%">${bitacora.TipoMantenimiento.get(actividad.tpmt__id)?.descripcion}</td>
                    <td style="width: 28%">${bitacora.Periodo.get(actividad.prdo__id)?.fechads + " - " + bitacora.Periodo.get(actividad.prdo__id)?.fechahs}</td>
                    <td style="width: 30%">${actividad.actvreqm}</td>
                    <td style="width: 9%; text-align: center">
                        <a class="btn btn-xs btn-success" href="#"  title="Seleccionar usuario" data-id="${actividad.actv__id}">
                            <i class="fa fa-check"></i>
                        </a>
                    </td>
                    <td style="width: 1%"></td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No se encontraron registros</div>
        </g:else>
    </table>
</div>


<script type="text/javascript">

    cargarVerActividades();

    function cargarVerActividades(){
        var d = cargarLoader("Cargando...");
        var id = '${actividadId}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'actividad', action: 'verActividad')}',
            data:{
                id: id
            },
            success: function (msg){
                d.modal("hide");
                $("#divVerActividad").html(msg)
            }
        })
    }

    function cargarTablaUsuarios(){
        var d = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPor option:selected").val();
        var criterio = $("#criterioCriterio").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'persona', action: 'tablaPersonas_ajax')}',
            data:{
                buscarPor: buscarPor,
                criterio: criterio
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaPersonas").html(msg)
            }
        })
    }

    function deletePersona(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Eliminar usuario del sistema",
            message : "<p style='font-size: 14px'> ¿Está seguro que desea eliminar al usuario seleccionado? </br> Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar Usuario",
                    className : "btn-danger",
                    callback  : function () {
                        var a = cargarLoader("Borrando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'persona', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal('hide');
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1], "success");
                                    cargarTablaUsuarios();
                                }else{
                                    log(parts[1], "error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function createEditRow(id) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'persona', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    class   : "modal-lg",
                    title   : title + " Persona",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitForm() {
        var $form = $("#frmPersona");
        if ($form.valid()) {
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'persona', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log(parts[1], "success");
                        cargarTablaUsuarios();
                    }else{
                        log(parts[1], "error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function verPersona(id){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'persona', action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Ver Persona",
                    message : msg,
                    buttons : {
                        ok : {
                            label     : "Aceptar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        });
    }

    function restablecerContrasena(id){
        bootbox.dialog({
            title   : "<i class='fa fa-exclamation-triangle fa-2x pull-left text-info text-shadow'></i> Restablecer contraseña",
            message : "<p style='font-size: 14px'> ¿Está seguro que desea restablecer la contraseña y la autorización del usuario seleccionado?</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-check-circle'></i> Restableceer",
                    className : "btn-success",
                    callback  : function () {
                        var a = cargarLoader("Guardando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'persona', action:'restablecer_ajax')}',
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                a.modal('hide');
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1], "success");
                                    cargarTablaUsuarios();
                                }else{
                                    log(parts[1], "error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    $("#criterioCriterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaUsuarios();
            return false;
        }
        return true;
    });

</script>
