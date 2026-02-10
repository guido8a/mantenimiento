<%@ page import="bitacora.Empresa" %>

<g:form class="form-horizontal" name="frmPeriodo" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${periodo?.id}" />

    <div class="form-group ${hasErrors(bean: periodo, field: 'numero', 'error')} ">
        <span class="grupo">
            <label for="numero" class="col-md-3 control-label text-info">
                Número
            </label>
            <span class="col-md-8">
                <g:textField name="numero" minlength="1" maxlength="15" required="" class="form-control required" value="${periodo?.numero}"/>
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: periodo, field: 'fechads', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker1" class="col-md-3 control-label text-info">
                Fecha de inicio
            </label>
            <span class="col-md-8">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control required" required="" value="${periodo?.fechads?.format("dd-MM-yyyy") ?: new java.util.Date().format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: periodo, field: 'fechahs', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker2" class="col-md-3 control-label text-info">
                Fecha de finalización
            </label>
            <span class="col-md-8" style="font-size: 14px">
                <input name="fechaFin" id='datetimepicker2' type='text' class="form-control required" required="" value="${periodo?.fechahs?.format("dd-MM-yyyy") ?: new java.util.Date().format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">


    function validarNum(ev) {
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }

    $("#numero").keydown(function (ev) {
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

    var validator = $("#frmPeriodo").validate({
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

