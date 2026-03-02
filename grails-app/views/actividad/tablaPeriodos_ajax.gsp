<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
</style>


<table class="table table-bordered table-striped table-hover table-condensed" id="tabla" style="width: 100%; background-color: #a39e9e">
    <thead>
    <tr style="text-align: center">
        <th class="alinear" style="width: 25%">Contrato</th>
        <th class="alinear" style="width: 15%">Número</th>
        <th class="alinear"  style="width: 25%">Fecha Inicio</th>
        <th class="alinear"  style="width: 25%">Fecha Fin</th>
        <th class="alinear" style="width: 20%">Seleccionar</th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%;height: 200px; overflow-y: auto;float: right;">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
        <g:if test="${periodos}">
            <g:each in="${periodos}" var="periodo">
                <tr id="${periodo?.id}" data-id="${periodo?.id}" style="width: 100%">
                    <td style="width: 25%">
                        ${periodo?.contrato?.numero}
                    </td>
                    <td style="width: 15%; text-align: center">
                        ${periodo?.numero}
                    </td>
                    <td style="width: 25%">
                        ${periodo?.fechads?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 25%">
                        ${periodo?.fechahs?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 20%; text-align: center">
                        <a class="btn btn-xs btnSeleccionarPeriodo btn-success" href="#"
                           title="Seleccionar período" data-id="${periodo.id}" data-idC="${periodo?.contrato?.id}"
                           data-nombre="${periodo?.fechads?.format("dd-MM-yyyy") + " - " + periodo?.fechahs?.format("dd-MM-yyyy")}" data-nombreContrato="${periodo?.contrato?.numero}">
                            <i class="fa fa-check"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No se encontraron registros</div>
        </g:else>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleccionarPeriodo").click(function () {
        var id = $(this).data("id");
        var idContrato = $(this).data("idc");
        var nombre= $(this).data("nombre");
        var nombreContrato = $(this).data("nombrecontrato");

        $("#contratoBusquedaId").val(idContrato);
        $("#contratoBusquedaName").val(nombreContrato);
        $("#periodoBusquedaId").val(id);
        $("#periodoBusquedaName").val(nombre);

        cerrarBusquedaContrato();
    });

</script>