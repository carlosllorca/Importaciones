<?php

namespace app\components;

use app\models\BuyRequest;
use app\models\ValidatedListItem;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
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
    static $rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', "L", 'M'];
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

    /**
     * @param BuyRequest $model
     * @throws \yii\base\InvalidConfigException
     */
    public function xlsSolicitudCompra($model)
    {
        $this->start([30, 40, 10, 30, 40]);
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

    private function start($columnWidth)
    {
        $this->col = 'A';
        $this->row = 1;
        $this->spreadsheet = new Spreadsheet();
        $this->spreadsheet->getDefaultStyle()->getFont()->setSize(10);
        $this->sheet = $this->spreadsheet->getActiveSheet();
        $this->sheet->setTitle('Portada');
        ob_end_clean();  // clear out anything that may have already been output
        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="este.xls"');
        header('Cache-Control: max-age=0');
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
        $this->sheet->setTitle($sheetName);

    }

    private function titleColumn($text, $colspan = 4)
    {
        $this->sheet->getRowDimension($this->row)->setRowHeight(30);
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

    private function end()
    {
        $this->spreadsheet->setActiveSheetIndex(0);
        $writer = IOFactory::createWriter($this->spreadsheet, 'Xls');
        $writer->save('php://output');
        Yii::$app->end();
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
