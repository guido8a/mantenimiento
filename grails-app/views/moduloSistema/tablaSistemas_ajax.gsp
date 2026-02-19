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
        <g:if test="${modulos.size() > 0}">
            <g:each in="${modulos}" var="modulo">
                <tr style="width: 100%">
                    <td style="width: 40%">
                        ${modulo?.codigo}
                    </td>
                    <td style="width: 40%">
                        ${modulo?.descripcion}
                    </td>
                    <td style="width: 20%; text-align: center">
                        <a class="btn btn-xs btnEditarOficio btn-success" href="#"  title="Editar" data-id="${modulo.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btnBorrarOficio btn-danger" href="#" title="Eliminar" data-id="${modulo.id}">
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

    $(".btnEditarOficio").click(function () {
        var id = $(this).data("id");
        createEditModulo(id);
    });
    $(".btnBorrarOficio").click(function () {
        var id = $(this).data("id");
        deleteModulo(id);
    });

</script>