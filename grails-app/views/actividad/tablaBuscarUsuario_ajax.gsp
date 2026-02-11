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
</style>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla" style="width: 100%; background-color: #a39e9e">
    <thead>
    <tr style="text-align: center">
        <th style="width: 15%">Empresa</th>
        <th style="width: 17%">Cédula</th>
        <th style="width: 28%">Nombre</th>
        <th style="width: 30%">Apellido</th>
        <th style="width: 9%"></th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%; height: 350px; overflow-y: auto;float: right;">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
        <g:if test="${data.size() > 0}">
            <g:each in="${data}" var="dt" status="i">
                <g:set var="usuario" value="${dt.usro__id}"/>
                <tr data-id="${dt.usro__id}" style="width: 100%">
                    <td style="width: 15%">${bitacora.Usuario.get(dt.usro__id)?.empresa?.sigla}</td>
                    <td style="width: 17%">${dt.usrocdla}</td>
                    <td style="width: 28%">${dt.usronmbr}</td>
                    <td style="width: 30%">${dt.usroapll}</td>
                    <td style="width: 9%; text-align: center">
                        <a class="btn btn-xs btnSeleccionarUsuario btn-success" href="#"  title="Seleccionar usuario"
                           data-id="${dt.usro__id}" data-cedula="${dt.usrocdla}" data-nombre="${dt.usronmbr}" data-apellido="${dt.usroapll}">
                            <i class="fa fa-check"></i>
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
    
    $(".btnSeleccionarUsuario").click(function () {
        var id = $(this).data("id");
        var cedula = $(this).data("cedula");
        var nombre = $(this).data("nombre");
        var apellido = $(this).data("apellido");
        <g:if test="${tipo == '1'}">
        $("#usuario").val(id);
        $("#usuarioName").val(cedula + " - " + apellido + " " + nombre);
        </g:if>
        <g:else>
        $("#usuarioBusquedaId").val(id);
        $("#usuarioBusquedaName").val(cedula + " - " + apellido + " " + nombre);
        </g:else>
        cerrarBusquedaUsuario();
    })
    

</script>