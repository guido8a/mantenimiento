<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Cambios</title>
</head>
<body>

<div style="overflow: hidden">
    <div class="row-fluid">
        <div class="btn-group col-md-2">
            <a href="#" class="btn btn-success" id="btnCrearCambio">
                <i class="fa fa-file"></i> Nuevo cambio
            </a>
        </div>
    </div>
</div>

<div id="divTablaCambios" style="margin-top: 20px">
</div>

<script type="text/javascript">

    cargarTablaCambios();

    $("#btnCrearCambio").click(function () {
        createEditCambio();
    });

    function cargarTablaCambios(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'cambio', action: 'tablaCambios_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#divTablaCambios").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divTablaCambios").html("Ha ocurrido un error");
            }
        });
    }

    function createEditCambio(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'cambio', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Cambio",
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
                                return submitFormCambio();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormCambio() {
        var $form = $("#frmCambio");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'cambio', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarTablaCambios();
                    } else {
                        log(parts[1],"error");
                        cargarTablaCambios();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function deleteCambio(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el cambio seleccionado? </br> Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'cambio', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                var parts = msg.split("_");
                                if (parts[0] === "ok") {
                                    log(parts[1],"success");
                                    cargarTablaCambios();
                                } else {
                                    log(parts[1],"error");
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