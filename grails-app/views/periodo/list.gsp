<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Períodos</title>
</head>

<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnCrearPeriodo">
            <i class="fa fa-file"></i> Nuevo período
        </a>
    </div>
</div>

<div style="margin-top: 30px; min-height: 400px">
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr style="width: 100%">
            <th class="alinear" style="width: 15%">Número</th>
            <th class="alinear"  style="width: 35%">Fecha Inicio</th>
            <th class="alinear"  style="width: 35%">Fecha Fin</th>
            <th class="alinear" style="width: 15%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="divPeriodos">
    </div>
</div>

<script type="text/javascript">

    cargarTablaPeriodos();

    $("#btnCrearPeriodo").click(function () {
        createEditPeriodo();
    });

    function createEditPeriodo(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'periodo', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " período",
                    class : "modal-sm",
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
        var $form = $("#frmPeriodo");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'periodo', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    if (msg==="ok") {
                        log("Período guardado correctamente","success");
                        setTimeout(function () {
                            cargarTablaPeriodos();
                        }, 500);
                    } else {
                        log("Error al guardar el período","error");
                        cargarBandeja();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function cargarTablaPeriodos(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'periodo', action: 'tablaPeriodos_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#divPeriodos").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divPeriodos").html("Ha ocurrido un error");
            }
        });
    }

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el período seleccionado? </br> Esta acción no se puede deshacer.</p>",
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
                       var a=  cargarLoader("Borrando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'periodo', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                if (msg === "ok") {
                                    log("Período borrado correctamente","success");
                                    cargarTablaPeriodos();
                                } else {
                                    log("Error al borrar el período","error");
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