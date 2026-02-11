<%@ page import="seguridad.Persona" %>

<div class="modal-contenido" style="font-size: 14px">

    <g:if test="${usuario?.cedula}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Cédula
            </div>
            <div class="col-md-6 ">
                ${usuario?.cedula}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.nombre}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Nombre
            </div>
            <div class="col-md-6 ">
                ${usuario?.nombre}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.apellido}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Apellido
            </div>
            <div class="col-md-6 ">
                ${usuario?.apellido}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.empresa}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Empresa
            </div>
            <div class="col-md-6 ">
                ${usuario?.empresa?.nombre}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.titulo}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Título
            </div>
            <div class="col-md-4 ">
                ${usuario?.titulo}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.sexo}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Sexo
            </div>
            <div class="col-md-4  ">
                ${usuario.sexo == "M" ? "Masculino" : "Femenino"}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.telefono}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Teléfono
            </div>
            <div class="col-md-4 ">
                ${usuario?.telefono}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.mail}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                E-mail
            </div>
            <div class="col-md-4  ">
                ${usuario?.mail}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.activo}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Activo
            </div>

            <div class="col-md-4 ">
                ${usuario?.activo == '1' ? "ACTIVO" : "NO ACTIVO"}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.fechaInicio}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Fecha Inicio
            </div>

            <div class="col-md-4 ">
                ${usuario?.fechaInicio?.format("dd-MM-yyyy")}
            </div>
        </div>
    </g:if>

    <g:if test="${usuario?.fechaFin}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Fecha Fin
            </div>

            <div class="col-md-4 ">
                ${usuario?.fechaFin?.format("dd-MM-yyyy")}
            </div>
        </div>
    </g:if>
</div>