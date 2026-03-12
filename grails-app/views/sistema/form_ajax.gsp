
<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmSistema" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${sistema?.id}"/>

        <div class="form-group keeptogether ${hasErrors(bean: sistema, field: 'siglas', 'error')} required">
            <div class="col-md-12">
                <span class="grupo">
                    <label for="siglas" class="col-md-2 control-label">
                        Siglas
                    </label>
                </span>
                <div class="col-md-10">
                    <g:textField name="siglas" class="form-control required"  required="" value="${sistema?.siglas}" minlength="1" maxlength="15" />
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: sistema, field: 'nombre', 'error')} required">
            <div class="col-md-12">
                <span class="grupo">
                    <label for="nombre" class="col-md-2 control-label">
                        Nombre
                    </label>
                </span>
                <div class="col-md-10">
                    <g:textArea name="nombre" class="form-control required" required="" value="${sistema?.nombre}" minlength="1" maxlength="255" style="resize: none; height: 100px"  />
                </div>
            </div>
        </div>
    </g:form>
</div>

<script type="text/javascript">

    var validator = $("#frmSistema").validate({
        errorClass    : "help-block",
        errorPlacement: function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success       : function (label) {
            label.parents(".grupo").removeClass('has-error');
            label.remove();
        }
    });

</script>

