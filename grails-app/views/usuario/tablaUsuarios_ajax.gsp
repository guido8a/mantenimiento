<%@ page import="seguridad.Persona" %>
<table class="table table-bordered table-striped table-hover table-condensed" id="tabla" style="width: 100%; background-color: #a39e9e">
    <thead>
    <tr style="text-align: center">
        <th style="width: 10%">Cédula</th>
        <th style="width: 20%">Nombre</th>
        <th style="width: 20%">Apellido</th>
        <th style="width: 10%">Estado</th>
        <th style="width: 15%">Acciones</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%;height: 450px; overflow-y: auto;float: right;">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
        <g:if test="${data.size() > 0}">
            <g:each in="${data}" var="dt" status="i">
                <g:set var="usuario" value="${dt.usro__id}"/>
                <tr data-id="${dt.usro__id}" class="${dt.pcntactv == 0 ? 'inactivo' : 'activo'}">
                    <td style="width: 10%">${dt.pcntcdla}</td>
                    <td style="width: 20%">${dt.pcntnmbr}</td>
                    <td style="width: 20%">${dt.pcntapll}</td>
                    <td style="width: 10%; text-align: center">
                        <g:if test="${dt.prsnactv == '1'}">
                            <i class="fa fa-user text-success"></i> Activo
                        </g:if>
                        <g:else>
                            <i class="fa fa-user text-muted"></i> Inactivo
                        </g:else>
                    </td>
                    <td style="width: 15%; text-align: center">
                        <a class="btn btn-xs btnVerPersona btn-info" href="#"  title="Ver" data-id="${dt.usro__id}">
                            <i class="fa fa-search"></i>
                        </a>
                        <a class="btn btn-xs btnEditarPersona btn-success" href="#" title="Editar" data-id="${dt.usro__id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btnResetear btn-warning" href="#" title="Restablecer contraseña y autorización" data-id="${dt.usro__id}">
                            <i class="fa fa-retweet"></i>
                        </a>
                        <a class="btn btn-xs btnPerfiles btn-info" href="#"  title="Perfiles" data-id="${dt.usro__id}">
                            <i class="fa fa-address-card"></i>
                        </a>
                        <a class="btn btn-xs btnBorrarPersona btn-danger" href="#" title="Eliminar" data-id="${dt.usro__id}">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                    <td style="width: 1%"></td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No se encontraron registros</div>
        </g:else>
    </table>
</div>

<script type="text/javascript">


    $(".btnPerfiles").click(function () {
        var id = $(this).data("id");
        location.href="${createLink(controller: 'persona', action: 'perfiles')}?id=" + id
    });

    $(".btnResetear").click(function () {
        var id = $(this).data("id");
        restablecerContrasena(id);
    });

    $(".btnBorrarPersona").click(function () {
        var id = $(this).data("id");
        deletePersona(id)
    });

    $(".btnEditarPersona").click(function () {
        var id = $(this).data("id");
        createEditRow(id)
    });

    $(".btnVerPersona").click(function () {
        var id = $(this).data("id");
        verPersona(id)
    });

</script>
