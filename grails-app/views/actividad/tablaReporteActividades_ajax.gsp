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
                    <td style="width: 10%">${actividad.periodo?.contrato?.numero}</td>
                    <td style="width: 17%">${actividad?.periodo?.fechads?.format("dd-MM-yyyy") + " - " + actividad?.periodo?.fechahs?.format("dd-MM-yyyy")}</td>
                    <td style="width: 13%">${actividad?.requerimiento}</td>
                    <td style="width: 14%">${actividad?.usuario?.apellido + " "  + actividad?.usuario?.nombre}</td>
                    <td style="width: 45%">${actividad?.descripcion}</td>
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

