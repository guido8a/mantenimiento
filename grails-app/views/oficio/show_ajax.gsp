<div style="font-size: 12px">
    <g:if test="${oficio?.contrato}">
        <div class="row">
            <div class="col-md-2 text-info">
                Contrato
            </div>
            <div class="col-md-10">
                ${oficio?.contrato?.numero}
            </div>
        </div>
    </g:if>

    <g:if test="${oficio?.periodo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Período
            </div>
            <div class="col-md-10">
                ${(oficio?.periodo?.fechads?.format("dd-MM-yyyy") ?: '') + " - " + (oficio?.periodo?.fechads?.format("dd-MM-yyyy") ?: '')}
            </div>
        </div>
    </g:if>

    <g:if test="${oficio?.numero}">
        <div class="row">
            <div class="col-md-2 text-info">
                Número
            </div>
            <div class="col-md-10">
                ${oficio?.numero}
            </div>
        </div>
    </g:if>

    <g:if test="${oficio?.fecha}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha
            </div>
            <div class="col-md-9">
                <g:formatDate date="${oficio?.fecha}" format="dd-MM-yyyy" />
            </div>
        </div>
    </g:if>

    <g:if test="${oficio?.texto}">
        <div class="row">
            <div class="col-md-2 text-info">
                Oficio
            </div>
            <div class="col-md-9">
                <util:renderHTML html="${oficio?.texto}"/>
            </div>
        </div>
    </g:if>
</div>