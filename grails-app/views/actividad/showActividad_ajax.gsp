<div class="row" >
    <div class="col-md-12">
        <div class="col-md-12" style="border: 1px #000000 solid; font-size: 14px">
            <g:if test="${actividad?.periodo?.contrato}">
                <div class="col-md-1 text-info">
                    Contrato:
                </div>
                <div class="col-md-3">
                    ${actividad?.periodo?.contrato?.numero}
                </div>
            </g:if>
            <g:if test="${actividad?.periodo}">
                <div class="col-md-1 text-info">
                    Período:
                </div>
                <div class="col-md-3">
                    ${(actividad?.periodo?.fechads?.format("dd-MM-yyyy") ?: '') + " - " + (actividad?.periodo?.fechads?.format("dd-MM-yyyy") ?: '')}
                </div>
            </g:if>
            <g:if test="${actividad?.fecha}">
                <div class="col-md-1 text-info">
                    Fecha:
                </div>
                <div class="col-md-3">
                    ${(actividad?.fecha?.format("dd-MM-yyyy") ?: '')}
                </div>
            </g:if>

            <g:if test="${actividad?.tipoMantenimiento}">
                <div class="col-md-3 text-info">
                    Tipo de mantenimiento:
                </div>
                <div class="col-md-8">
                    ${actividad?.tipoMantenimiento?.descripcion}
                </div>
            </g:if>
            <g:if test="${actividad?.moduloSistema}">
                <div class="col-md-3 text-info">
                    Módulo del sistema:
                </div>
                <div class="col-md-8">
                    ${actividad?.moduloSistema?.descripcion}
                </div>
            </g:if>

            <g:if test="${actividad?.requerimiento}" >
                <div class="col-md-3 text-info">
                    Requerimiento:
                </div>
                <div class="col-md-8">
                    ${actividad?.requerimiento}
                </div>
            </g:if>
        </div>
    </div>
</div>






<div class="row" >
    <div class="col-md-12 text-info" style="font-size: 12px; font-weight: bold">
        Palabras clave
    </div>
    <div class="col-md-12" >
        <div class="col-md-12 alert alert-warning" style="border: 1px #000000 solid;">
            <div class="col-md-12" style="font-size: 12px; border: 1px black">
                ${actividad?.clave}
            </div>
        </div>
    </div>
</div>


<div class="row" >
    <div class="col-md-12 text-info" style="font-size: 16px; font-weight: bold">
        Descripción
    </div>
    <div class="col-md-12" >
        <div class="col-md-12 alert alert-info" style="border: 1px #000000 solid;">
            <div class="col-md-12" style="font-size: 14px; border: 1px black">
                <elm2:poneHtml textoHtml="${actividad?.descripcion}" />
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12 text-info" style="font-size: 16px; font-weight: bold">
        Algoritmo
    </div>
    <div class="col-md-12">
        <div class="col-md-12 alert alert-success"  style="border: 1px #000000 solid;">
            <div class="col-md-12" style="font-size: 14px">
                <elm2:poneHtml textoHtml="${actividad?.algoritmo}" />
            </div>
        </div>
    </div>
</div>




