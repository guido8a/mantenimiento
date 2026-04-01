<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Reporte de actividades</title>
</head>

<body>

<div class="col-md-12">
    <div class="col-md-8">
        <div class="col-md-7">
            <div class="col-md-4">
                <label>Palabra clave</label>
            </div>
            <div class="col-md-8">
                <g:select name="clave" from="${claves}"  optionKey="${{it.palabra}}"
                          optionValue="${{it.palabra + " (frecuencia: " + it.cantidad + ") "}}" class="form-control" />
            </div>
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-info" id="btnBuscarActividades">
                <i class="fa fa-search"></i>
            </a>
        </div>
    </div>
    <div class="btn-group col-md-2" style="alignment: right">
        <a href="#" class="btn btn-info" id="btnImprimirBusqueda">
            <i class="fa fa-print"></i> Imprimir
        </a>
    </div>
</div>

<div class="col-md-12" style="margin-top: 10px; min-height: 400px">
    <table class="table table-bordered table-hover table-condensed" style="width: 100%; background-color: #a39e9e">
        <thead>
        <tr style="width: 100%">
            <th style="width: 10%">Contrato</th>
            <th style="width: 17%">Periodo</th>
            <th style="width: 13%">Requerimiento</th>
            <th style="width: 14%">Solicitante</th>
            <th style="width: 45%">Objeto</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>

    <div id="divActividades">
    </div>
</div>

<script type="text/javascript">

    $("#clave").change(function () {
        cargarTablaActividades();
    });

    $("#btnBuscarActividades").click(function () {
        cargarTablaActividades();
    });

    $("#btnImprimirBusqueda").click(function () {
        location.href="${createLink(controller: 'reportes', action: 'reporteActividades')}?clave=" + $("#clave").val();
    });

    cargarTablaActividades();

    function cargarTablaActividades(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'actividad', action: 'tablaReporteActividades_ajax')}",
            data    : {
                clave: $("#clave").val()
            },
            success : function (msg) {
                c.modal("hide");
                $("#divActividades").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divActividades").html("Ha ocurrido un error");
            }
        });
    }
</script>
</body>
</html>