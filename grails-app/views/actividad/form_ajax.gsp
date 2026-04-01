<%@ page import="bitacora.ModuloSistema; bitacora.Empresa" %>

<g:form class="form-horizontal" name="frmActividad" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${actividad?.id}" />

    <div class="form-group ${hasErrors(bean: actividad, field: 'usuario', 'error')} ">
        <span class="grupo">
            <label for="usuarioName" class="col-md-1 control-label text-info">
                Usuario
            </label>
            <span class="col-md-8">
                <g:hiddenField name="usuario" value="${actividad?.usuario?.id}" />
                <g:textField name="usuarioName" readonly="" required="" class="form-control required"
                             value="${(actividad?.usuario?.apellido ?: '') + " " + (actividad?.usuario?.nombre ?: '')}"/>
            </span>
            <span class="col-md-3">
                <g:if test="${!actividad?.id}">
                    <a class="btn btn-info btnBuscarUsuarioActividad" href="#"  title="Seleccionar usuario">
                        <i class="fa fa-search"></i>
                    </a>
                    <a class="btn btn-warning btnCrearUsuarioActividad" href="#"  title="Crear usuario">
                        <i class="fa fa-user"></i>
                    </a>
                </g:if>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'periodo', 'error')} required">
        <div class="col-md-1"></div>
        <span class="grupo">
            <span class="col-md-3">
                <label for="contrato" class="control-label text-info">
                    Contrato
                </label>
                <g:select name="contrato" from="${contratos}" required="" class="form-control required" optionKey="id"
                          optionValue="numero" value="${actividad?.periodo?.contrato?.id?:contrato}"/>
            </span>
        </span>
        <span class="grupo">
            <span class="col-md-3" id="divPeriodo">

            </span>
        </span>
        <span class="grupo">
            <span class="col-md-3">
                <label for="datetimepicker2" class="control-label text-info">
                    Fecha
                </label>
                <span class="grupo">
                    <input name="fecha" id='datetimepicker2' type='text' class="form-control"
                           value="${actividad?.fecha?.format("dd-MM-yyyy HH:mm") ?: new java.util.Date()?.format("dd-MM-yyyy HH:mm")}"/>
                </span>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'tipoMantenimiento', 'error')} ">
        <div class="col-md-1"></div>
        <span class="grupo">
            <span class="col-md-3">
                <label for="moduloSistema" class="control-label text-info">
                    Módulo del sistema
                </label>
                <g:select name="moduloSistema" from="${bitacora.ModuloSistema.list().sort{it.descripcion}}" required="" class="form-control required" optionKey="id"
                          optionValue="${{it.descripcion}}" value="${actividad?.moduloSistema?.id}"/>
            </span>
        </span>
        <span class="grupo">
            <span class="col-md-3">
                <label for="tipoMantenimiento" class="control-label text-info">
                    Tipo de mantenimiento
                </label>
                <g:select name="tipoMantenimiento" from="${bitacora.TipoMantenimiento.list().sort{it.descripcion}}"
                          required="" class="form-control required" optionKey="id"
                          optionValue="${{it.descripcion}}" value="${actividad?.tipoMantenimiento?.id}"/>
            </span>
        </span>
        <span class="grupo">
            <span class="col-md-3">
                <label for="requerimiento" class="control-label text-info">
                    Requerimiento número
                </label>
                <g:textField name="requerimiento" minlength="3" maxlength="15" required="" class="form-control
                required" value="${actividad?.requerimiento}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'clave', 'error')} ">
        <span class="grupo">
            <label for="clave" class="col-md-1 control-label text-info">
                Palabras Clave
            </label>
            <span class="col-md-11">
                <g:textField name="clave" minlength="3" maxlength="63" required=""  class="form-control required" value="${actividad?.clave}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'descripcion', 'error')}">
        <label for="descripcion" class="col-md-1 control-label text-info">
            Descripción
        </label>
        <span class="grupo">
            <span class="col-md-11">
                <g:textArea name="descripcion" class="form-control"  value="${actividad?.descripcion}" style="resize: none; height: 120px"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: actividad, field: 'algoritmo', 'error')}">
        <label for="algoritmo" class="col-md-1 control-label text-info">
            Algoritmo
        </label>
        <span class="grupo">
            <span class="col-md-12">
                <textarea id="algoritmo" class="editor" rows="60" cols="80">${actividad?.algoritmo}</textarea>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $(".btnCrearUsuarioActividad").click(function () {
        location.href="${createLink(controller: 'usuario', action: 'list')}"
    });

    cargarPeriodos();

    $("#contrato").change(function () {
        cargarPeriodos()
    });

    function cargarPeriodos(){
        $.ajax({
            type: 'POST',
            url :'${createLink(controller: 'actividad', action: 'periodoForm_ajax')}',
            data: {
                contrato: $("#contrato option:selected").val(),
                actividad: '${actividad?.id}'
            },
            success: function (msg) {
                $("#divPeriodo").html(msg)
            }
        });
    }

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

    // CKEDITOR.replace( 'descripcion', {
    //     height: "120px",
    //     toolbar                 : [
    //         ['Font', 'FontSize', 'Scayt', '-'],
    //         ['Table', 'HorizontalRule', 'PageBreak'],
    //         [ '-', 'TextColor', 'BGColor', '-'],
    //         ['Bold', 'Italic', 'Underline', /*'Strike', */'Subscript', 'Superscript'/*, '-', 'RemoveFormat'*/],
    //         ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'link']
    //     ]
    // });

    CKEDITOR.replace( 'algoritmo', {
        height: "140px",
        toolbar                 : [
            ['Font', 'FontSize', 'Scayt', '-', 'Undo', 'Redo'],
//            ['Find', 'Replace', '-', 'SelectAll'],
            ['HorizontalRule'],
            [ '-', 'TextColor', 'BGColor', '-', 'About'],
//            '/',
            ['Bold', 'Italic', 'Underline', /*'Strike', */'Subscript', 'Superscript'/*, '-', 'RemoveFormat'*/],
            ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-']
        ]
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

