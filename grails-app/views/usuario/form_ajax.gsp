<asset:javascript src="/Toggle-Button-Checkbox/js/bootstrap-checkbox.js"/>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmUsuario" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${usuario?.id}"/>

        <div class="form-group keeptogether ${hasErrors(bean: usuario, field: 'empresa', 'error')} required">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="empresa" class="col-md-4 control-label">
                        Empresa
                    </label>
                </span>
                <div class="col-md-8">
                    <g:select name="empresa" from="${bitacora.Empresa.list().sort{it.nombre}}" class="form-control" optionKey="id" optionValue="nombre" value="${usuario?.empresa?.id}"/>
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuario, field: 'cedula', 'error')} required">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="cedula" class="col-md-4 control-label">
                        Cédula
                    </label>
                </span>
                <div class="col-md-8">
                    <g:textField name="cedula" minlength="10" maxlength="10" required="" class="form-control input-sm unique noEspacios required" value="${usuario?.cedula}"/>
                </div>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="sexo" class="col-md-4 control-label">
                        Sexo
                    </label>
                    <span class="col-md-8">
                        <g:select name="sexo" from="${['F': 'Femenino', 'M': 'Masculino']}" required="" optionKey="key" optionValue="value"
                                  class="form-control input-sm required" value="${usuario?.sexo}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuario, field: 'nombre', 'error')} ${hasErrors(bean: usuario, field: 'apellido', 'error')} required">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="nombre" class="col-md-4 control-label">
                        Nombre
                    </label>

                    <span class="col-md-8">
                        <g:textField name="nombre" minlength="3" maxlength="30" required="" class="form-control input-sm required" value="${usuario?.nombre}"/>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="apellido" class="col-md-4 control-label">
                        Apellido
                    </label>

                    <span class="col-md-8">
                        <g:textField name="apellido" minlength="3" maxlength="30" required="" class="form-control input-sm required" value="${usuario?.apellido}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuario, field: 'mail', 'error')} ${hasErrors(bean: usuario, field: 'telefono', 'error')} ">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="mail" class="col-md-4 control-label">
                        E-mail
                    </label>

                    <span class="col-md-8">
                        <span class="input-group input-group-sm"><span class="input-group-addon"><i class="fa fa-envelope"></i>
                        </span><g:field type="email" name="mail" minlength="5" maxlength="63" class="form-control input-sm unique noEspacios" value="${usuario?.mail}"/>
                        </span>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="telefono" class="col-md-4 control-label">
                        Teléfono
                    </label>

                    <span class="col-md-8">
                        <g:textField name="telefono" maxlength="31" class="form-control input-sm required" value="${usuario?.telefono}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: usuario, field: 'titulo', 'error')} ${hasErrors(bean: usuario, field: 'activo', 'error')}">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="titulo" class="col-md-4 control-label">
                        Título
                    </label>
                    <span class="col-md-8">
                        <g:textField name="titulo" minlength="1" maxlength="4" class="form-control input-sm" value="${usuario?.titulo}"/>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="activo" class="col-md-4 control-label">
                        Activo
                    </label>
                    <span class="col-md-8">
                        <g:checkBox name="activoName" id="activo" class="form-control" data-on-Label="Si" checked="${usuario.activo == '1' ?: false}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group ${hasErrors(bean: usuario, field: 'fechaInicio', 'error')} ">
            <span class="grupo">
                <label for="datetimepicker1" class="col-md-2 control-label">
                    Fecha de inicio
                </label>
                <span class="col-md-4">
                    <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control" value="${usuario?.fechaInicio?.format("dd-MM-yyyy") ?: new Date()?.format("dd-MM-yyyy")  }"/>
                </span>
            </span>

            <span class="grupo">
                <label for="datetimepicker2" class="col-md-2 control-label">
                    Fecha de finalización
                </label>
                <span class="col-md-4" style="font-size: 14px">
                    <input name="fechaFin" id='datetimepicker2' type='text' class="form-control" value="${usuario?.fechaFin?.format("dd-MM-yyyy") ?: new Date()?.format("dd-MM-yyyy")}"/>
                </span>
            </span>
        </div>
    </g:form>
</div>

<script type="text/javascript">

    function validarNum(ev) {
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }

    $("#cedula, #telefono").keydown(function (ev) {
        return validarNum(ev);
    });

    $(function () {
        $('#datetimepicker1').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'cerrar'
            }
        });

        $('#datetimepicker2').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'cerrar'
            }
        });
    });

    $(function() {
        $("#activo").checkboxpicker({
        });
    });

    var validator = $("#frmUsuario").validate({
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
            submitFormUsuario();
            return false;
        }
        return true;
    });

</script>

