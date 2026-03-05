<%@ page import="bitacora.Area" %>
<g:form class="form-horizontal" name="frmArea" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${area?.id}" />

    <div class="form-group ${hasErrors(bean: area, field: 'padre', 'error')} ">
        <span class="grupo">
            <label for="padre" class="col-md-2 control-label text-info">
                Área padre
            </label>
            <span class="col-md-7">
                <g:select name="padre" from="${bitacora.Area.list().sort{it.nombre}}" value="${area?.padre?.id}" optionValue="nombre" optionKey="id" class="form-control" noSelection="[null : 'Sin área padre']" />
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: area, field: 'nombre', 'error')} ">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <span class="col-md-7">
                <g:textField name="nombre" minlength="3" maxlength="127" required="" class="form-control required" value="${area?.nombre}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    var validator = $("#frmArea").validate({
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

