<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Sistemas</title>
</head>
<body>

<div style="overflow: hidden">
    <div class="row-fluid">
        <div class="btn-group col-md-2">
            <a href="#" class="btn btn-success" id="btnCrearSistema">
                <i class="fa fa-file"></i> Nuevo sistema
            </a>
        </div>
    </div>
</div>

<div id="divTablaSistemas" style="margin-top: 20px">
</div>

<script type="text/javascript">

    cargarTablaSistemas();

    $("#btnCrearSistema").click(function () {
        createEditSistema();
    });

    function cargarTablaSistemas(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'sistema', action: 'tablaSistemas_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#divTablaSistemas").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divTablaSistemas").html("Ha ocurrido un error");
            }
        });
    }

    function createEditSistema(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'sistema', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Sistema",
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
                                return submitFormSistema();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormSistema() {
        var $form = $("#frmSistema");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'sistema', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarTablaSistemas();
                    } else {
                        log(parts[1],"error");
                        cargarTablaSistemas();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function deleteSistema(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el sistema seleccionado? </br> Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'sistema', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                var parts = msg.split("_");
                                if (parts[0] === "ok") {
                                    log(parts[1],"success");
                                    cargarTablaSistemas();
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