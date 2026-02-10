<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px">
        <div class="row-fluid" style="margin-left: 10px">
            <span class="grupo">
                <span class="col-md-3">
                    <label class="control-label text-info">Buscar Por</label>
                    <g:select name="buscarPorBU" class="buscarPor col-md-12 form-control" from="${[1: 'Cédula', 2: 'Nombre', 3 : 'Apellido']}" optionKey="key"
                              optionValue="value"/>
                </span>
                <span class="col-md-6">
                    <label class="control-label text-info">Criterio</label>
                    <g:textField name="buscarCriterioBU" id="criterioCriterioBU" class="form-control"/>
                </span>
            </span>
            <div class="col-md-3" style="margin-top: 20px">
                <button class="btn btn-info" id="btnBuscarUsuariosBU"><i class="fa fa-search"></i></button>
                <button class="btn btn-warning" id="btnLimpiarBusquedaBU"><i class="fa fa-eraser"></i></button>
            </div>
        </div>
    </fieldset>

    <div id="divTablaBuscarUsuarios" style="margin-top: 20px">
    </div>
</div>

<script type="text/javascript">

    $("#btnLimpiarBusquedaBU").click(function () {
        $(".buscarPor").val(1);
        $("#criterioCriterioBU").val('');
        cargarTablaBuscarUsuarios();
    });

    $("#btnBuscarUsuariosBU").click(function () {
        cargarTablaBuscarUsuarios();
    });

    cargarTablaBuscarUsuarios();

    function cargarTablaBuscarUsuarios(){
        var d = cargarLoader("Cargando...");
        var criterio = $("#criterioCriterioBU").val();
        var buscarPor = $("#buscarPorBU option:selected").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'actividad', action: 'tablaBuscarUsuario_ajax')}',
            data:{
                criterio: criterio,
                buscarPor: buscarPor,
                tipo: '${tipo}'
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaBuscarUsuarios").html(msg)
            }
        })
    }


</script>