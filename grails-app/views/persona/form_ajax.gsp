<asset:javascript src="/Toggle-Button-Checkbox/js/bootstrap-checkbox.js"/>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmPersona" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${personaInstance?.id}"/>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'login', 'error')} required">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="login" class="col-md-4 control-label">
                        Usuario
                    </label>
                </span>
                <div class="col-md-8">
                    <g:textField name="login" minlength="4" maxlength="14" required="" class="form-control input-sm unique noEspacios required" value="${personaInstance?.login}"/>
                </div>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="sexo" class="col-md-4 control-label">
                        Sexo
                    </label>
                    <span class="col-md-8">
                        <g:select name="sexo" from="${['F': 'Femenino', 'M': 'Masculino']}" required="" optionKey="key" optionValue="value"
                                  class="form-control input-sm required" value="${personaInstance?.sexo}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} ${hasErrors(bean: personaInstance, field: 'apellido', 'error')} required">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="nombre" class="col-md-4 control-label">
                        Nombre
                    </label>

                    <span class="col-md-8">
                        <g:textField name="nombre" minlength="3" maxlength="30" required="" class="form-control input-sm required" value="${personaInstance?.nombre}"/>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="apellido" class="col-md-4 control-label">
                        Apellido
                    </label>

                    <span class="col-md-8">
                        <g:textField name="apellido" minlength="3" maxlength="30" required="" class="form-control input-sm required" value="${personaInstance?.apellido}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'mail', 'error')} ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="mail" class="col-md-4 control-label">
                        E-mail
                    </label>

                    <span class="col-md-8">
                        <div class="input-group input-group-sm"><span class="input-group-addon"><i class="fa fa-envelope"></i>
                        </span><g:field type="email" name="mail" minlength="5" maxlength="63" class="form-control input-sm unique noEspacios required" value="${personaInstance?.mail}"/>
                        </div>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="telefono" class="col-md-4 control-label">
                        Teléfono
                    </label>

                    <span class="col-md-8">
                        <g:textField name="telefono" maxlength="31" class="form-control input-sm required" value="${personaInstance?.telefono}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">
            <div class="col-md-12 ">
                <span class="grupo">
                    <label for="cargo" class="col-md-2 control-label">
                        Cargo
                    </label>

                    <span class="col-md-10">
                        <g:textArea name="cargo" cols="80" rows="1" minlength="3" maxlength="250" class="form-control input-sm" value="${personaInstance?.cargo}" style="resize: none"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'sigla', 'error')} ${hasErrors(bean: personaInstance, field: 'activo', 'error')}">
            <div class="col-md-12">
                <span class="grupo">

                    <label for="sigla" class="col-md-2 control-label">
                        Sigla
                    </label>
                    <span class="col-md-2">
                        <g:textField name="sigla" minlength="1" maxlength="4" class="form-control input-sm" value="${personaInstance?.sigla}"/>
                    </span>

                    <label for="activo" class="col-md-2 control-label">
                        Activo
                    </label>
                    <span class="col-md-4">
                        <g:checkBox name="activoName" id="activo" class="form-control" data-on-Label="Si" checked="${personaInstance.activo == '1' ?: false}"/>
                    </span>
                </span>
            </div>
        </div>
    </g:form>
</div>

<script type="text/javascript">

    $(function() {
        $("#activo").checkboxpicker({
        });
    });

    var validator = $("#frmPersona").validate({
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

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            submitFormPersona();
            return false;
        }
        return true;
    });

</script>

