<asset:javascript src="/Toggle-Button-Checkbox/js/bootstrap-checkbox.js"/>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmCambio" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${cambio?.id}"/>


        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'responsable', 'error')} ${hasErrors(bean: cambio, field: 'numero', 'error')}">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="responsable" class="col-md-4 control-label">
                        Responsable
                    </label>
                </span>
                <div class="col-md-8">
                    <g:select name="responsable" from="${bitacora.Responsable.list()?.sort{it.apellido}}" class="form-control" optionKey="id" optionValue="${{it.apellido + " " + it.nombre}}" value="${cambio?.responsable?.id}"/>
                </div>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="numero" class="col-md-4 control-label">
                        Número
                    </label>
                </span>
                <div class="col-md-8">
                    <g:textField name="numero" minlength="1" maxlength="20" required="" class="form-control input-sm unique required" value="${cambio?.numero}"/>
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'descripcion', 'error')}">
            <div class="col-md-12">
                <span class="grupo">
                    <label for="descripcion" class="col-md-2 control-label">
                        Descripción
                    </label>
                </span>
                <div class="col-md-10">
                    <g:textArea name="descripcion" class="form-control" value="${cambio?.descripcion}" maxlength="255" style="resize: none" />
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'descripcionSeguridad', 'error')}">
            <div class="col-md-12">
                <span class="grupo">
                    <label for="descripcionSeguridad" class="col-md-2 control-label">
                        Descripción Seguridad
                    </label>
                </span>
                <div class="col-md-10">
                    <g:textArea name="descripcionSeguridad" class="form-control" value="${cambio?.descripcionSeguridad}" maxlength="255" style="resize: none" />
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'justificacion', 'error')}">
            <div class="col-md-12">
                <span class="grupo">
                    <label for="justificacion" class="col-md-2 control-label">
                        Justificación
                    </label>
                </span>
                <div class="col-md-10">
                    <g:textArea name="justificacion" class="form-control" value="${cambio?.justificacion}" maxlength="255" style="resize: none" />
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'planPruebas', 'error')}">
            <div class="col-md-12">
                <span class="grupo">
                    <label for="planPruebas" class="col-md-2 control-label">
                        Plan de pruebas
                    </label>
                </span>
                <div class="col-md-10">
                    <g:textArea name="planPruebas" class="form-control" value="${cambio?.planPruebas}" maxlength="255" style="resize: none" />
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'analisisTecnico', 'error')}">
            <div class="col-md-12">
                <span class="grupo">
                    <label for="analisisTecnico" class="col-md-2 control-label">
                        Análisis técnico
                    </label>
                </span>
                <div class="col-md-10">
                    <g:textArea name="analisisTecnico" class="form-control" value="${cambio?.analisisTecnico}" maxlength="255" style="resize: none" />
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'observaciones', 'error')}">
            <div class="col-md-12">
                <span class="grupo">
                    <label for="observaciones" class="col-md-2 control-label">
                        Observaciones
                    </label>
                </span>
                <div class="col-md-10">
                    <g:textArea name="observaciones" class="form-control" value="${cambio?.observaciones}" maxlength="255" style="resize: none" />
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'impactoConfidencialidad', 'error')} ${hasErrors(bean: cambio, field: 'impactoDisponibilidad', 'error')}">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="impactoConfidencialidad" class="col-md-4 control-label">
                        Impacto confidencialidad
                    </label>
                    <span class="col-md-8">
                        <g:checkBox name="impactoConfidencialidadName" id="impactoConfidencialidad" class="form-control" data-on-Label="Si" checked="${cambio?.impactoConfidencialidad == '1' ?: false}"/>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="impactoDisponibilidad" class="col-md-4 control-label">
                        Impacto disponibilidad
                    </label>
                    <span class="col-md-8">
                        <g:checkBox name="impactoDisponibilidadName" id="impactoDisponibilidad" class="form-control" data-on-Label="Si" checked="${cambio?.impactoDisponibilidad == '1' ?: false}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'impactoIntegridad', 'error')} ${hasErrors(bean: cambio, field: 'aceptado', 'error')}">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="impactoIntegridad" class="col-md-4 control-label">
                        Impacto Integridad
                    </label>
                    <span class="col-md-8">
                        <g:checkBox name="impactoIntegridadName" id="impactoIntegridad" class="form-control" data-on-Label="Si" checked="${cambio?.impactoIntegridad == '1' ?: false}"/>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="aceptado" class="col-md-4 control-label">
                        Aceptación
                    </label>
                    <span class="col-md-8">
                        <g:checkBox name="aceptadoName" id="aceptado" class="form-control" data-on-Label="Si" checked="${cambio?.aceptado == '1' ?: false}"/>
                    </span>
                </span>
            </div>
        </div>
    </g:form>
</div>

<script type="text/javascript">

    // function validarNum(ev) {
    //     return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
    //         (ev.keyCode >= 96 && ev.keyCode <= 105) ||
    //         ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
    //         ev.keyCode === 37 || ev.keyCode === 39);
    // }
    //
    // $("#cedula, #telefono").keydown(function (ev) {
    //     return validarNum(ev);
    // });

    $(function() {
        $("#impactoDisponibilidad, #impactoConfidencialidad, #aceptado, #impactoIntegridad").checkboxpicker({
        });
    });

    var validator = $("#frmCambio").validate({
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

