<%@ page import="bitacora.Periodo" %>
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
        <th style="width: 18%">Usuario</th>
        <th style="width: 22%">Tipo</th>
        <th style="width: 25%">Período</th>
        <th style="width: 20%">Requerimiento</th>
        <th style="width: 14%"></th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%; height: 350px; overflow-y: auto;float: right;">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
        <g:if test="${data.size() > 0}">
            <g:each in="${data}" var="actividad">
                <g:set var="actividadId" value="${actividad?.actv__id}"/>
                <tr data-id="${actividad.actv__id}" style="width: 100%">
                    <td style="width: 18%">${bitacora.Usuario.get(actividad.usro__id)?.apellido + "  " +
                            bitacora.Usuario.get(actividad.usro__id)?.nombre}</td>
                    <td style="width: 22%">${bitacora.TipoMantenimiento.get(actividad.tpmt__id)?.descripcion}</td>
                    <td style="width: 25%">${bitacora.Periodo.get(actividad.prdo__id)?.fechads?.format("dd-MM-yyyy") + " - " + bitacora.Periodo.get(actividad.prdo__id)?.fechahs?.format("dd-MM-yyyy")}</td>
                    <td style="width: 20%">${actividad.actvreqm}</td>
                    <td style="width: 14%; text-align: center">
                        <a class="btn btn-xs btn-success btnEditarActividad" href="#"  title="Editar actividad" data-id="${actividad.actv__id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btn-info btnVerActividad" href="#"  title="Ver actividad" data-id="${actividad.actv__id}">
                            <i class="fa fa-arrow-right"></i>
                        </a>
                        <a class="btn btn-xs btn-danger btnBorrarActividad" href="#"  title="Eliminar actividad" data-id="${actividad.actv__id}">
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

    $(".btnBorrarActividad").click(function () {
        var id = $(this).data("id");
        deleteActividad(id)
    });

    $(".btnEditarActividad").click(function () {
        var id = $(this).data("id");
        createEditActividad(id)
    });

    $(".btnVerActividad").click(function () {
        var id = $(this).data("id");
        cargarVerActividades(id);
    });

    cargarVerActividades();

    function cargarVerActividades(id){
        var d = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'actividad', action: 'verActividad')}',
            data:{
                id: id
            },
            success: function (msg){
                d.modal("hide");
                $("#divVerActividad").html(msg)
            }
        })
    }


</script>
