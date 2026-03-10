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
        <g:if test="${empresas}">
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
                    <td style="width: 10%">
                        ${empresa?.telefono}
                    </td>
                    <td style="width: 15%; text-align: center">
                        <a class="btn btn-xs btnVerEmpresa btn-info" href="#"  title="Ver" data-id="${empresa.id}">
                            <i class="fa fa-search"></i>
                        </a>
                        <a class="btn btn-xs btn-edit btn-success" href="#"  title="Editar" data-id="${empresa.id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btnCargarLogo btn-info" href="#" title="Cargar logo" data-id="${empresa.id}">
                            <i class="fa fa-image"></i>
                        </a>
                        <a class="btn btn-xs btn-delete btn-danger" href="#" title="Eliminar" data-id="${empresa.id}">
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

    var di;

    $(".btnCargarLogo").click(function () {
        var id = $(this).data("id");
        cargarLogo(id);
    });

    function cargarLogo(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'empresa', action:'logo_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                di = bootbox.dialog({
                    id      : "dlgFoto",
                    title   : "Logo",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-gris",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function cerrarCargaLogo(){
        di.modal("hide")
    }

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