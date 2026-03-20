<div class="row">
    <div class="col-md-12">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div class="col-md-8">
                <label>Palabra clave</label>
            </div>
            <g:select name="clave" from="${claves}"  optionKey="${{it.palabra}}" optionValue="${{it.palabra}}" class="form-control" />
        </div>
    </div>
</div>