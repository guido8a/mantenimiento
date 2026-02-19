<g:form class="form-horizontal" name="frmTipo" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${tipo?.id}" />

    <div class="form-group ${hasErrors(bean: tipo, field: 'codigo', 'error')} required">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>
            <span class="col-md-3">
                <g:textField name="codigo" minlength="1" maxlength="2" required="" oninput="this.value = this.value.toUpperCase();" class="form-control allCaps required" value="${tipo?.codigo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tipo, field: 'descripcion', 'error')} required">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="col-md-10">
                <g:textField name="descripcion" minlength="1" maxlength="63" required="" class="form-control required" value="${tipo?.descripcion}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">

    var validator = $("#frmTipo").validate({
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