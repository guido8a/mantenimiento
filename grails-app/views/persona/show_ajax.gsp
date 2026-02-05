<%@ page import="seguridad.Persona" %>

<div class="modal-contenido" style="font-size: 14px">
    <g:if test="${personaInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Nombre
            </div>
            <div class="col-md-6 ">
                ${personaInstance?.nombre}
            </div>
        </div>
    </g:if>

    <g:if test="${personaInstance?.apellido}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Apellido
            </div>
            <div class="col-md-6 ">
                ${personaInstance?.apellido}"
            </div>
        </div>
    </g:if>

    <g:if test="${personaInstance?.login}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Usuario
            </div>

            <div class="col-md-4 ">
                ${personaInstance?.login}
            </div>
        </div>
    </g:if>

    <g:if test="${personaInstance?.sigla}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Sigla
            </div>
            <div class="col-md-4 ">
                ${personaInstance?.sigla}/>
            </div>
        </div>
    </g:if>

    <g:if test="${personaInstance?.sexo}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Sexo
            </div>
            <div class="col-md-4  ">
                ${personaInstance.sexo == "M" ? "Masculino" : "Femenino"}
            </div>
        </div>
    </g:if>

    <g:if test="${personaInstance?.telefono}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Teléfono
            </div>
            <div class="col-md-4 ">
                ${personaInstance?.telefono}
            </div>
        </div>
    </g:if>

    <g:if test="${personaInstance?.mail}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                E-mail
            </div>
            <div class="col-md-4  ">
                ${personaInstance?.mail}
            </div>
        </div>
    </g:if>

    <g:if test="${personaInstance?.cargo}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Cargo
            </div>
            <div class="col-md-4 ">
                ${personaInstance?.cargo}
            </div>
        </div>
    </g:if>

    <g:if test="${personaInstance?.activo}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Activo
            </div>

            <div class="col-md-4 ">
                ${personaInstance?.activo == '1' ? "ACTIVO" : "NO ACTIVO"}
            </div>
        </div>
    </g:if>

    <div class="row">
        <div class="col-md-2 show-label text-info">
            Contraseña
        </div>

        <div class="col-md-4 ">
            ${personaInstance?.password ? "Si tiene contraseña creada" : "No tiene contraseña creada"}
        </div>
    </div>

    <div class="row">
        <div class="col-md-2 show-label  text-info">
            Autorización
        </div>

        <div class="col-md-6">
            ${personaInstance?.autorizacion ? "Si tiene autorización creada" : "No tiene autorización creada"}
        </div>
    </div>

    <g:if test="${perfiles.size() > 0}">
        <div class="row">
            <div class="col-md-2 show-label text-info">
                Perfiles
            </div>

            <div class="col-md-10">
                <ul>
                    <g:each in="${perfiles.perfil}" var="perfil">
                        <li>${perfil.nombre}</li>
                    </g:each>
                </ul>
            </div>
        </div>
    </g:if>
</div>