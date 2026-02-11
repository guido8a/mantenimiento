<%@ page import="bitacora.ModuloSistema; bitacora.Empresa" %>

<g:form class="form-horizontal" name="frmActividad" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${actividad?.id}" />

    <div class="form-group ${hasErrors(bean: actividad, field: 'usuario', 'error')} ">
        <span class="grupo">
            <label for="usuarioName" class="col-md-2 control-label text-info">
                Usuario
            </label>
            <span class="col-md-7">
                <g:hiddenField name="usuario" value="${actividad?.usuario?.id}" />
                <g:textField name="usuarioName" readonly="" required="" class="form-control required" value="${(actividad?.usuario?.apellido ?: '') + " " + (actividad?.usuario?.nombre ?: '')}"/>
            </span>
            <span class="col-md-1">
                <g:if test="${!actividad?.id}">
                    <a class="btn btn-info btnBuscarUsuarioActividad" href="#"  title="Seleccionar usuario">
                        <i class="fa fa-search"></i>
                    </a>
                </g:if>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'periodo', 'error')} required">
        <span class="grupo">
            <label for="periodo" class="col-md-2 control-label text-info">
                Período
            </label>
            <span class="col-md-9">
                <g:select name="periodo" from="${bitacora.Periodo.list()?.sort{it.numero}}" required="" class="form-control required" optionKey="id"
                          optionValue="${{it.fechads?.format("dd-MM-yyyy") + " - " + it.fechahs?.format("dd-MM-yyyy")}}" value="${actividad?.periodo?.id}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'tipoMantenimiento', 'error')} ">
        <span class="grupo">
            <label for="tipoMantenimiento" class="col-md-2 control-label text-info">
                Tipo de mantenimiento
            </label>
            <span class="col-md-9">
                <g:select name="tipoMantenimiento" from="${bitacora.TipoMantenimiento.list().sort{it.descripcion}}" required="" class="form-control required" optionKey="id"
                          optionValue="${{it.descripcion}}" value="${actividad?.tipoMantenimiento?.id}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'moduloSistema', 'error')} ">
        <span class="grupo">
            <label for="moduloSistema" class="col-md-2 control-label text-info">
                Módulo del sistema
            </label>
            <span class="col-md-9">
                <g:select name="moduloSistema" from="${bitacora.ModuloSistema.list().sort{it.descripcion}}" required="" class="form-control required" optionKey="id"
                          optionValue="${{it.descripcion}}" value="${actividad?.moduloSistema?.id}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'requerimiento', 'error')} required">
        <span class="grupo">
            <label for="requerimiento" class="col-md-2 control-label text-info">
                Requerimiento
            </label>
            <span class="col-md-9">
                <g:textField name="requerimiento" minlength="3" maxlength="15" required="" class="form-control required" value="${actividad?.requerimiento}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'fecha', 'error')} required">
        <span class="grupo">
            <label for="datetimepicker2" class="col-md-2 control-label text-info">
                Fecha
            </label>
            <span class="col-md-9">
                <span class="grupo">
                    <input name="fecha" id='datetimepicker2' type='text' class="form-control" value="${actividad?.fecha?.format("dd-MM-yyyy HH:mm") ?: new java.util.Date()?.format("dd-MM-yyyy HH:mm")}"/>
                </span>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="col-md-9">
                <g:textArea name="descripcion" minlength="3" maxlength="1024"  class="form-control" value="${actividad?.descripcion}"  style="resize: none; height: 100px"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'algoritmo', 'error')} ">
        <span class="grupo">
            <label for="algoritmo" class="col-md-2 control-label text-info">
                Algoritmo
            </label>
            <span class="col-md-9">
                <g:textArea name="algoritmo" minlength="3" maxlength="1024"  class="form-control" value="${actividad?.algoritmo}"  style="resize: none; height: 100px"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'clave', 'error')} ">
        <span class="grupo">
            <label for="clave" class="col-md-2 control-label text-info">
                Clave
            </label>
            <span class="col-md-9">
                <g:textField name="clave" minlength="3" maxlength="63"  class="form-control" value="${actividad?.clave}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">

    $(function () {
        $('#datetimepicker2').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY HH:mm',
            showClose: true,
            icons: {
                close: 'cerrar'
            }
        });
    });

    $(".btnBuscarUsuarioActividad").click(function () {
        buscarUsuario(1);
    });

    var validator = $("#frmActividad").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });

</script>

