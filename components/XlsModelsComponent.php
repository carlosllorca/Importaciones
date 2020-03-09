<?php

namespace app\components;

use app\models\BuyRequest;
use app\models\ValidatedListItem;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use PhpOffice\PhpSpreadsheet\Writer\Xls;
use Yii;

/**
 * Class XLSMODELSCOMPONENT
 * @property   Spreadsheet $spreadsheet
 * @property   Worksheet $sheet
 *
 *
 */
class XlsModelsComponent extends \yii\base\Component
{
    static $rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', "L", 'M',"N","O","P"];
    /**
     * @param BuyRequest $model
     * @throws \PhpOffice\PhpSpreadsheet\Exception
     * @throws \PhpOffice\PhpSpreadsheet\Writer\Exception
     * @throws \yii\base\ExitException
     */
    private $spreadsheet;
    private $col;
    private $row;
    private $sheet;
    private $download=true;

    /**
     * @param BuyRequest $model
     * @throws \yii\base\InvalidConfigException
     */
    public function xlsSolicitudCompra($model)
    {
        $this->start([30, 40, 10, 30, 40],$model->code);
        $this->titleColumn('SOLICITUD DE COMPRAS', 4);
        $this->breakLine();
        $this->cellBold();
        $this->span(0,1);
        $this->paint('UEB/Cliente:');
        $this->setCurrent('B',2);
        $this->span(1,1);
        $clientes ='';
        foreach ($model->clientes() as $cliente){
            $clientes=$cliente->provinceUeb->label.'/'.$cliente->name."\n";
        }
        $this->paint($clientes);
        $this->setCurrent('D',2);
        $this->span(1,0);
        $this->paint('Solicitud No:'.$model->code);
        $this->breakLine();
        $this->setCurrent('D',$this->row);
        $this->span(1,0);
        $this->paint('Fecha Sol:'.Yii::$app->formatter->asDate($model->approved_date));
        $this->breakLine();
        $this->titleColumn('REQUERIMIENTOS DE LA COMPRA');
        $this->breakLine();
        $this->cellBold();
        $this->setHeight(30);
        $this->paint('A ejecutar con:');
        $this->span(3,0);
        $this->paint($model->demandItems[0]->demand->strPaymentMethod(true));
        $this->breakLine();
        $this->cellBold();
        $this->paint('Las entregas se necesitan en:');
        $this->span(3,0);
        $this->paint($model->demandItems[0]->demand->strDeploymentPart());
        $this->breakLine();
        $this->cellBold();
        $this->paint('Especificaciones de la garantía:');
        $this->span(1,0);
        $this->paint($model->demandItems[0]->demand->warrantySpecification());
        $this->setCurrent('D',$this->row);
        $this->cellBold();
        $this->paint('Tiempo de garantía');
        $this->cellBold();
        $this->paint($model->demandItems[0]->demand->txtWarrantyTime());
        $this->breakLine();
        $this->titleColumn("MOTIVO DE LA COMPRA");
        $this->breakLine();
        $this->span(4,0);
        $this->paint($model->demandItems[0]->demand->strBuyReason());
        $this->breakLine();
        $this->titleColumn('PIEZAS DE REPUESTO, POST GARANTÍA, ASISTENCIA TÉCNICA Y CAPACITACIÓN');
        $this->breakLine();
        $this->setHeight(30);
        $this->paint('Requiere kit de piezas de repuesto: ');
        $this->paint($model->demandItems[0]->demand->require_replacement_part?'(X) SI  ( ) NO':'( ) SI  (X) NO');
        $this->span(2);
        $l=$model->demandItems[0]->demand->replacement_part_details?$model->demandItems[0]->demand->replacement_part_details:'-';
        $this->paint("(cantidades, código y descripción del fabricante):\n{$l}");
        $this->breakLine();
        $this->setHeight(30);
        $this->paint("Requiere servicio o\n venta post garantía:");
        $this->paint($model->demandItems[0]->demand->require_post_warranty?'(X) SI  ( ) NO':'( ) SI  (X) NO');
        $this->span(2);
        $l=$model->demandItems[0]->demand->post_warranty_details?$model->demandItems[0]->demand->post_warranty_details:'-';
        $this->paint("(Plazo y condiciones para la post garantía):\n{$l}");
        $this->breakLine();
        $this->setHeight(30);
        $this->paint("Detalles y alcance de la \nasistencia técnica:");
        $this->paint($model->demandItems[0]->demand->require_technic_asistance?'(X) SI  ( ) NO':'( ) SI  (X) NO');
        $this->span(2);
        $l=$model->demandItems[0]->demand->technic_asistance_details?$model->demandItems[0]->demand->technic_asistance_details:'-';
        $this->paint("(Detalle y alcance de la asistencia técnica):\n{$l}");
        $this->breakLine();
        $this->span(1);
        $this->setHeight(30);
        $l=$model->demandItems[0]->demand->strSellerRequirement();
        $this->paint("Indicar si se requiere por parte del Vendedor:\n{$l}");
        $this->setCurrent('C',$this->row);
        $this->span(1);
        $this->paint("Alcance requerido:\n");
        $this->setCurrent('E',$this->row);
        $this->paint($model->demandItems[0]->demand->seller_requirement_details);
        $this->breakLine();
        $this->span(4);
        $this->setHeight(40);
        $this->alignTop();
        $this->paint("Observaciones: Adjunto listado con los productos a compras.\n{$model->demandItems[0]->demand->observation}");
        $this->breakLine();
        $this->span(4);
        $this->cellBold();
        $this->paint("Por la Dirección Logística:");
        $this->breakLine();
        $this->span(2);
        $this->paint("Elaborado por:");
        $this->setCurrent('D',$this->row);
        $this->span(2);
        $this->paint("Aprobador por:");
        $this->breakLine();
        $this->paint('Nombre');
        $this->paint($model->createdBy->full_name);
        $this->paint('');
        $this->paint('Nombre:');
        $this->paint($model->approvedBy->full_name);
        $this->breakLine();
        $this->paint('Cargo');
        $this->paint($model->createdBy->cargo);
        $this->paint('');
        $this->paint('Cargo:');
        $this->paint($model->approvedBy->cargo);
        $this->breakLine();
        $this->paint('Firma');
        $this->paint('');
        $this->paint('');
        $this->paint('Firma:');
        $this->paint('');
        $this->breakLine();
        $this->paint('Fecha');
        $this->paint(Yii::$app->formatter->asDate($model->created));
        $this->paint('');
        $this->paint('Fecha:');
        $this->paint(Yii::$app->formatter->asDate($model->approved_date));
        $this->breakLine();
        $this->span(4);
        $this->cellBold();
        $this->paint("Por la UEB compras:");
        $this->breakLine();
        $this->span(2);
        $this->paint("Recibido por:");
        $this->setCurrent('D',$this->row);
        $this->span(2);
        $this->paint("Aprobador por:");
        $this->breakLine();
        $this->paint('Nombre');
        $this->paint($model->buyRequestInternational->buyerAssigned->full_name);
        $this->paint('');
        $this->paint('Nombre:');
        $this->paint($model->buyRequestInternational->buyApprovedBy->full_name);
        $this->breakLine();
        $this->paint('Cargo');
        $this->paint($model->buyRequestInternational->buyerAssigned->cargo);
        $this->paint('');
        $this->paint('Cargo:');
        $this->paint($model->buyRequestInternational->buyApprovedBy->cargo);
        $this->breakLine();
        $this->paint('Firma');
        $this->paint('');
        $this->paint('');
        $this->paint('Firma:');
        $this->paint('');
        $this->breakLine();
        $this->paint('Fecha');
        $this->paint(Yii::$app->formatter->asDate($model->buyRequestInternational->buy_approved_date));
        $this->paint('');
        $this->paint('Fecha:');
        $this->paint(Yii::$app->formatter->asDate($model->buyRequestInternational->buy_approved_date));
        $this->breakLine();

        $this->addSheet('Productos');
        $this->setCurrent('A',1);
        $this->setHeight(40);
        $this->setColumnWidth([5,40,60,20,10,15,15,15]);
        $this->cellBold();
        $this->paint('ITEM');
        $this->cellBold();
        $this->paint("MODELO Y/O NUMERO DE PARTE \nDEL PRODUCTO");
        $this->cellBold();
        $this->paint('DESCRIPCIÓN TÉCNICA');
        $this->cellBold();
        $this->paint('HOMOLOGACIÓN');
        $this->cellBold();
        $this->paint('UM');
        $this->cellBold();
        $this->paint('CANTIDAD');
        $this->cellBold();
        $this->paint("PRECIO \n(CUC-USD)");
        $this->cellBold();
        $this->paint("IMPORTE \n(CUC-USD)");

        $item = 1;
        $total =0;
        foreach ($model->getProducts() as $product){
            $this->breakLine();
            $this->setHeight(70);
            $total=$total+round($product->price*$product->quantity,2);
            $pr = ValidatedListItem::findOne(['product_name'=>$product->product_name]);
            $this->paint($item);
            $this->paint($product->product_name);
            $this->alignJustify();
            $this->paint($pr->tecnic_description);
            $this->paint($pr->certificadosStr()?$pr->certificadosStr():'-');
            $this->paint($pr->um->label);
            $this->paint($product->quantity);
            $this->paint(Yii::$app->formatter->asCurrency($product->price));
            $this->paint(Yii::$app->formatter->asCurrency(round($product->price*$product->quantity,2)));
            $item++;

        }
        $this->breakLine();
        $this->span(6);
        $this->cellBold();
        $this->alignRight();
        $this->paint('TOTAL');
        $this->setCurrent('H',$this->row);
        $this->cellBold();
        $this->paint(Yii::$app->formatter->asCurrency($total));
        $this->end();




    }
    /**
     * @param BuyRequest $model
     * @throws \yii\base\InvalidConfigException
     */
    public function xlsSolicitudOfertas($model){
        $this->download=false;
        $this->start([50,20,30],'Sol_ofertas'.$model->code);
        $this->titleColumn('SOLICITUD DE COTIZACIÓN',2);
        $this->breakLine();
        $this->setHeight(60);
        $this->cellBold();
        $this->paint('Estimado Señor: La  Compañía SEISA tiene interés de  contar con su mejor oferta a  partir de la solicitud que más abajo se detalla, desglosada por surtido de forma  que  se adjunta.');
        $this->paint("Solicitud No: \n{$model->code}");
        $date =Yii::$app->formatter->asDate($model->approved_date);
        $this->paint("\n{$date}");
        $this->breakLine();
        $date =Yii::$app->formatter->asDate($model->buyRequestInternational->bidding_end);
        $this->titleColumn('Fecha máxima de presentación de oferta: '.$date,2);
        $this->breakLine();
        $this->span(2);
        $this->paint('A: Proveedpr');
        $this->breakLine();
        $this->setHeight(50);
        $this->span(2);
        $this->paint('De: '.$model->buyRequestInternational->buyerAssigned->full_name."\n".
            'Cargo:'.$model->buyRequestInternational->buyerAssigned->cargo."\n".
            "Teléfono:".$model->buyRequestInternational->buyerAssigned->phone_number."\n".
            "Correo electrónico:".$model->buyRequestInternational->buyerAssigned->email
        );
        $this->breakLine();
        $this->titleColumn('Su oferta deberá realizarse en las siguientes condiciones:',2);
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Reflejar Número Referencia de Solicitud de Oferta:");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Identificar proveedor con razon social y logotipo actualizado , firma de la persona autorizada.");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->setHeight(30);
        $this->paint("Mantener el orden de productos respetando lo solicitado en este documento ( dejar en blanco aquellos que no sean ofertados). ");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Enviar una copia en formato .xls para facilitar su análisis. ");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Condición de compra según INCOTERMS ®2010: {$model->buyRequestInternational->buyCondition->label}");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Puerto/Aeropuerto de destino: {$model->buyRequestInternational->destiny->label}");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Forma de pago: {$model->buyRequestInternational->paymentInstrument->label}");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Validez de la oferta (no menos de 60 días):");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("El término de entrega requerido será:");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Se permiten embarques parciales los que serán aceptados previo acuerdo entre las partes.");
        $this->breakLine();
        $this->titleColumn("Su Oferta debe contener los siguientes aspectos:",2);
        $this->breakLine();
        $this->span(2);
        $this->setHeight(40);
        $this->paint("Valor Total, según Condición de Compra solicitada, desglosando precio EXW e importe total  FOB, Moneda y cualquier otro Gasto perfectamente desglosado incluyendo inspeccion en origen.");
        $this->breakLine();
        $this->span(2);
        $this->setHeight(40);
        $this->paint("Envases y Embalajes: Tipo y Especificaciones. Para Cargas Contenerizadas :  tipo de contenedor (20´, 40´, u otros)
         y si es carga agrupada o carga general. Si se emplea madera en los envases, se debe contar con el Certificado
          de Fumigación según la NIMF- 15. Cubicaje en M3 ");
        $this->breakLine();
        $this->span(2);
        $this->setHeight(40);
        $this->paint("Cantidad de bultos, especificando peso bruto y neto del total (en kg).");
        $this->breakLine();
        $this->cellBold();
        $this->setHeight(40);
        $this->span(2);
        $this->paint("En caso de embarques parciales o cronograma de entregas ,indicar : cantidad de bultos y/o contenedores , pesos y cubicaje en m3 , por cada embarque parcial ");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Calidad: Indicar las Certificaciones de Calidad del Producto de acuerdo a las Normas Internacionales.");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Origen de los productos.");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Marca y numero de parte del fabricante para cada item");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Estado de la homologacion del producto ante la Agencia correspondiente (APCI)");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Partida arancelaria para cada item");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Puerto/Aeropuerto de Embarque.");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Posibles Trasbordos/Escalas.");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Garantía: mínimo un 1 año a partir de la fecha de embarque ");
        $this->breakLine();
        $this->titleColumn("NO SE ACEPTARAN OFERTAS COMERCIALES EMITIDAS MAS ALLA DEL PLAZO MAXIMO ESPECIFICADO POR SEISA. ",2,50);
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("En espera su acostumbrada atención y al tanto de cualquier aclaración.");
        $this->breakLine();
        $this->cellBold();
        $this->span(2);
        $this->paint("Fraternalmente,");
        $this->breakLine();
        $this->setHeight(50);
        $this->cellBold();
        $this->span(2);
        $this->paint("Dirección de Compras (+53) 722-71-44 / 45. Inmobiliaria Kolhy, 4to piso, Of. 41, Rpto Kohly Calle 47 No. 3413 e/ 34 y 36, Playa, La Habana");
        $this->breakLine();


        $this->addSheet($model->code);
        $this->setCurrent('A',1);
        $this->setHeight(40);
        $this->setColumnWidth([5,10,10,20,15,15,20,40,10,10,10,15,15]);
        $this->cellBold();
        $this->paint('Item');
        $this->cellBold();
        $this->paint("Código SEISA");
        $this->cellBold();
        $this->paint("Part \nAranc.");
        $this->cellBold();
        $this->paint('Código o número de parte del fabricante');
        $this->cellBold();
        $this->paint('Fabricante');
        $this->cellBold();
        $this->paint('Marca');
        $this->cellBold();
        $this->paint("Producto");
        $this->cellBold();
        $this->paint("Descripción técnica");
        $this->cellBold();
        $this->paint("CERT");
        $this->cellBold();
        $this->paint("U.M.");
        $this->cellBold();
        $this->paint("Cantidad");
        $this->cellBold();
        $this->paint("Precio\nUnitario\n(Moneda)");
        $this->cellBold();
        $this->paint("Importe\n(Moneda)");
        $item = 1;
        $total =0;
        foreach ($model->getProducts() as $product){
            $this->breakLine();
            $this->setHeight(70);
            $total=$total+round($product->price*$product->quantity,2);
            $pr = ValidatedListItem::findOne(['product_name'=>$product->product_name]);
            $this->paint($item);
            $this->paint($pr->seisa_code);
            $this->setCurrent('G',$this->row);
            $this->paint($pr->product_name);
            $this->alignJustify();
            $this->paint($pr->tecnic_description);
            $this->paint($pr->certificadosStr()?$pr->certificadosStr():'-');
            $this->paint($pr->um->label);
            $this->paint($product->quantity);

            $item++;

        }









        $url ='offert_request/'.Yii::$app->security->generateRandomString().'.xls';
        $this->end($url);
        return $url;

    }

    private function start($columnWidth,$name)
    {
        $this->col = 'A';
        $this->row = 1;
        $this->spreadsheet = new Spreadsheet();
        $this->spreadsheet->getDefaultStyle()->getFont()->setSize(10);
        $this->sheet = $this->spreadsheet->getActiveSheet();
        $this->sheet->setTitle('Portada');
        if($this->download){
            ob_end_clean();  // clear out anything that may have already been output
            header('Content-Type: application/vnd.ms-excel');
            header('Content-Disposition: attachment;filename="'.$name.'.xls"');
            header('Cache-Control: max-age=0');
        }
        $this->spreadsheet->getActiveSheet()->getStyle('A1:E999')
            ->getAlignment()->setWrapText(true);

        $this->setColumnWidth($columnWidth);
    }
    private function setColumnWidth($columnWidth){
        $col = $this->col;
        foreach ($columnWidth as $width) {
            $this->sheet->getColumnDimension($col)->setWidth($width);
            $col = $this->nexCol($col, 1);

        }
    }
    private function addSheet($sheetName){
        $this->spreadsheet->createSheet();
        $this->sheet=$this->spreadsheet->setActiveSheetIndex(1);
        $this->sheet->getStyle('A1:Z999')
            ->getAlignment()->setWrapText(true);
        $this->sheet->setTitle($sheetName);

    }

    private function titleColumn($text, $colspan = 4,$rowHeight=30)
    {
        $this->sheet->getRowDimension($this->row)->setRowHeight($rowHeight);
        $newCol = $this->nexCol($this->col, $colspan);
        $this->sheet->mergeCells("{$this->col}{$this->row}:{$newCol}{$this->row}");
        $this->sheet->setCellValue("{$this->col}{$this->row}", $text);
        $this->sheet->getStyle("{$this->col}{$this->row}")->getFont()
            ->setSize(15)
            ->setBold(20);
        $this->sheet->getStyle($this->current())->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER);


    }
    private function alignTop(){
        $this->sheet->getStyle($this->current())->getAlignment()->setVertical(Alignment::VERTICAL_TOP);
    }
    private function alignRight(){
        $this->sheet->getStyle($this->current())->getAlignment()->setHorizontal(Alignment::HORIZONTAL_RIGHT);
    }
    private function alignJustify(){
        $this->sheet->getStyle($this->current())->getAlignment()->setHorizontal(Alignment::HORIZONTAL_JUSTIFY);
    }

    private function breakLine()
    {
        $this->col = 'A';
        $this->row = $this->row + 1;
        $this->sheet->getRowDimension($this->row)->setRowHeight(20);
    }

    private function cellBold()
    {
        $this->sheet->getStyle($this->current())->getFont()->setBold(20);
    }

    private function paint($text)
    {

        $this->sheet->setCellValue($this->current(), $text);
        $this->col=$this->nexCol($this->col,1);

    }
    private function setHeight($height){
        $this->sheet->getRowDimension($this->row)->setRowHeight($height);
    }

    private function end($name=false)
    {
        if($name){
            $writer=new Xls($this->spreadsheet);
            $writer->save($name);

        }else{
            $this->spreadsheet->setActiveSheetIndex(0);
            $writer = IOFactory::createWriter($this->spreadsheet, 'Xls');
            $writer->save('php://output');
            Yii::$app->end();
        }

    }

    private function span($colspan = 0, $rowspan = 0)
    {
        $nextCol = $this->col;
        $nextRow = $this->row;
        if ($colspan) {
            $nextCol = $this->nexCol($nextCol, $colspan);
        }
        if ($rowspan) {
            $nextRow = $this->row + $rowspan;
        }

        $this->sheet->mergeCells("{$this->current()}:{$nextCol}{$nextRow}");
    }

    private function nexCol($current, $steep)
    {
        $current_pos = array_search($current, self::$rows);
        return self::$rows[$current_pos + $steep];
    }

    private function current()
    {
        return "{$this->col}{$this->row}";
    }
    private function setCurrent($col,$row)
    {
       $this->col=$col;
       $this->row=$row;
    }



}
