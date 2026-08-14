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

.mejora {
    color: #0000cc;
}
</style>

<div class="" style="width: 99.7%; height: 450px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
        <g:if test="${actividades.size() > 0}">
            <g:each in="${actividades}" var="actividad">
                <tr>
                    <td style="width: 75%">${actividad?.descripcion}</td>
                    <td style="width: 18%">${actividad.periodo?.contrato?.numero}
                    ${actividad?.periodo?.fechads?.format("dd-MM-yyyy") + " - " + actividad?.periodo?.fechahs?.format("dd-MM-yyyy")}
                    (${actividad?.usuario?.apellido + " "  + actividad?.usuario?.nombre})</td>
                    <td style="width: 6%; text-align: center">
                        <a class="btn btn-xs btn-info btnVerActividad" href="#"  title="Ver actividad" data-id="${actividad.id}">
                            <i class="fa fa-search"></i>
                        </a>
                    </td>
                    <td style="width: 1%"></td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold">
                <i class="fa fa-exclamation-triangle fa-2x text-info"></i> No se encontraron registros</div>
        </g:else>
    </table>
</div>

<script type="text/javascript">

    $(".btnVerActividad").click(function () {
        var id = $(this).data("id");
        verActividadReporte(id);
    });

</script>

