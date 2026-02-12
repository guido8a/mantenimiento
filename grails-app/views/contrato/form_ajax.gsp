<g:form class="form-horizontal" name="frmContrato" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${contrato?.id}" />

    <div class="form-group keeptogether ${hasErrors(bean: contrato, field: 'empresa', 'error')} required">
            <span class="grupo">
                <label for="empresa" class="col-md-2 control-label text-info">
                    Empresa
                </label>
            </span>
            <div class="col-md-10">
                <g:select name="empresa" from="${bitacora.Empresa.list().sort{it.nombre}}" class="form-control" optionValue="nombre" optionKey="id" value="${contrato?.empresa?.id}"/>
            </div>
    </div>

    <div class="form-group ${hasErrors(bean: contrato, field: 'numero', 'error')} required">
        <span class="grupo">
            <label for="numero" class="col-md-2 control-label text-info">
                Número
            </label>
            <span class="col-md-10">
                <g:textField name="numero" minlength="1" maxlength="20" required="" class="form-control required" value="${contrato?.numero}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: contrato, field: 'objeto', 'error')} ">
        <span class="grupo">
            <label for="objeto" class="col-md-2 control-label text-info">
                Objeto
            </label>
            <span class="col-md-10">
                <g:textArea name="objeto" maxlength="255"  class="form-control" value="${contrato?.objeto}"  style="resize: none; height: 150px"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: contrato, field: 'fechaSubscripcion', 'error')} required">
        <span class="grupo">
            <label for="datetimepicker3" class="col-md-2 control-label text-info">
                Fecha Subscripción
            </label>
            <span class="col-md-4">
                <input name="fechaSubscripcion" id='datetimepicker3' type='text' class="form-control required" value="${contrato?.fechaSubscripcion?.format("dd-MM-yyyy") ?: new java.util.Date()?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: contrato, field: 'fechaInicio', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker1" class="col-md-2 control-label text-info">
                Fecha de inicio
            </label>
            <span class="col-md-4">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control" value="${contrato?.fechaInicio?.format("dd-MM-yyyy")}"/>
            </span>
        </span>

        <span class="grupo">
            <label for="datetimepicker2" class="col-md-2 control-label text-info">
                Fecha de finalización
            </label>
            <span class="col-md-4" style="font-size: 14px">
                <input name="fechaFin" id='datetimepicker2' type='text' class="form-control" value="${contrato?.fechaFin?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">

    $(function () {
        $('#datetimepicker1, #datetimepicker2, #datetimepicker3').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'cerrar'
            }
        });
    });

    var validator = $("#frmContrato").validate({
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

