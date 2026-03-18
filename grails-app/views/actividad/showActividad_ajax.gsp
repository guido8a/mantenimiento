<g:if test="${actividad?.periodo?.contrato}">
    <div class="row">
        <div class="col-md-2 text-info">
            Contrato
        </div>
        <div class="col-md-10">
            ${actividad?.periodo?.contrato?.numero}
        </div>
    </div>
</g:if>

<g:if test="${actividad?.periodo}">
    <div class="row">
        <div class="col-md-2 text-info">
            Período
        </div>
        <div class="col-md-10">
            ${(actividad?.periodo?.fechads?.format("dd-MM-yyyy") ?: '') + " - " + (actividad?.periodo?.fechads?.format("dd-MM-yyyy") ?: '')}
        </div>
    </div>
</g:if>

<g:if test="${actividad?.requerimiento}">
    <div class="row">
        <div class="col-md-2 text-info">
            Requerimiento
        </div>
        <div class="col-md-10">
            ${actividad?.requerimiento}
        </div>
    </div>
</g:if>

<g:if test="${actividad?.tipoMantenimiento}">
    <div class="row">
        <div class="col-md-2 text-info">
            Tipo de mantenimiento
        </div>
        <div class="col-md-10">
            ${actividad?.tipoMantenimiento?.descripcion}
        </div>
    </div>
</g:if>

<g:if test="${actividad?.moduloSistema}">
    <div class="row">
        <div class="col-md-2 text-info">
            Módulo del sistema
        </div>
        <div class="col-md-10">
            ${actividad?.moduloSistema?.descripcion}
        </div>
    </div>
</g:if>

<g:if test="${actividad?.fecha}">
    <div class="row">
        <div class="col-md-2 text-info">
            Fecha
        </div>
        <div class="col-md-10">
            ${(actividad?.fecha?.format("dd-MM-yyyy") ?: '')}
        </div>
    </div>
</g:if>

<div class="row">
    <div class="col-md-12 text-info">
        Descripción
    </div>
    <div class="col-md-12">
        <div class="col-md-12" style="font-size: 14px; border: 1px black">
            <elm2:poneHtml textoHtml="${actividad?.descripcion}" />
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12 text-info">
        Algoritmo
    </div>
    <div class="col-md-12">
        <div class="col-md-12" style="font-size: 14px">
            <elm2:poneHtml textoHtml="${actividad?.algoritmo}" />
        </div>
    </div>
</div>




