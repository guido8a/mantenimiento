<table class="table table-bordered table-striped table-hover table-condensed" id="tabla" style="width: 100%; background-color: #a39e9e">
    <thead>
    <tr style="text-align: center">
        <th style="width: 25%">Siglas</th>
        <th style="width: 60%">Nombre</th>
        <th style="width: 14%">Acciones</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%;height: 450px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
        <g:if test="${sistemas.size() > 0}">
            <g:each in="${sistemas}" var="sistema">
                <tr style="width: 100%">
                    <td style="width: 25%">${sistema?.siglas}</td>
                    <td style="width: 60%">${sistema?.nombre}</td>
                    <td style="width: 14%; text-align: center">
                        <a class="btn btn-xs btnEditarSistema btn-success" href="#" title="Editar" data-id="${sistema?.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btnBorrarSistema btn-danger" href="#" title="Eliminar" data-id="${sistema?.id}">
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


    $(".btnBorrarSistema").click(function () {
        var id = $(this).data("id");
        deleteSistema(id)
    });

    $(".btnEditarSistema").click(function () {
        var id = $(this).data("id");
        createEditSistema(id)
    });


</script>
