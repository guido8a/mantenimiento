<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de tipos de mantenimiento</title>
</head>
<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnCrearTipo">
            <i class="fa fa-file"></i> Nuevo tipo
        </a>
    </div>
</div>

<div style="margin-top: 30px; min-height: 400px">
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr style="width: 100%">
            <th style="width: 40%">Código</th>
            <th style="width: 40%">Descripción</th>
            <th style="width: 20%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="divTipo">
    </div>
</div>

<script type="text/javascript">

    cargarTablaTipo();

    $("#btnCrearTipo").click(function () {
        createEditTipo();
    });

    function cargarTablaTipo(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'tipoMantenimiento', action: 'tablaTipo_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#divTipo").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divTipo").html("Ha ocurrido un error");
            }
        });
    }

    function createEditTipo(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'tipoMantenimiento', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Tipo de mantenimiento",
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
                                return submitFormTipo();
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

    function submitFormTipo() {
        var $form = $("#frmTipo");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'tipoMantenimiento', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarTablaTipo();
                    } else {
                        log(parts[1],"error");
                        cargarTablaTipo();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function deleteTipo(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el tipo seleccionado? </br> Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'tipoMantenimiento', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                if (msg === "ok") {
                                    log("Tipo borrado correctamente","success");
                                    cargarTablaTipo();
                                } else {
                                    log("Error al borrar el tipo","error");
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