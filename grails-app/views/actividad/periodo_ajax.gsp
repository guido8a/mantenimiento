<label class="control-label text-info">
    Período
</label>
<g:select name="periodo" from="${periodos}" required=""
          class="form-control required" optionKey="id"
          optionValue="${{it.fechads?.format("dd-MMM-yy") + " - " + it.fechahs?.format("dd-MMM-yy")}}"
          value="${actual}" />

<script type="text/javascript">

    cargarActividades();

    $("#periodo").change(function () {
        cargarActividades();
    });

</script>