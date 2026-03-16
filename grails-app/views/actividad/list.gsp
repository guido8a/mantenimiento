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

<div class="row">
    %{--<div class="col-md-12" >--}%
    %{--<div>--}%
        <div class="col-md-2" style="margin-top: 20px" >
            <a href="#" class="btn btn-info btnCrearActividad" style="width: 140px"><i class="fa fa-file"></i>  Nueva actividad</a>
        </div>

        <div class="col-md-2" style="margin-left: -20px">
            <label for="contratoBusqueda" class="col-md-2 control-label text-info">
                Contrato
            </label>
            %{--<g:select name="contratoBusqueda" from="${bitacora.Contrato.list()?.sort{it.numero}}" required="" --}%
            <g:select name="contratoBusqueda" from="${bitacora.Contrato.list([order: 'numero'])}" required=""
                      class="form-control" optionKey="id"  optionValue="numero"/>
        </div>
        <div class="col-md-2" style="margin-left: -20px; width: 120px">
            <label for="contratoBusqueda" class="col-md-2 control-label text-info">
                Período
            </label>
            <div id="divPeriodoBusqueda">

            </div>
        </div>


        <div class="col-md-2 text-info" style="margin-left: -0px">
            <label class="control-label text-info">Buscar por tipo</label>
            <g:select name="buscarPorTipo" class="buscarPorTipo col-md-12 form-control" style="color: #0A246A"
                      from="${bitacora.TipoMantenimiento.list().sort { it.descripcion }}" optionKey="id"
                      optionValue="descripcion" noSelection="[null: 'TODOS']"/>
        </div>
        <div class="col-md-2" style="margin-left: -10px">
            <label class="control-label text-info">Buscar Por Criterio</label>
            <g:select name="buscarPor" class="buscarPor form-control" from="${[1: 'Descripción', 2: 'Clave',
                                                                               3: 'Requerimiento', 4: 'Nombre de usuario',
                                                                               5: 'Apellido de usuario']}"
                      optionKey="key" optionValue="value" />
        </div>
        <div class="col-md-1" style="margin-left: -20px; width: 80px">
            <label class="control-label text-info">Criterio</label>
            <g:textField name="buscarCriterio" id="criterioCriterio" class="form-control" style="width: 90px"/>
        </div>
    <div style="margin-top: 22px; margin-left: 30px">
        <button class="btn btn-sm btn-info bact" id="btnBuscarActividad" title="Buscar actividades">
            <i class="fa fa-search"></i></button>
        <button class="btn btn-sm btn-warning" id="btnLimpiarBusquedaActividad"><i class="fa fa-eraser"></i></button>
    </div>
    %{--</div>--}%
</div>

<div class="row">
    <div class="col-md-12">
        %{--<div class="col-md-3">--}%
            %{--<label class="control-label text-info">Buscar por usuario</label>--}%
            %{--<g:hiddenField name="usuarioBusquedaId" value="${null}"/>--}%
            %{--<g:textField name="usuarioBusquedaName" id="usuarioBusquedaName" readonly="" value="${'Todos los usuarios'}" class="form-control"/>--}%
        %{--</div>--}%

        %{--<div class="col-md-2" style="margin-top: 20px; width: 110px">--}%
            %{--<button class="btn btn-sm btn-info" id="btnBuscarUsuario" title="Buscar usuario"><i--}%
                    %{--class="fa fa-user"></i></button>--}%
            %{--<button class="btn btn-sm btn-warning" id="btnBuscarTodosUsuario"--}%
                    %{--title="Seleccionar todos los usuarios"><i class="fa fa-users"></i></button>--}%
        %{--</div>--}%

    </div>


    <div class="col-md-12" style="margin-top: 20px">
        <div class="col-md-8" id="divActividad">

        </div>

        <div class="col-md-4" id="divVerActividad">

        </div>
    </div>
</div>
<script type="text/javascript">

    var mbu, mbc;

    cargarPeriodosBusqueda();

    $("#contratoBusqueda").change(function () {
        cargarPeriodosBusqueda()
    });

    function cargarPeriodosBusqueda(){
        $.ajax({
            type: 'POST',
            url :'${createLink(controller: 'actividad', action: 'periodo_ajax')}',
            data: {
                contrato: $("#contratoBusqueda option:selected").val()
            },
            success: function (msg) {
                $("#divPeriodoBusqueda").html(msg);
                cargarActividades();
            }
        });
    }

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
        var periodo = $("#periodo option:selected").val();

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

    $("#criterioCriterio").keydown(function (ev) {
        if (ev.keyCode === 13) {
            cargarActividades();
            return false;
        }
        return true;
    });

</script>
</body>
</html>