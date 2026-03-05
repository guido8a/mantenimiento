<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Áreas</title>
</head>
<body>

<div style="overflow: hidden">
    <div class="row-fluid">
        <div class="btn-group col-md-2">
            <a href="#" class="btn btn-success" id="btnCrearArea">
                <i class="fa fa-file"></i> Nueva área
            </a>
        </div>
    </div>
</div>

<div id="divTablaAreas" style="margin-top: 20px">
</div>

<script type="text/javascript">

    cargarTablaAreas();

    $("#btnCrearArea").click(function () {
        createEditArea();
    });

    function cargarTablaAreas(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'area', action: 'tablaAreas_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#divTablaAreas").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divTablaAreas").html("Ha ocurrido un error");
            }
        });
    }

    function createEditArea(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'area', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Area",
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
                                return submitFormArea();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormArea() {
        var $form = $("#frmArea");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'area', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarTablaAreas();
                    } else {
                        log(parts[1],"error");
                        cargarTablaAreas();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function deleteArea(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el area seleccionada? </br> Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'area', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                var parts = msg.split("_");
                                if (parts[0] === "ok") {
                                    log(parts[1],"success");
                                    cargarTablaAreas();
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