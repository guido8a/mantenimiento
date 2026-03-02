<div class="row">
    <div class="col-md-12">
        <div style="overflow: hidden">
            <fieldset class="borde" style="border-radius: 4px">
                <div style="margin-left: 10px">
                    <span class="grupo">
                        <span class="col-md-2">
                            <label class="control-label text-info" style="font-size: 14px">Contrato</label>
                        </span>
                        <span class="col-md-4">
                            <g:select name="contrato" class="col-md-12 form-control" from="${bitacora.Contrato.list().sort{it.numero}}" optionKey="id"
                                      optionValue="numero" noSelection="[null : 'TODOS']"/>
                        </span>
                    </span>
                </div>
            </fieldset>
        </div>
    </div>

    <div class="col-md-12" id="divPeriodos" style="margin-top: 20px">
    </div>
</div>

<script type="text/javascript">

    $("#contrato").change(function () {
        cargarTablaPeriodos();
    });

    cargarTablaPeriodos();

    $("#btnCrearPeriodo").click(function () {
        createEditPeriodo();
    });

    function cargarTablaPeriodos(){
        var c = cargarLoader("Cargando...");
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'actividad', action: 'tablaPeriodos_ajax')}",
            data    : {
                contrato: $("#contrato option:selected").val()
            },
            success : function (msg) {
                c.modal("hide");
                $("#divPeriodos").html(msg);
            },
            error   : function (msg) {
                c.modal("hide");
                $("#divPeriodos").html("Ha ocurrido un error");
            }
        });
    }

</script>
