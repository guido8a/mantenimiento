<g:select name="periodo" from="${periodos}" required=""
          class="form-control required" optionKey="id"
          optionValue="${{it.fechads?.format("dd-MMM-yy") + " - " + it.fechahs?.format("dd-MMM-yy")}}"
          value="${actividad?.periodo?.id}" style="width: 170px"/>