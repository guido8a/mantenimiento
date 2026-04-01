<label class="control-label text-info">
    Período
</label>
<g:select name="periodoForm" from="${periodos}" required=""
          class="form-control required" optionKey="id"
          optionValue="${{it.fechads?.format("dd-MMM-yy") + " - " + it.fechahs?.format("dd-MMM-yy")}}"
          value="${actividad?.periodo?.id}" />