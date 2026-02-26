
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de oficios</title>
</head>

<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnCrearOficio">
            <i class="fa fa-file"></i> Nuevo oficio
        </a>
    </div>
</div>

<div style="margin-top: 30px; min-height: 400px">
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr style="width: 100%">
            <th style="width: 15%">Contrato</th>
            <th style="width: 15%">Período</th>
            <th style="width: 20%">Número</th>
            <th style="width: 10%">Fecha</th>
            <th style="width: 10%">Acciones</th>
            <th style="width: 10%">Documentos</th>
        </tr>
        </thead>
    </table>

    <div id="divOficios">
    </div>
</div>

<script type="text/javascript">

    cargarTablaOficios();

    $("#btnCrearOficio").click(function () {
        createEditOficio();
    });

    function cargarTablaOficios(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'oficio', action: 'tablaOficios_ajax')}",
            data    : {
            },
            success : function (msg) {
                c.modal("hide");
                $("#divOficios").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divOficios").html("Ha ocurrido un error");
            }
        });
    }

    function createEditOficio(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'oficio', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Oficio",
                    class   : "modal-lg",
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
                                return submitFormOficio();
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

    function submitFormOficio() {
        var $form = $("#frmOficio");
        if ($form.valid()) {
           var texto = CKEDITOR.instances.texto.getData();
            var lineBreaksCount = (texto.match(/<br[^>]*>/g) || []).length + (texto.split('\n').length + 1);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'oficio', action:'save_ajax')}',
                // data    : $form.serialize(),
                data    : {
                    id: $("#id").val(),
                    contrato: $("#contrato").val(),
                    periodo: $("#periodo").val(),
                    numero: $("#numero").val(),
                    fecha: $("#datetimepicker1").val(),
                    texto: texto,
                    lineas: lineBreaksCount
                },
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarTablaOficios();
                    } else {
                        log(parts[1],"error");
                        cargarTablaOficios();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function deleteOficio(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el oficio seleccionado? </br> Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'oficio', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                if (msg === "ok") {
                                    log("Oficio borrado correctamente","success");
                                    cargarTablaOficios();
                                } else {
                                    log("Error al borrar el oficio","error");
                                    return false;
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function verOficio(id){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'oficio', action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Ver Oficio",
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

</script>
</body>
</html>