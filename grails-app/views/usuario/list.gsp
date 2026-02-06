<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Usuarios</title>

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
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-2">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPor" class="buscarPor col-md-12 form-control" from="${[1: 'Cédula', 2: 'Nombre', 3 : 'Apellido']}" optionKey="key"
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

    $(".btnCrear").click(function () {
        createEditUsuario(null);
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
            url: '${createLink(controller: 'usuario', action: 'tablaUsuarios_ajax')}',
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

    function deleteUsuario(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Eliminar usuario del sistema",
            message : "<p style='font-size: 14px'> ¿Está seguro que desea eliminar al usuario seleccionado? </br> Esta acción no se puede deshacer.</p>",
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
                        var a = cargarLoader("Borrando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller: 'usuario', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal('hide');
                                var parts = msg.split("_");
                                if(parts[0] === 'ok'){
                                    log(parts[1], "success");
                                    cargarTablaUsuarios();
                                }else{
                                    log(parts[1], "error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function createEditUsuario(id) {
        var title = id ? "Editar " : "Crear ";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'usuario', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    class   : "modal-lg",
                    title   : title + " Usuario",
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
                                return submitFormUsuario();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormUsuario() {
        var $form = $("#frmUsuario");
        if ($form.valid()) {
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'usuario', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if(parts[0] === 'ok'){
                        log(parts[1], "success");
                        cargarTablaUsuarios();
                    }else{
                        log(parts[1], "error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function verUsuario(id){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'usuario', action:'show_ajax')}",
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