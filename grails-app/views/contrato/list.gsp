<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de contratos</title>
</head>

<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnCrearContrato">
            <i class="fa fa-file"></i> Nuevo contrato
        </a>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-info" id="btnImprimirBusqueda">
            <i class="fa fa-print"></i> Imprimir
        </a>
    </div>
</div>

<div style="margin-top: 30px; min-height: 400px">
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr style="width: 100%">
            <th style="width: 5%">Empresa</th>
            <th style="width: 10%">Número</th>
            <th style="width: 64%">Objeto</th>
            <th style="width: 7%">Fecha Sub.</th>
            <th style="width: 7%">Fecha Inicio</th>
            <th style="width: 7%">Fecha Fin</th>
            <th style="width: 10%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="divContrato">
    </div>
</div>

<script type="text/javascript">

    $("#btnImprimirBusqueda").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'reportes', action:'buscarActividades_ajax')}",
            data    : {
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : "Reporte actividades",
                    class   : "modal-sm",
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
                            label     : "<i class='fa fa-print'></i> Imprimir",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reporteActividades')}";
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

    cargarTablaContratos();

    $("#btnCrearContrato").click(function () {
        createEditContrato();
    });

    function createEditContrato(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'contrato', action:'form_ajax')}",
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
                                return submitFormContrato();
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

    function submitFormContrato() {
        var $form = $("#frmContrato");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'contrato', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarTablaContratos();
                    } else {
                        log(parts[1],"error");
                        cargarTablaContratos();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function cargarTablaContratos(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'contrato', action: 'tablaContratos_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#divContrato").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divContrato").html("Ha ocurrido un error");
            }
        });
    }

    function deleteContrato(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el contrato seleccionado? </br> Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'contrato', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                if (msg === "ok") {
                                    log("Contrato borrado correctamente","success");
                                    cargarTablaContratos();
                                } else {
                                    log("Error al borrar el contrato","error");
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