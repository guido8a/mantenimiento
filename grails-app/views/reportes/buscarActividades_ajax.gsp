<div class="row">
    <div class="col-md-12">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div class="col-md-1">
                <label>Contrato</label>
            </div>
            <g:select name="contrato" from="${bitacora.Contrato.list().sort{it.numero}}" optionKey="id" optionValue="${{it.numero}}" class="form-control" />
        </div>
    </div>
</div>