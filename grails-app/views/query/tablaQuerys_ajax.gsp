<%@ page import="bitacora.Periodo" %>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla" style="width: 100%; background-color: #a39e9e">
    <thead>
    <tr style="text-align: center">
        <th style="width: 15%">Clave</th>
        <th style="width: 8%">Fecha</th>
        <th style="width: 41%">Problema</th>
        <th style="width: 25%">Algoritmo</th>
        <th style="width: 10%">Acciones</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%; height: 450px; overflow-y: auto;float: right;">
    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
        <g:if test="${data.size() > 0}">
            <g:each in="${data}" var="query">
                <g:set var="id" value="${query?.sqls__id}"/>
                <tr data-id="${query?.sqls__id}" style="width: 100%" >
                    <td style="width: 15%">${query.sqlsclve}</td>
                    <td style="width: 8%">${query?.sqlsfcha?.format("dd-MM-yyyy")}</td>
                    <td style="width: 41%">${query.sqlsprbl}</td>
                    <td style="width: 25%">${query.sqlsalgr}</td>
                    <td style="width: 10%; text-align: center">
                        <a class="btn btn-xs btn-info btnVerQuery" href="#"  title="Ver query" data-id="${query?.sqls__id}">
                            <i class="fa fa-search"></i>
                        </a>
                        <a class="btn btn-xs btn-success btnEditarQuery" href="#"  title="Editar query" data-id="${query?.sqls__id}">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a class="btn btn-xs btn-danger btnBorrarQuery" href="#"  title="Eliminar query" data-id="${query?.sqls__id}">
                            <i class="fa fa-trash"></i>
                        </a>
                    </td>
                    <td style="width: 1%"></td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold">
                <i class="fa fa-exclamation-triangle fa-2x text-info"></i> No se encontraron registros</div>
        </g:else>
    </table>
</div>


<script type="text/javascript">

    $(".btnBorrarQuery").click(function () {
        var id = $(this).data("id");
        deleteQuery(id)
    });

    $(".btnEditarQuery").click(function () {
        var id = $(this).data("id");
        createEditQuery(id)
    });

    $(".btnVerQuery").click(function () {
        var id = $(this).data("id");
        verQuery(id);
    });

</script>
