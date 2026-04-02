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
        <g:if test="${contratos.size() > 0}">
            <g:each in="${contratos}" var="contrato">
                <tr style="width: 100%">
                    <td style="width: 7%">
                        ${contrato?.empresa?.sigla}
                    </td>
                    <td style="width: 10%">
                        ${contrato?.numero}
                    </td>
                    <td style="width: 62%">
                        ${contrato?.objeto}
                    </td>
                    <td style="width: 7%">
                        ${contrato?.fechaSubscripcion?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 7%">
                        ${contrato?.fechaInicio?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 7%">
                        ${contrato?.fechaFin?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 10%; text-align: center">
                        <a class="btn btn-xs btnEditarContrato btn-success" href="#"  title="Editar" data-id="${contrato.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btnBorrarContrato btn-danger" href="#" title="Eliminar" data-id="${contrato.id}">
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

    $(".btnVerContrato").click(function () {
        var id = $(this).data("id");
        verEmpresa(id);
    });

    $(".btnEditarContrato").click(function () {
        var id = $(this).data("id");
        createEditContrato(id);
    });
    $(".btnBorrarContrato").click(function () {
        var id = $(this).data("id");
        deleteContrato(id);
    });

</script>