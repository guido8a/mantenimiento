<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Actividades</title>

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

%{--<div class="btn-toolbar toolbar" style="margin-bottom: 15px">--}%
    %{--<div class="btn-group">--}%
        %{--<a href="#" class="btn btn-info btnCrearActividad" ><i class="fa fa-file"></i>  Nueva actividad</a>--}%
    %{--</div>--}%
%{--</div>--}%

<div class="col-md-12" style="margin-bottom: 10px; margin-left: -20px">
    <div class="row-fluid">

        <div class="btn-group col-md-2" style="margin-top: 20px">
            <a href="#" class="btn btn-info btnCrearActividad"><i class="fa fa-file"></i>  Nueva actividad</a>
        </div>


        <div class="col-md-3">
            <label class="control-label text-info">Buscar por usuario</label>
            <span style="margin-left: 90px">
                <button class="btn btn-xs btn-info" id="btnBuscarUsuario" title="Buscar usuario"><i
                        class="fa fa-user xs"></i></button>
                <button class="btn btn-xs btn-warning" id="btnBuscarTodosUsuario"
                        title="Seleccionar todos los usuarios"><i class="fa fa-users"></i></button>
            </span>
            <g:hiddenField name="usuarioBusquedaId" value="${null}"/>
            <g:textField name="usuarioBusquedaName" id="usuarioBusquedaName" readonly="" value="${'Todos los usuarios'}"
                         class="form-control"/>
        </div>

        <div class="col-md-2">
            <label class="control-label text-info">Buscar por tipo</label>
            <g:select name="buscarPorTipo" class="buscarPorTipo col-md-12 form-control"
                      from="${bitacora.TipoMantenimiento.list().sort { it.descripcion }}" optionKey="id"
                      optionValue="descripcion" noSelection="[null: 'TODOS']"/>
        </div>

        <div class="col-md-2" style="margin-left: -20px">
            <label class="control-label text-info">Buscar por período</label>
            <g:select name="buscarPorPeriodo" class="buscarPorPeriodo form-control"
                      from="${bitacora.Periodo.list().sort { it.numero }}" optionKey="id"
                      optionValue="${{ it.fechads?.format("dd-MM-yy") + " - " + it.fechahs?.format("dd-MM-yy") }}"
                      noSelection="[null: 'TODOS']" style="width: 160px"/>
        </div>

        <div class="col-md-1" style="margin-left: -10px">
            <label class="control-label text-info">Buscar Por</label>
            <g:select name="buscarPor" class="buscarPor form-control" from="${[1: 'Descripción', 2: 'Clave']}"
                      optionKey="key" optionValue="value" style="width: 80px"/>
        </div>

        <div class="col-md-1">
            <label class="control-label text-info">Criterio</label>
            <g:textField name="buscarCriterio" id="criterioCriterio" class="form-control" style="width: 110px"/>
        </div>
        %{--</span>--}%
        <div class="col-md-1" style="margin-top: 25px; margin-left: 25px">
            <button class="btn btn-xs btn-info" id="btnBuscarActividad" title="Buscar actividad"><i
                    class="fa fa-search"></i></button>
            <button class="btn btn-xs btn-warning" id="btnLimpiarBusquedaActividad"><i class="fa fa-eraser"></i>
            </button>
        </div>
        %{--</div>--}%
        %{--</fieldset>--}%
    </div>
</div>

<div class="col-md-12" style="margin-top: 20px">
    <div class="col-md-8" id="divActividad">

    </div>

    <div class="col-md-4" id="divVerActividad">

    </div>
</div>

<script type="text/javascript">

    var mbu;

    $(".btnCrearActividad").click(function () {
        createEditActividad();
    });

    function createEditActividad(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'actividad', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Actividad",
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
                                return submitFormActividad();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormActividad() {
        var $form = $("#frmActividad");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'actividad', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarActividades();
                    } else {
                        log(parts[1],"error");
                        cargarActividades();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    $("#btnBuscarTodosUsuario").click(function () {
        $("#usuarioBusquedaId").val(null);
        $("#usuarioBusquedaName").val("Todos los usuarios")
    });

    $("#btnBuscarUsuario").click(function () {
        buscarUsuario();
    });

    function buscarUsuario(tipo){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'actividad', action: 'buscarUsuario_ajax')}",
            data    : {
                tipo: tipo
            },
            success : function (msg) {
                mbu = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    // class   : "modal-lg",
                    title   : "Buscar usuario",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }

    function cerrarBusquedaUsuario(){
        mbu.modal("hide");
    }

    $("#btnLimpiarBusquedaActividad").click(function () {
        $("#criterioCriterio").val("");
        $(".buscarPor").val(1);
        $(".buscarPorTipo").val('null');
        $(".buscarPorPeriodo").val('null');
        cargarActividades();
    });

    $("#btnBuscarActividad").click(function () {
        cargarActividades();
    });

    cargarActividades();

    function cargarActividades(){
        var d = cargarLoader("Cargando...");
        var usuario = $("#usuarioBusquedaId").val();
        var criterio = $("#criterioCriterio").val();
        var buscarPor = $("#buscarPor option:selected").val();
        var tipo = $("#buscarPorTipo option:selected").val();
        var periodo = $("#buscarPorPeriodo option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'actividad', action: 'tablaActividades_ajax')}',
            data:{
                usuario: usuario,
                criterio: criterio,
                buscarPor: buscarPor,
                periodo: periodo,
                tipo: tipo
            },
            success: function (msg){
                d.modal("hide");
                $("#divActividad").html(msg)
            }
        })
    }

    function deleteActividad(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar la actividad seleccionada? </br> Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller: 'actividad', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                if (msg === "ok") {
                                    log("Actividad borrada correctamente","success");
                                    cargarActividades();
                                } else {
                                    log("Error al borrar la actvidad","error");
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