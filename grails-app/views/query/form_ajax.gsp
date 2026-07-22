<g:form class="form-horizontal" name="frmQuery" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${query?.id}" />

    <div class="form-group ${hasErrors(bean: query, field: 'sistema', 'error')} ">
        <span class="grupo">
            <label for="sistema" class="col-md-1 control-label text-info">
                Sistema
            </label>
            <span class="col-md-11">
                <g:select name="sistema" from="${bitacora.Sistema.list().sort{it.nombre}}" required="" class="form-control required" optionKey="id"
                          optionValue="nombre" value="${query?.sistema?.id}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: query, field: 'fecha', 'error')} required">
        <span class="grupo">
            <label for="datetimepicker2" class="col-md-1 control-label text-info">
                Fecha
            </label>
            <span class="col-md-3">
                <input name="fecha" id='datetimepicker2' type='text' class="form-control"
                       value="${query?.fecha?.format("dd-MM-yyyy ") ?: new java.util.Date()?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: query, field: 'problema', 'error')}">
        <label for="problema" class="col-md-1 control-label text-info">
            Problema
        </label>
        <span class="grupo">
            <span class="col-md-11">
                <g:textArea name="problema" class="form-control required"  required="" value="${query?.problema}" style="resize: none; height: 120px"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: query, field: 'algoritmo', 'error')}">
        <label for="algoritmo" class="col-md-1 control-label text-info">
            Algoritmo
        </label>
        <span class="grupo">
            <span class="col-md-11">
%{--                <textarea id="algoritmo" class="editor" rows="60" cols="80">${query?.algoritmo}</textarea>--}%
                <g:textArea name="algoritmo" class="form-control required"  value="${query?.algoritmo}" required="" style="resize: none; height: 120px"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: query, field: 'clave', 'error')} ">
        <span class="grupo">
            <label for="clave" class="col-md-1 control-label text-info">
                Palabras Clave
            </label>
            <span class="col-md-11">
                <g:textField name="clave" minlength="3" maxlength="63"  class="form-control " value="${query?.clave}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: query, field: 'referencia', 'error')} ">
        <span class="grupo">
            <label for="referencia" class="col-md-1 control-label text-info">
                Referencias
            </label>
            <span class="col-md-11">
                <g:textField name="referencia" minlength="3" maxlength="255"  class="form-control " value="${query?.referencia}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">


    $(function () {
        $('#datetimepicker2').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'cerrar'
            }
        });
    });


    // CKEDITOR.replace( 'descripcion', {
    //     height: "120px",
    //     toolbar                 : [
    //         ['Font', 'FontSize', 'Scayt', '-'],
    //         ['Table', 'HorizontalRule', 'PageBreak'],
    //         [ '-', 'TextColor', 'BGColor', '-'],
    //         ['Bold', 'Italic', 'Underline', /*'Strike', */'Subscript', 'Superscript'/*, '-', 'RemoveFormat'*/],
    //         ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'link']
    //     ]
    // });

    // CKEDITOR.replace( 'algoritmo', {
    //     height: "140px",
    //     toolbar                 : [
    //         ['Font', 'FontSize', 'Scayt', '-', 'Undo', 'Redo'],
    //         ['HorizontalRule'],
    //         [ '-', 'TextColor', 'BGColor', '-', 'About'],
    //         ['Bold', 'Italic', 'Underline', /*'Strike', */'Subscript', 'Superscript'/*, '-', 'RemoveFormat'*/],
    //         ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-']
    //     ]
    // });


    var validator = $("#frmQuery").validate({
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

