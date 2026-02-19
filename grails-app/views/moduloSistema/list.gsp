<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de módulos</title>
</head>
<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnCrearModulo">
            <i class="fa fa-file"></i> Nuevo módulo
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

    <div id="divModulo">
    </div>
</div>

<script type="text/javascript">

    cargarTablaModulos();

    $("#btnCrearModulo").click(function () {
        createEditModulo();
    });

    function cargarTablaModulos(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'moduloSistema', action: 'tablaSistemas_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#divModulo").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divModulo").html("Ha ocurrido un error");
            }
        });
    }

    function createEditModulo(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'moduloSistema', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Módulo",
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
                                return submitFormModulo();
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

    function submitFormModulo() {
        var $form = $("#frmModulo");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'moduloSistema', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarTablaModulos();
                    } else {
                        log(parts[1],"error");
                        cargarTablaModulos();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function deleteModulo(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el módulo seleccionado? </br> Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'moduloSistema', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                if (msg === "ok") {
                                    log("Módulo borrado correctamente","success");
                                    cargarTablaModulos();
                                } else {
                                    log("Error al borrar el módulo","error");
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