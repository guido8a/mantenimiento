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
</div>

<div style="margin-top: 30px; min-height: 400px">
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr style="width: 100%">
            <th class="alinear" style="width: 15%">RUC</th>
            <th class="alinear"  style="width: 30%">Nombre</th>
            <th class="alinear"  style="width: 25%">Dirección</th>
            <th class="alinear"  style="width: 15%">Teléfono</th>
            <th class="alinear" style="width: 10%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="divContrato">
    </div>
</div>

<script type="text/javascript">

    cargarTablaEmpresas();

    $("#btnCrearEmpresa").click(function () {
        createEditRow();
    });

    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empresa', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Empresa",
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
                                return submitForm();
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


    function submitForm() {
        var $form = $("#frmEmpresa");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'empresa', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    if (msg==="ok") {
                        log("Empresa guardada correctamente","success");
                        setTimeout(function () {
                            cargarTablaEmpresas();
                        }, 500);
                    } else {
                        log("Error al guardar la empresa","error");
                        cargarTablaEmpresas();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function cargarTablaEmpresas(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'empresa', action: 'tablaEmpresa_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#bandeja").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#bandeja").html("Ha ocurrido un error");
            }
        });
    }

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar la empresa seleccionada? </br> Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'empresa', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                if (msg === "ok") {
                                    log("Bodega borrado correctamente","success");
                                    cargarTablaEmpresas();
                                } else {
                                    log("Error al borrar la bodega","error");
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function verEmpresa(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empresa', action:'show_ajax')}",
            data    : {
                id:id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgVer",
                    title   : "Datos de la Empresa",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }

</script>

</body>
</html>