<div class="row" >
    <div class="col-md-12">
        <div class="col-md-12" style="border: 1px #000000 solid; font-size: 14px">
                <div class="col-md-1 text-info">
                    Sistema:
                </div>
                <div class="col-md-11">
                    ${query?.sistema?.nombre}
                </div>
                <div class="col-md-1 text-info">
                    Fecha:
                </div>
                <div class="col-md-3">
                    ${query?.fecha?.format("dd-MM-yyyy")}
                </div>
        </div>
    </div>
</div>

<div class="row" >
    <div class="col-md-12 text-info" style="font-size: 16px; font-weight: bold">
        Problema
    </div>
    <div class="col-md-12" >
        <div class="col-md-12 alert alert-info" style="border: 1px #000000 solid;">
            <div class="col-md-12" style="font-size: 14px; border: 1px black">
                <elm2:poneHtml textoHtml="${query?.problema}" />
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12 text-info" style="font-size: 16px; font-weight: bold">
        Algoritmo
    </div>
    <div class="col-md-12">
        <div class="col-md-12 alert alert-success"  style="border: 1px #000000 solid;">
            <div class="col-md-12" style="font-size: 14px">
                <elm2:poneHtml textoHtml="${query?.algoritmo}" />
            </div>
        </div>
    </div>
</div>

<div class="row" >
    <div class="col-md-12 text-info" style="font-size: 12px; font-weight: bold">
        Palabras clave
    </div>
    <div class="col-md-12" >
        <div class="col-md-12 alert alert-warning" style="border: 1px #000000 solid;">
            <div class="col-md-12" style="font-size: 12px; border: 1px black">
                ${query?.clave}
            </div>
        </div>
    </div>
</div>

<div class="row" >
    <div class="col-md-12 text-info" style="font-size: 12px; font-weight: bold">
       Referencias
    </div>
    <div class="col-md-12" >
        <div class="col-md-12 alert alert-warning" style="border: 1px #000000 solid;">
            <div class="col-md-12" style="font-size: 12px; border: 1px black">
                ${query?.referencia}
            </div>
        </div>
    </div>
</div>




