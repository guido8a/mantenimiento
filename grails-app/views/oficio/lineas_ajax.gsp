<div class="row">
    <div class="col-md-12">
        <label for="lineas" class="col-md-4 control-label text-info">
            Número de líneas
        </label>
        <div class="col-md-7">
            <g:textField name="lineas" value="${lineas}" class="form-control col-md-10 "  />
        </div>
    </div>
</div>


<script type="text/javascript">

    function validarNum(ev) {
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }

    $("#lineas").keydown(function (ev) {
        return validarNum(ev);
    });


</script>