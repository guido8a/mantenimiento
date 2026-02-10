<table class="table table-bordered table-striped table-hover table-condensed" id="tabla" style="width: 100%; background-color: #a39e9e">
    <thead>
    <tr style="text-align: center">
        <th style="width: 100%">Datos de la actividad</th>
    </tr>
    </thead>
</table>
<g:if test="${actividad}">
    <div class="" style="width: 99.7%; height: 500px; overflow-y: auto;float: right;">
        <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%; font-size: 14px">
            <tr style="width: 100%">
                <td style="width: 100%">
                    <div class="form-group">
                        <span class="grupo">
                            <span class="col-md-12">
                                <label>Requerimiento</label>
                                <g:textField name="usuarioVer" readonly="" class="form-control" value="${actividad?.requerimiento}"/>
                            </span>
                        </span>
                    </div>
                    <div class="form-group">
                        <span class="grupo">
                            <span class="col-md-12">
                                <label>Algoritmo</label>
                                <g:textArea name="algoritmoVer" readonly="" class="form-control" value="${actividad?.algoritmo ?: ''}" style="resize: none; height: 150px"/>
                            </span>
                        </span>
                    </div>
                    <div class="form-group">
                        <span class="grupo">
                            <span class="col-md-12">
                                <label>Descripción</label>
                                <g:textArea name="descripcionVer" readonly="" class="form-control" value="${actividad?.descripcion ?: ''}" style="resize: none; height: 150px"/>
                            </span>
                        </span>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</g:if>
<g:else>
    <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Seleccione una actividad</div>
</g:else>