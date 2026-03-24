<table class="table table-bordered table-striped table-hover table-condensed" id="tabla" style="width: 100%; background-color: #a39e9e">
    <thead>
    <tr style="text-align: center">
        <th style="width: 10%">Número</th>
        <th style="width: 15%">Responsable</th>
        <th style="width: 15%">Usuario</th>
        <th style="width: 10%">Fecha</th>
        <th style="width: 37%">Descripción</th>
        <th style="width: 22%">Acciones</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%;height: 450px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
        <g:if test="${cambios.size() > 0}">
            <g:each in="${cambios}" var="cambio">
                <tr style="width: 100%">
                    <td style="width: 10%">${cambio?.numero}</td>
                    <td style="width: 15%">${(cambio?.responsable?.apellido ?: '') + " " + (cambio?.responsable?.nombre)}</td>
                    <td style="width: 15%">${(cambio?.usuario?.apellido ?: '') +  " " + (cambio?.usuario?.nombre)}</td>
                    <td style="width: 10%">${cambio?.fecha?.format("dd-MM-yyyy")}</td>
                    <td style="width: 37%">${cambio?.descripcion}</td>
                    <td style="width: 22%; text-align: center">
                        <a class="btn btn-xs btnEditarCambio btn-success" href="#" title="Editar" data-id="${cambio?.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btnBorrarCambio btn-danger" href="#" title="Eliminar" data-id="${cambio?.id}">
                            <i class="fa fa-trash"></i>
                        </a>
                        <a class="btn btn-xs btnImprimirCambio btn-info" href="#" title="Imprimir" data-id="${cambio?.id}">
                            <i class="fa fa-print"></i>
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

    $(".btnImprimirCambio").click(function () {
        var id = $(this).data("id");
        location.href = "${g.createLink(controller:'reportes', action: 'reporteCambios')}?id=" + id
    });

    $(".btnBorrarCambio").click(function () {
        var id = $(this).data("id");
        deleteCambio(id)
    });

    $(".btnEditarCambio").click(function () {
        var id = $(this).data("id");
        createEditCambio(id)
    });

    $(".btnVercambio").click(function () {
        var id = $(this).data("id");
        verCambio(id)
    });

</script>
