<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Querys</title>

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
    <div class="col-md-12">
        <div class="col-md-2">
            <label for="sistemaBusqueda" class="control-label text-info">
                Sistema
            </label>
            <g:select name="sistemaBusqueda" from="${bitacora.Sistema.list().sort{it.nombre}}" class="form-control" optionKey="id"  optionValue="nombre"/>
        </div>
        <div class="col-md-2">
            <label class="control-label text-info">Buscar Por </label>
            <g:select name="buscarPor" class="buscarPor form-control" from="${[1: 'Problema', 2: 'Clave', 3: 'Algoritmo', 4: 'Referencia']}" optionKey="key" optionValue="value" />
        </div>
        <div class="col-md-3">
            <label class="control-label text-info">Criterio</label>
            <g:textField name="buscarCriterio" id="criterioCriterio" class="form-control" />
        </div>
        <div class="col-md-2" style="margin-top: 20px;">
            <button class="btn btn-sm btn-info bact" id="btnBuscarQuery" title="Buscar query">
                <i class="fa fa-search"></i> Buscar</button>
            <button class="btn btn-sm btn-warning" id="btnLimpiarBusquedaQuery"><i class="fa fa-eraser"></i></button>
        </div>
        <div class="col-md-2" style="margin-top: 20px" >
            <a href="#" class="btn btn-info btnCrearQuery"><i class="fa fa-file"></i>  Nuevo query</a>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12" style="margin-top: 15px">
        <div class="col-md-12" id="divQuery">

        </div>
    </div>
</div>
<script type="text/javascript">

    var mbc;

    $(".btnCrearQuery").click(function () {
        createEditQuery();
    });

    function createEditQuery(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'query', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Query",
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
                                return submitFormQuery();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormQuery() {
        // var algoritmo = CKEDITOR.instances.algoritmo.getData();
        var $form = $("#frmQuery");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'query', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0]==="ok") {
                        log(parts[1],"success");
                        cargarTablaQuery();
                    } else {
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        cargarTablaQuery();
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    $("#btnLimpiarBusquedaQuery").click(function () {
        $("#criterioCriterio").val("");
        $(".buscarPor").val(1);
        cargarTablaQuery();
    });

    $("#btnBuscarQuery").click(function () {
        cargarTablaQuery();
    });

    cargarTablaQuery();

    function cargarTablaQuery(){
        var d = cargarLoader("Cargando...");
        var sistema = $("#sistemaBusqueda").val();
        var criterio = $("#criterioCriterio").val();
        var buscarPor = $("#buscarPor option:selected").val();

        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'query', action: 'tablaQuerys_ajax')}',
            data:{
                sistema: sistema,
                criterio: criterio,
                buscarPor: buscarPor
            },
            success: function (msg){
                d.modal("hide");
                $("#divQuery").html(msg)
            }
        })
    }

    function deleteQuery(itemId) {
        bootbox.dialog({
            title   : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i> Alerta",
            message : "<p style='font-weight: bold; font-size: 14px'>¿Está seguro que desea eliminar el resgistro seleccionado?</p>",
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
                            url     : '${createLink(controller: 'query', action:'borrar_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                a.modal("hide");
                                var parts = msg.split("_");
                                if (parts[0] === "ok") {
                                    log(parts[1],"success");
                                    cargarTablaQuery();
                                } else {
                                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
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
            cargarTablaQuery();
            return false;
        }
        return true;
    });

    function verQuery(id){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'query', action: 'showQuery_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                var ac = bootbox.dialog({
                    id      : "dlgSQ",
                    class   : "modal-lg",
                    title   : "Ver query",
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

</script>
</body>
</html>