<g:form class="form-horizontal" name="frmOficio" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${oficio?.id}" />

    <div class="form-group keeptogether ${hasErrors(bean: oficio, field: 'contrato', 'error')} required">
        <span class="grupo">
            <label for="contrato" class="col-md-2 control-label text-info">
                Contrato
            </label>
        </span>
        <div class="col-md-3">
            <g:select name="contrato" from="${bitacora.Contrato.list().sort{it.numero}}" required="" class="form-control required"
                      optionValue="${{it.numero}}" optionKey="id" value="${oficio?.contrato?.id}"/>
        </div>
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Período
            </label>
            <span class="col-md-3" id="divPeriodos">
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: oficio, field: 'numero', 'error')} ${hasErrors(bean: oficio, field: 'fecha', 'error')} required">
        <span class="grupo">
            <label for="numero" class="col-md-2 control-label text-info">
                Número
            </label>
            <span class="col-md-3">
                <g:textField name="numero" minlength="1" maxlength="31" required="" class="form-control required" value="${oficio?.numero}"/>
            </span>
        </span>
        <span class="grupo">
            <label for="datetimepicker1" class="col-md-2 control-label text-info">
                Fecha
            </label>
            <span class="col-md-3">
                <input name="fecha" id='datetimepicker1' type='text' class="form-control" value="${oficio?.fecha?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>

    <div class="card">
        <textarea id="texto" class="editor" rows="100" cols="80">${oficio.texto}</textarea>
    </div>
</g:form>

<script type="text/javascript">

    cargarPeriodos();

    $("#contrato").change(function () {
        cargarPeriodos()
    });

    function cargarPeriodos(){
        $.ajax({
            type: 'POST',
            url :'${createLink(controller: 'oficio', action: 'periodo_ajax')}',
            data: {
                contrato: $("#contrato option:selected").val(),
                oficio: '${oficio?.id}'
            },
            success: function (msg) {
                $("#divPeriodos").html(msg)
            }
        });
    }

    $(function () {
        $('#datetimepicker1').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'cerrar'
            }
        });
    });

    var validator = $("#frmOficio").validate({
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

    CKEDITOR.replace( 'texto', {
        height: "400px",
        toolbar                 : [
            ['Font', 'FontSize', 'Scayt', '-', 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo'],
            ['Find', 'Replace', '-', 'SelectAll'],
            ['Table', 'HorizontalRule', 'PageBreak'],
            [ '-', 'TextColor', 'BGColor', '-', 'About'],
            '/',
            ['Bold', 'Italic', 'Underline', /*'Strike', */'Subscript', 'Superscript'/*, '-', 'RemoveFormat'*/],
            ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-']
        ]
    });

</script>

