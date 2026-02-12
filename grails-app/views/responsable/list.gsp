<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de responsables</title>
</head>

<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnCrearResponsable">
            <i class="fa fa-file"></i> Nuevo responsable
        </a>
    </div>
</div>

<div style="margin-top: 30px; min-height: 400px">
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr style="width: 100%">
            <th style="width: 15%">Contrato</th>
            <th style="width: 20%">Apellido</th>
            <th style="width: 20%">Nombre</th>
            <th style="width: 15%">Fecha Inicio</th>
            <th style="width: 15%">Fecha Fin</th>
            <th style="width: 10%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="divResposanble">
    </div>
</div>

<script type="text/javascript">

    cargarTablaReponsables();

    $("#btnCrearResponsable").click(function () {
        createEditResponsable();
    });

    function createEditResponsable(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'responsable', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Contrato",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormResponsable();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function submitFormResponsable() {
        var $form = $("#frmResponsable");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'responsable', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarTablaReponsables();
                    } else {
                        log(parts[1],"error");
                        cargarTablaReponsables();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function cargarTablaReponsables(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'responsable', action: 'tablaResponsables_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#divResposanble").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divResposanble").html("Ha ocurrido un error");
            }
        });
    }

    function deleteResponsable(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el responsable seleccionado? </br> Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "<i class='fa fa-times'></i> Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        var a = cargarLoader("Borrando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'responsable', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                if (msg === "ok") {
                                    log("Responsable borrado correctamente","success");
                                    cargarTablaReponsables();
                                } else {
                                    log("Error al borrar el responsable","error");
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        });
    }

</script>
</body>
</html>