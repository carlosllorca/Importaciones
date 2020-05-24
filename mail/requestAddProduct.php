<?php
/**
 * @var $requestStage \app\models\RequestStage[]
 * @var $user \app\models\User
 * @var $product \app\models\RequestAddItemForm
 * @var $mVl \app\models\ValidatedList
 */
$a = 0;
?>

<div class="row">
    <div class="title">
        <p>Solicitud para añadir un nuevo producto al listado validado <?=$mVl->label?>.</p>
    </div>
    <div class="content">

        <p>
            Estimado usuario:<br>
            Se ha solicitado la adición del producto <?=$product->name?> al listado validado <?=$mVl->label?>.
            A continuación se muestran sus especificaciones para que sea más fácil su valoración.<br><br>


        <br><br>

        </p>
        <p style="text-align: justify">
            <?=$product->description?>
        </p>
        <p>
            Puede comunicarse con el usuario mediante los siguientes datos.<br>
            <b>Nombres y Apellidos:</b><?=$user->full_name?><br>
            <b>Email:</b><?=$user->email?><br>
            <b>Teléfono:</b><?=$user->phone_number?><br>
            <b>UEB:</b><?=$user->provinceUeb->label?><br>

        </p>


    </div>
</div>
