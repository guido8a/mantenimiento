<g:form class="form-horizontal" name="frmOficio" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${oficio?.id}" />

    <div class="form-group keeptogether ${hasErrors(bean: oficio, field: 'contrato', 'error')} required">
        <span class="grupo">
            <label for="contrato" class="col-md-2 control-label text-info">
                Contrato
            </label>
        </span>
        <div class="col-md-10">
            <g:select name="contrato" from="${bitacora.Contrato.list().sort{it.numero}}" required="" class="form-control required"
                      optionValue="${{it.numero + " - " + it.objeto}}" optionKey="id" value="${oficio?.contrato?.id}"/>
        </div>
    </div>

    <div class="form-group ${hasErrors(bean: oficio, field: 'periodo', 'error')} required">
        <span class="grupo">
            <label for="periodo" class="col-md-2 control-label text-info">
                Período
            </label>
            <span class="col-md-9">
                <g:select name="periodo" from="${bitacora.Periodo.list()?.sort{it.numero}}" required="" class="form-control required" optionKey="id"
                          optionValue="${{it.fechads?.format("dd-MM-yyyy") + " - " + it.fechahs?.format("dd-MM-yyyy")}}" value="${oficio?.periodo?.id}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: oficio, field: 'numero', 'error')} required">
        <span class="grupo">
            <label for="numero" class="col-md-2 control-label text-info">
                Número
            </label>
            <span class="col-md-10">
                <g:textField name="numero" minlength="1" maxlength="31" required="" class="form-control required" value="${oficio?.numero}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: oficio, field: 'fecha', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker1" class="col-md-2 control-label text-info">
                Fecha
            </label>
            <span class="col-md-4">
                <input name="fecha" id='datetimepicker1' type='text' class="form-control" value="${oficio?.fecha?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>

    <div class="card">
        <textarea id="texto" class="editor" rows="100" cols="80">${oficio.texto}</textarea>
    </div>
</g:form>

<script type="text/javascript">

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

