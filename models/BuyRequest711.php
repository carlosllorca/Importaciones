<?php

namespace app\models;

/**
 * This is the model class for table "buy_request_711".
 *
 * @property int $id
 * @property int|null $buy_request_id
 * @property int $final_destiny_id
 * @property int $plan
 * @property string $general_description
 * @property string $seguiment_date
 * @property float|null $other_operation
 * @property string|null $deployment_place
 *
 * @property BuyRequest $buyRequest
 * @property FinalDestiny $finalDestiny
 */
class BuyRequest711 extends \yii\db\ActiveRecord
{
    const SCENARIO_START_SEGUIMIENTO = 'START_SEGUIMIENTO';

    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'buy_request_711';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['buy_request_id', 'final_destiny_id', 'plan'], 'default', 'value' => null],
            [['plan'], 'integer', 'min' => 2018, 'max' => 2050],
            [['seguiment_date'], 'string'],
            [['seguiment_date'], 'required', 'on' => self::SCENARIO_START_SEGUIMIENTO],
            [['final_destiny_id', 'plan', 'general_description'], 'required'],
            [['general_description', 'deployment_place'], 'string'],
            [['other_operation'], 'number', 'min' => 0],
            [['buy_request_id'], 'exist', 'skipOnError' => true, 'targetClass' => BuyRequest::className(), 'targetAttribute' => ['buy_request_id' => 'id']],
            [['final_destiny_id'], 'exist', 'skipOnError' => true, 'targetClass' => FinalDestiny::className(), 'targetAttribute' => ['final_destiny_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'buy_request_id' => 'Solicitud asociada',
            'final_destiny_id' => 'Destino final',
            'plan' => 'Plan',
            'general_description' => 'Descripción general',
            'seguiment_date' => 'Fecha de inicio del seguimiento',
            'other_operation' => 'Gastos por otras operaciones y margen comercial',
            'deployment_place' => 'Lugar de entrega',
        ];
    }

    public function generateFiledTree()
    {
        $fields = DocumentType::find()->where(['active' => true])->andWhere(['buy_request_type_id' => BuyRequestType::$TYPE_711])->all();
        foreach ($fields as $field) {
            $doc = new BuyRequestDocument();
            $doc->document_type_id = $field->id;
            $doc->buy_request_id = $this->buyRequest->id;
            $doc->document_status_id = DocumentStatus::$PENDIENTE_ID;
            $doc->last_update = date('Y-m-d');
        }
        $doc->save(false);

    }

    /**
     * Gets query for [[BuyRequest]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getBuyRequest()
    {
        return $this->hasOne(BuyRequest::className(), ['id' => 'buy_request_id']);
    }

    /**
     * Gets query for [[FinalDestiny]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getFinalDestiny()
    {
        return $this->hasOne(FinalDestiny::className(), ['id' => 'final_destiny_id']);
    }

    public function newCode()
    {
        $currentCode = $this->buyRequest->code;
        $real = substr($currentCode, 0, 11);
        $i = 1;
        $flag = true;
        do {
            $str = str_pad($i, 2, '0', STR_PAD_LEFT);
            $code = $real . '-' . $this->finalDestiny->code . '-' . $str;
            if (BuyRequest::findOne(['code' => $code])) {
                $i++;
            } else {
                $flag = false;

            }
        } while ($flag);
        return $code;
    }
}
