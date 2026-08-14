<table class="table table-bordered table-striped table-hover table-condensed" id="tabla" style="width: 100%; background-color: #a39e9e">
    <thead>
    <tr style="text-align: center">
        <th style="width: 15%">Fecha</th>
        <th style="width: 84%">Descripción</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%; height: 450px; overflow-y: auto;float: right;">
    <table class="table-bordered table-condensed table-striped" style="width: 100%; font-size: 14px">
        <g:if test="${resultado.size() > 0}">
            <g:each in="${resultado}" var="actividad">
                <tr>
                    <td style="width: 15%">${actividad?.fecha?.format("dd-MM-yy HH:mm")}</td>
                    <td style="width: 84%">${actividad.descripcion}</td>
                    <td style="width: 1%"></td>
                </tr>
                <tr class="alert alert-info">
                    <td style="width: 15%"></td>
                    <td style="width: 84%"><elm2:poneHtml textoHtml="${actividad.algoritmo ?: '  - Sin algoritmo - '}"/></td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold">
                <i class="fa fa-exclamation-triangle fa-2x text-info"></i> No se encontraron registros</div>
        </g:else>
    </table>
</div>