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
        <g:each in="${empresas}" var="empresa" status="z">
            <tr id="${empresa.id}" data-id="${empresa.id}" style="width: 100%">
                <td style="width: 15%">
                    ${empresa?.ruc}
                </td>
                <td style="width: 30%">
                    ${empresa?.nombre}
                </td>
                <td style="width: 25%">
                    ${empresa?.direccion}
                </td>
                <td style="width: 15%">
                    ${empresa?.telefono}
                </td>
                <td style="width: 10%; text-align: center">
                    <a class="btn btn-xs btnVerEmpresa btn-info" href="#"  title="Ver" data-id="${empresa.id}">
                        <i class="fa fa-search"></i>
                    </a>
                    <a class="btn btn-xs btn-edit btn-success" href="#"  title="Editar" data-id="${empresa.id}">
                        <i class="fa fa-edit"></i>
                    </a>
                    <a class="btn btn-xs btn-delete btn-danger" href="#" title="Eliminar" data-id="${empresa.id}">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
              </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnVerEmpresa").click(function () {
        var id = $(this).data("id");
        verEmpresa(id);
    });

    $(".btn-edit").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });
    $(".btn-delete").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

</script>