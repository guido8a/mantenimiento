<%@ page import="bitacora.Empresa" %>

<g:form class="form-horizontal" name="frmEmpresa" role="form" action="save_ajax" method="POST" useToken="true">
    <g:hiddenField name="id" value="${empresa?.id}" />

    <div class="form-group ${hasErrors(bean: empresa, field: 'ruc', 'error')} ">
        <span class="grupo">
            <label for="ruc" class="col-md-2 control-label text-info">
                RUC
            </label>
            <span class="col-md-4">
                <g:textField name="ruc" minlength="10" maxlength="13" required="" class="form-control required" value="${empresa?.ruc}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'nombre', 'error')} ">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <span class="col-md-8">
                <g:textField name="nombre" maxlength="255" required="" class="form-control required" value="${empresa?.nombre}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'ruc', 'error')} ">

        <span class="grupo">
            <label for="sigla" class="col-md-2 control-label text-info">
                Sigla
            </label>
            <span class="col-md-4">
                <g:textField name="sigla" maxlength="7" class="form-control" value="${empresa?.sigla}"/>
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: empresa, field: 'direccion', 'error')} ">
        <span class="grupo">
            <label for="direccion" class="col-md-2 control-label text-info">
                Dirección
            </label>
            <span class="col-md-8">
                <g:textArea name="direccion" maxlength="255" required="" class="form-control" value="${empresa?.direccion}" style="resize: none;"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'telefono', 'error')} ">
        <span class="grupo">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <span class="col-md-8">
                <g:textField name="telefono" minlength="3" maxlength="63" class="form-control number" value="${empresa?.telefono}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'mail', 'error')} ">
        <span class="grupo">
            <label for="mail" class="col-md-2 control-label text-info">
                Mail
            </label>
            <span class="col-md-8">
                <g:textField name="mail" minlength="5" maxlength="63"  class="form-control email" value="${empresa?.mail}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'observaciones', 'error')} ">
        <span class="grupo">
            <label for="observaciones" class="col-md-2 control-label text-info">
                Observaciones
            </label>
            <span class="col-md-8">
                <g:textArea name="observaciones" maxlength="255"  class="form-control" value="${empresa?.observaciones}"  style="resize: none;"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'fechaInicio', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker1" class="col-md-2 control-label text-info">
                Fecha de inicio
            </label>
            <span class="col-md-4">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control" value="${empresa?.fechaInicio?.format("dd-MM-yyyy")}"/>
            </span>
        </span>

        <span class="grupo">
            <label for="datetimepicker2" class="col-md-2 control-label text-info">
                Fecha de finalización
            </label>
            <span class="col-md-4" style="font-size: 14px">
                <input name="fechaFin" id='datetimepicker2' type='text' class="form-control" value="${empresa?.fechaFin?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">


    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }

    $("#ruc, #telefono").keydown(function (ev) {
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

    var validator = $("#frmEmpresa").validate({
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

