
<div style="font-size: 12px">


    <g:if test="${responsable?.apellido}">
        <div class="row">
            <div class="col-md-2 text-info">
                Apellido
            </div>
            <div class="col-md-10">
                ${responsable?.apellido}
            </div>
        </div>
    </g:if>

    <g:if test="${responsable?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            <div class="col-md-10">
                ${responsable?.nombre}
            </div>
        </div>
    </g:if>

    <g:if test="${responsable?.contrato}">
        <div class="row">
            <div class="col-md-2 text-info">
                Contrato
            </div>
            <div class="col-md-10">
                ${responsable?.contrato?.numero}
            </div>
        </div>
    </g:if>

    <g:if test="${responsable?.titulo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Título
            </div>
            <div class="col-md-10">
                ${responsable?.titulo}
            </div>
        </div>
    </g:if>

    <g:if test="${responsable?.cargo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Cargo
            </div>
            <div class="col-md-10">
                ${responsable?.cargo}
            </div>
        </div>
    </g:if>

    <g:if test="${responsable?.departamento}">
        <div class="row">
            <div class="col-md-2 text-info">
                Departamento
            </div>
            <div class="col-md-10">
                ${responsable?.departamento}
            </div>
        </div>
    </g:if>

    <g:if test="${responsable?.telefono}">
        <div class="row">
            <div class="col-md-2 text-info">
                Teléfono
            </div>
            <div class="col-md-10">
                ${responsable?.telefono}
            </div>
        </div>
    </g:if>

    <g:if test="${responsable?.mail}">
        <div class="row">
            <div class="col-md-2 text-info">
                Email
            </div>
            <div class="col-md-10">
                ${responsable?.mail}
            </div>
        </div>
    </g:if>

    <g:if test="${responsable?.sexo}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Sexo
            </div>
            <div class="col-md-4  ">
                ${responsable.sexo == "M" ? "Masculino" : "Femenino"}
            </div>
        </div>
    </g:if>


    <g:if test="${responsable?.fechaInicio}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Inicio
            </div>

            <div class="col-md-9">
                <g:formatDate date="${responsable?.fechaInicio}" format="dd-MM-yyyy" />
            </div>

        </div>
    </g:if>

    <g:if test="${responsable?.fechaFin}">
        <div class="row">
            <div class="col-md-2 text-info">
                Fecha Fin
            </div>

            <div class="col-md-9">
                <g:formatDate date="${responsable?.fechaFin}" format="dd-MM-yyyy" />
            </div>

        </div>
    </g:if>
</div>