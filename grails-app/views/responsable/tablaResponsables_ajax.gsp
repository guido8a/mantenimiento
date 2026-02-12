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

<div class="" style="width: 99.7%;height: 390px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:if test="${responsables.size() > 0}">
            <g:each in="${responsables}" var="responsable">
                <tr style="width: 100%">
                    <td style="width: 15%">
                        ${responsable?.contrato?.numero}
                    </td>
                    <td style="width: 20%">
                        ${responsable?.apellido}
                    </td>
                    <td style="width: 20%">
                        ${responsable?.nombre}
                    </td>
                    <td style="width: 15%">
                        ${responsable?.fechaInicio?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 15%">
                        ${responsable?.fechaFin?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 10%; text-align: center">
                        <a class="btn btn-xs btnVerResponsable btn-info" href="#"  title="Editar" data-id="${responsable.id}">
                            <i class="fa fa-search"></i>
                        </a>
                        <a class="btn btn-xs btnEditarResponsable btn-success" href="#"  title="Editar" data-id="${responsable.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btnBorrarResponsable btn-danger" href="#" title="Eliminar" data-id="${responsable.id}">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No se encontraron registros</div>
        </g:else>
    </table>
</div>

<script type="text/javascript">

    $(".btnVerResponsable").click(function () {
        var id = $(this).data("id");
        verResponsable(id);
    });

    $(".btnEditarResponsable").click(function () {
        var id = $(this).data("id");
        createEditResponsable(id);
    });
    $(".btnBorrarResponsable").click(function () {
        var id = $(this).data("id");
        deleteResponsable(id);
    });

</script>