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
        <g:if test="${periodos}">
            <g:each in="${periodos}" var="periodo">
                <tr id="${periodo?.id}" data-id="${periodo?.id}" style="width: 100%">
                    <td style="width: 15%">
                        ${periodo?.numero}
                    </td>
                    <td style="width: 35%">
                        ${periodo?.fechads?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 35%">
                        ${periodo?.fechahs?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 15%; text-align: center">
                        <a class="btn btn-xs btn-edit btn-success" href="#"  title="Editar" data-id="${periodo.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btn-delete btn-danger" href="#" title="Eliminar" data-id="${periodo.id}">
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

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditPeriodo(id);
    });
    $(".btn-delete").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

</script>