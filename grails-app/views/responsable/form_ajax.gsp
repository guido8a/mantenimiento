<g:form class="form-horizontal" name="frmResponsable" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${responsable?.id}" />

    <div class="form-group keeptogether ${hasErrors(bean: responsable, field: 'contrato', 'error')} required">
        <span class="grupo">
            <label for="contrato" class="col-md-2 control-label text-info">
                Contrato
            </label>
        </span>
        <div class="col-md-10">
            <g:select name="contrato" from="${bitacora.Contrato.list().sort{it.numero}}" required="" class="form-control required"
                      optionValue="${{it.numero + " - " + it.objeto}}" optionKey="id" value="${responsable?.contrato?.id}"/>
        </div>
    </div>

    <div class="form-group ${hasErrors(bean: responsable, field: 'nombre', 'error')} required">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <span class="col-md-10">
                <g:textField name="nombre" minlength="3" maxlength="31" required="" class="form-control required" value="${responsable?.nombre}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: responsable, field: 'apellido', 'error')} required">
        <span class="grupo">
            <label for="apellido" class="col-md-2 control-label text-info">
                Apellido
            </label>
            <span class="col-md-10">
                <g:textField name="apellido" minlength="3" maxlength="31" required="" class="form-control required" value="${responsable?.apellido}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: responsable, field: 'titulo', 'error')} required">
        <span class="grupo">
            <label for="titulo" class="col-md-2 control-label text-info">
                Título
            </label>
            <span class="col-md-10">
                <g:textField name="titulo" minlength="3" maxlength="31" required="" class="form-control required" value="${responsable?.titulo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: responsable, field: 'cargo', 'error')} ">
        <span class="grupo">
            <label for="cargo" class="col-md-2 control-label text-info">
                Cargo
            </label>
            <span class="col-md-10">
                <g:textField name="cargo" minlength="3" maxlength="127" class="form-control " value="${responsable?.cargo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: responsable, field: 'departamento', 'error')} ">
        <span class="grupo">
            <label for="departamento" class="col-md-2 control-label text-info">
                Departamento
            </label>
            <span class="col-md-10">
                <g:textField name="departamento" minlength="3" maxlength="127"  class="form-control " value="${responsable?.departamento}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: responsable, field: 'mail', 'error')} ">
        <span class="grupo">
            <label for="mail" class="col-md-2 control-label text-info">
                Mail
            </label>
            <span class="col-md-10">
                <g:textField name="mail" minlength="3" maxlength="63"  class="form-control email" value="${responsable?.mail}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: responsable, field: 'telefono', 'error')} ">
        <span class="grupo">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <span class="col-md-10">
                <g:textField name="telefono" minlength="3" maxlength="31"  class="form-control" value="${responsable?.telefono}"/>
            </span>
        </span>
    </div>

    <div class="form-group keeptogether ${hasErrors(bean: responsable, field: 'sexo', 'error')} ">
        <span class="grupo">
            <label for="sexo" class="col-md-2 control-label text-info">
                Sexo
            </label>
            <span class="col-md-4">
                <g:select name="sexo" from="${['F': 'Femenino', 'M': 'Masculino']}" optionKey="key" optionValue="value"
                          class="form-control input-sm" value="${responsable?.sexo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: responsable, field: 'fechaInicio', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker1" class="col-md-2 control-label text-info">
                Fecha de inicio
            </label>
            <span class="col-md-4">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control" value="${responsable?.fechaInicio?.format("dd-MM-yyyy")}"/>
            </span>
        </span>

        <span class="grupo">
            <label for="datetimepicker2" class="col-md-2 control-label text-info">
                Fecha de finalización
            </label>
            <span class="col-md-4" style="font-size: 14px">
                <input name="fechaFin" id='datetimepicker2' type='text' class="form-control" value="${responsable?.fechaFin?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">

    $(function () {
        $('#datetimepicker1, #datetimepicker2').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'cerrar'
            }
        });
    });

    var validator = $("#frmResponsable").validate({
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

