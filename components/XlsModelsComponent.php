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
        $this->download=false;
        $this->start([30, 40, 10, 30, 40],$model->code);
        $this->addSheet('Productos');
        $this->removeSheet(0);
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
        $url ='tmp/'.$model->code.'.xls';
        $this->end($url,0);
        return $url;





    }
    /**
     * @param BuyRequest $model
     * @throws \yii\base\InvalidConfigException
     */
    public function xlsSolicitudOfertas($model){
        $this->download=false;
        $this->start([30, 40, 10, 30, 40],$model->code);


        $this->addSheet($model->code);
        $this->removeSheet(0);
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
        //$this->removeSheet(0);
        $url =$model->code.'.xls';
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
    private function removeSheet($sheet){
        $this->spreadsheet->removeSheetByIndex($sheet);
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

    private function end($name=false,$setActive=false)
    {
        if($name){
            $writer=new Xls($this->spreadsheet);
            $writer->save($name);

        }else{
            if($setActive!==false){
                $this->spreadsheet->setActiveSheetIndex($setActive);
            }

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
