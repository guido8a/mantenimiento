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
        <g:if test="${oficios.size() > 0}">
            <g:each in="${oficios}" var="oficio">
                <tr style="width: 100%">
                    <td style="width: 15%">
                        ${oficio.contrato?.numero}
                    </td>
                    <td style="width: 15%">
                        ${(oficio?.periodo?.fechads?.format("dd-MM-yyyy") ?: '') + " - " + (oficio?.periodo?.fechads?.format("dd-MM-yyyy") ?: '')}
                    </td>
                    <td style="width: 20%">
                        ${oficio?.numero}
                    </td>
                    <td style="width: 10%">
                        ${oficio?.fecha?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 10%; text-align: center">
                        <a class="btn btn-xs btnVerOficio btn-info" href="#"  title="Editar" data-id="${oficio.id}">
                            <i class="fa fa-search"></i>
                        </a>
                        <a class="btn btn-xs btnEditarOficio btn-success" href="#"  title="Editar" data-id="${oficio.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btnBorrarOficio btn-danger" href="#" title="Eliminar" data-id="${oficio.id}">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                    <td style="width: 10%; text-align: center">
                        <a class="btn btn-xs btnImprimirOficio btn-info" href="#"  title="Imprimir oficio" data-id="${oficio.id}">
                            <i class="fa fa-print"></i>
                        </a>
                        <a class="btn btn-xs btnImprimirInforme btn-warning" href="#"  title="Imprimir informe" data-id="${oficio.id}">
                            <i class="fa fa-print"></i>
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

    $(".btnImprimirInforme").click(function () {
        var id = $(this).data("id");
        location.href = "${g.createLink(controller:'reportes', action: 'reporteInforme')}?id=" + id
    });

    $(".btnVerOficio").click(function () {
        var id = $(this).data("id");
        verOficio(id);
    });

    $(".btnEditarOficio").click(function () {
        var id = $(this).data("id");
        createEditOficio(id);
    });
    $(".btnBorrarOficio").click(function () {
        var id = $(this).data("id");
        deleteOficio(id);
    });

</script>