<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Personal</title>

    <style type="text/css">
    .table {
        font-size     : 12px;
        margin-bottom : 0 !important;
    }

    .perfiles option:first-child {
        font-weight : normal !important;
    }
    </style>
</head>

<body>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-info btnCrear" >  <i class="fa fa-user"></i>  Nuevo Usuario</a>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-success btnReporte" >  <i class="fa fa-print"></i>  Reporte de usuarios</a>
    </div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-2">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPor" class="buscarPor col-md-12 form-control" from="${[1: 'Usuario', 2: 'Nombre', 3 : 'Apellido']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-4">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="buscarCriterio" id="criterioCriterio" class="form-control"/>
                </span>
            </span>
            <div class="col-md-2" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarUsuarios"><i class="fa fa-search"></i></button>
                <button class="btn btn-warning" id="btnLimpiarBusqueda"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>

    <div id="divTablaUsuarios" style="margin-top: 20px">
    </div>
</div>

<script type="text/javascript">

    $("#btnLimpiarBusqueda").click(function () {
        $("#criterioCriterio").val("");
        $(".buscarPor").val(1);
        cargarTablaUsuarios();
    });

    $(".btnReporte").click(function () {
        location.href = "${g.createLink(controller: 'reportes6',action: 'imprimirUsuariosExcel')}"
    });

    $(".btnCrear").click(function () {
        createEditRow(null, "persona");
        return false;
    });

    cargarTablaUsuarios();

    $("#btnBuscarUsuarios").click(function () {
        cargarTablaUsuarios();
    });

    function cargarTablaUsuarios(){
        var d = cargarLoader("Cargando...");
        var buscarPor = $("#buscarPor option:selected").val();
        var criterio = $("#criterioCriterio").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'persona', action: 'tablaPersonas_ajax')}',
            data:{
                buscarPor: buscarPor,
                criterio: criterio
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaUsuarios").html(msg)
            }
        })
    }

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "<strong>Eliminar</strong> usuario del sistema",
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i>" +
                "<p> ¿Está seguro que desea eliminar al usuario seleccionado? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar Usuario",
                    className : "btn-danger",
                    callback  : function () {
                        var a = cargarLoader("Eliminando");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'persona', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal('hide');
                                var parts = msg.split("_");
                                log(parts[1], parts[0] === "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] === "OK") {
                                    location.reload();
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function createEditRow(id) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'persona', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    class   : "modal-lg",
                    title   : title + " Persona",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
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
                    b.find(".form-control").not(".datepicker").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function submitForm() {
        var $form = $("#frmPersona");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        var idPersona = $("#trPersona").data("id");
        if ($form.valid()) {
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'persona', action:'savePersona_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] !== "INFO") {
                        if(parts[0] === 'ok'){
                            dialog.modal('hide');
                            log(parts[1], "success");
                            setTimeout(function () {
                                location.reload();
                            }, 1000);
                        }else{
                            dialog.modal('hide');
                            log(parts[1], "error")
                        }
                    } else {
                        bootbox.dialog({
                            title   : "Alerta",
                            message : "<i class='fa fa-warning fa-3x pull-left text-warning text-shadow'></i>" + parts[1],
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                },
                                aceptar  : {
                                    label     : "<i class='fa fa-thumbs-o-up '></i> Continuar",
                                    className : "btn-success",
                                    callback  : function () {
                                        var $sel = $("#selWarning");
                                        var resp = $sel.val();
                                        var dpto = $sel.data("dpto");
                                        if (resp === 1 || resp === "1") {
                                            openLoader("Cambiando");
                                            $.ajax({
                                                type    : "POST",
                                                url     : '${createLink(controller: 'persona', action:'cambioDpto_ajax')}',
                                                data    : {
                                                    id   : idPersona,
                                                    dpto : dpto
                                                },
                                                success : function (msg) {
                                                    var parts = msg.split("_");
                                                    log(parts[1], parts[0] === "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                                    if (parts[0] === "OK") {
                                                        location.reload();
                                                    }
                                                }
                                            });
                                        }
                                    }
                                }
                            }
                        });
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function verPersona(){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'persona', action:'show_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Ver Persona",
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

    $("#criterioCriterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarTablaUsuarios();
            return false;
        }
        return true;
    });

</script>
</body>
</html>