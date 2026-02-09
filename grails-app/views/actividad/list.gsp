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

<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-info btnCrearActividad" ><i class="fa fa-user"></i>  Nueva actividad</a>
    </div>
</div>

<div class="col-md-12" style="margin-bottom: 10px">
    <div class="row-fluid">
        <div class="col-md-1" style="font-size: 12px">
            <label class="control-label text-info">Usuario</label>
        </div>
        <div class="col-md-7">
            <g:hiddenField name="usuarioBusquedaId" value="${null}"/>
            <g:textField name="usuarioBusquedaName" id="usuarioBusquedaName" readonly="" value="${'Todos los usuarios'}" class="form-control" />
        </div>
        <div class="col-md-3">
            <button class="btn btn-info" id="btnBuscarUsuario" title="Buscar usuario"><i class="fa fa-user"></i> Buscar  </button>
            <button class="btn btn-warning" id="btnBuscarTodosUsuario" title="Seleccionar todos los usuarios"><i class="fa fa-users"></i> Todos  </button>
        </div>
    </div>
</div>

<div class="col-md-12" style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-2">
                    <label class="control-label text-info">Tipo de mantenimiento</label>
                    <g:select name="buscarPorTipo" class="buscarPorTipo col-md-12 form-control" from="${bitacora.TipoMantenimiento.list().sort{it.descripcion}}" optionKey="id"
                              optionValue="descripcion" noSelection="[ null: 'TODOS']"/>
                </span>
                <span class="col-md-3">
                    <label class="control-label text-info">Período</label>
                    <g:select name="buscarPorPeriodo" class="buscarPorPeriodo col-md-12 form-control" from="${bitacora.Periodo.list().sort{it.numero}}" optionKey="id"
                              optionValue="${{it.fechads?.format("dd-MM-yyyy") + " - " + it.fechahs?.format("dd-MM-yyyy")}}" noSelection="[ null: 'TODOS']"/>
                </span>
                <span class="col-md-2">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPor" class="buscarPor col-md-12 form-control" from="${[1: 'Requerimiento', 2: 'Clave']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-3">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="buscarCriterio" id="criterioCriterio" class="form-control"/>
                </span>
            </span>
            <div class="col-md-2" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarActividad"><i class="fa fa-search"></i></button>
                <button class="btn btn-warning" id="btnLimpiarBusquedaActividad"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>
</div>

<div class="col-md-12" style="margin-top: 20px">
    <div class="col-md-8" id="divActividad">

    </div>
    <div class="col-md-4" id="divVerActividad">

    </div>
</div>

<script type="text/javascript">

    var mbu;

    $("#btnCrearActividad").clic(function () {
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
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    $("#btnBuscarTodosUsuario").click(function () {
        $("#usuarioBusquedaId").val(null);
        $("#usuarioBusquedaName").val("Todos los usuarios")
    });

    $("#btnBuscarUsuario").click(function () {
        buscarUsuario();
    });

    function buscarUsuario(){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'actividad', action: 'buscarUsuario_ajax')}",
            data    : {
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
        $(".buscarPorTipo").val();
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


</script>
</body>
</html>