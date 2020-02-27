<?php



/* @var $this \yii\web\View */
/* @var $model \app\models\BuyRequest  */
?>
<div>
    <table class="table" >
        <tr>
            <td><p class="title">ITEM</p></td>
            <td><p class="title" >MODELO Y/O NUMERO DE PARTE DEL PRODUCTO</p></td>
            <td><p class="title" >DESCRIPCION TÉCNICA</p></td>
            <td><p class="title" >HOMOLOGACIÓN</p></td>
            <td><p class="title" >U/M</p></td>
            <td><p class="title" >CANTIDAD</p></td>
            <td><p class="title" >PRECIO (CUC-USD) </p></td>
            <td><p class="title" >IMPORTE (CUC-USD)</p></td>
        </tr>
        <?php
        $item = 1;
        $total =0;
        foreach ($model->getProducts() as $product){
            $total+=round($product->price*$product->quantity,2);
            $pr = \app\models\ValidatedListItem::findOne(['product_name'=>$product->product_name]);
            ?>
            <tr>
                <td style="text-align: center"><p class="textBasic" ><?=$item?></p></td>
                <td><p class="textBasic" ><?=$product->product_name?></p></td>
                <td><p class="textBasic" ><?=$pr->tecnic_description?></p></td>
                <td style="text-align: center"><p class="textBasic" ><?=$pr->certificadosStr()?></p></td>
                <td style="text-align: center"><p class="textBasic" ><?=$pr->um->label?></p></td>
                <td style="text-align: center"><p class="textBasic" ><?=$product->quantity?></p></td>
                <td style="text-align: center"><p class="textBasic" ><?=$product->price?></p></td>
                <td style="text-align: center"><p class="textBasic" ><?=$total?></p></td>
            </tr>
            <?php
            $item++;
        }
        ?>
        <tr>
            <td colspan="7" style="text-align: right"><p class="textBasic"  style="font-weight: bold">Total</p></td>
            <td colspan="7" style="text-align: center"><p class="textBasic"  style="font-weight: bold"><?=$total?></p></td>
        </tr>
    </table>

</div>