<%@ page import="seguridad.Persona" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Reportes</title>
</head>

<body>

<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <a href="#" class="btn btn-info" id="btnImprimirBusqueda">
            <i class="fa fa-print"></i> Imprimir
        </a>
    </div>
</div>

<script type="text/javascript">

    $("#btnImprimirBusqueda").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'reportes', action:'buscarActividades_ajax')}",
            data    : {
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : "Reporte actividades",
                    class   : "modal-sm",
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
                            label     : "<i class='fa fa-print'></i> Imprimir",
                            className : "btn-success",
                            callback  : function () {
                                location.href="${createLink(controller: 'reportes', action: 'reporteActividades')}?clave=" + $("#clave").val();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });

</script>
</body>
</html>