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
                    <label for="usuario" class="col-md-4 control-label">
                        Usuario
                    </label>
                </span>
                <div class="col-md-8">
                    <g:select name="usuario" from="${bitacora.Usuario.list()?.sort{it.apellido}}" class="form-control" optionKey="id" optionValue="${{it.apellido + " " + it.nombre}}" value="${cambio?.usuario?.id}"/>
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'responsable', 'error')} ${hasErrors(bean: cambio, field: 'numero', 'error')}">
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
            <div class="col-md-6">
                <span class="grupo">
                    <label for="datetimepicker1" class="col-md-4 control-label">
                        Fecha
                    </label>
                </span>
                <div class="col-md-8">
                    <input name="fecha" id='datetimepicker1' type='text' class="form-control" value="${cambio?.fecha?.format("dd-MM-yyyy") ?: new Date()?.format("dd-MM-yyyy")  }"/>
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
                    <g:textArea name="descripcion" class="form-control" value="${cambio?.descripcion}" maxlength="255" style="resize: none; height: 80px" />
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
                    <g:textArea name="justificacion" class="form-control" value="${cambio?.justificacion}" maxlength="255" style="resize: none; height: 80px" />
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'impactoConfidencialidad', 'error')} ${hasErrors(bean: cambio, field: 'impactoDisponibilidad', 'error')}">
            <div class="col-md-2"></div>
            <div class="col-md-3">
                <span class="grupo">
                    <span class="col-md-10">
                        <label for="impactoConfidencialidad" class="control-label">
                            Impacto confidencialidad
                        </label>
                        <g:select name="impactoConfidencialidad" class="form-control" from="${['B': 'Bajo', 'M' : 'Medio', 'A' : 'Alto']}" optionKey="key" optionValue="value"
                                  value="${cambio?.impactoConfidencialidad}" />
                    </span>
                </span>
            </div>
            <div class="col-md-3">
                <span class="grupo">
                    <span class="col-md-10">
                        <label for="impactoIntegridad" class="control-label">
                            Impacto Integridad
                        </label>
                        <g:select name="impactoIntegridad" class="form-control" from="${['B': 'Bajo', 'M' : 'Medio', 'A' : 'Alto']}" optionKey="key" optionValue="value"
                                  value="${cambio?.impactoIntegridad}" />
                    </span>
                </span>
            </div>
            <div class="col-md-3">
                <span class="grupo">
                    <span class="col-md-10">
                        <label for="impactoDisponibilidad" class="control-label">
                            Impacto disponibilidad
                        </label>
                        <g:select name="impactoDisponibilidad" class="form-control" from="${['B': 'Bajo', 'M' : 'Medio', 'A' : 'Alto']}" optionKey="key" optionValue="value"
                                  value="${cambio?.impactoDisponibilidad}" />
                    </span>
                </span>
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
                    <g:textArea name="descripcionSeguridad" class="form-control" value="${cambio?.descripcionSeguridad}" maxlength="255" style="resize: none; height: 80px" />
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
                    <g:textArea name="planPruebas" class="form-control" value="${cambio?.planPruebas}" maxlength="255" style="resize: none; height: 80px" />
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
                    <g:textArea name="analisisTecnico" class="form-control" value="${cambio?.analisisTecnico}" maxlength="255" style="resize: none; height: 80px" />
                </div>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: cambio, field: 'impactoIntegridad', 'error')} ${hasErrors(bean: cambio, field: 'aceptado', 'error')}">

            <div class="col-md-6">
                <span class="grupo">
                    <label for="aceptado" class="col-md-4 control-label">
                        Aceptación
                    </label>
                    <span class="col-md-8">
                        <g:checkBox name="aceptadoName" id="aceptado" class="form-control" data-on-Label="Aceptado" data-off-Label="Rechazado" checked="${cambio?.aceptado == '1' ?: false}"/>
                    </span>
                </span>
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
                    <g:textArea name="observaciones" class="form-control" value="${cambio?.observaciones}" maxlength="255" style="resize: none; height: 80px" />
                </div>
            </div>
        </div>
    </g:form>
</div>

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

    $(function() {
        $("#aceptado").checkboxpicker({
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

