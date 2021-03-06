<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\BuyRequest;
use yii\web\ForbiddenHttpException;

/**
 * BuyRequestSearch represents the model behind the search form of `app\models\BuyRequest`.
 */
class BuyRequestSearch extends BuyRequest
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'created_by', 'buy_request_status_id', 'buy_request_type_id'], 'integer'],
            [['code', 'created', 'last_update'], 'safe'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = BuyRequest::find();

        // add conditions that should always apply here
        switch(Rbac::getRole()){
            case Rbac::$JEFE_LOGÍSTICA:
            case Rbac::$LOGISTICA_ID:
                break;
            case Rbac::$JEFE_TECNCIO:

                //$query->innerJoinWith('buyRequestInternational');
                $query->andWhere(['not',['approved_date'=>null]]);
                break;

            case Rbac::$JEFE_COMPRAS:

                $query->andWhere(['not',['dt_approved_by'=>null]]);
                break;
            case Rbac::$COMPRADOR:

                $query->andWhere(['buyer_assigned'=>User::userLogged()->id]);
                break;


            case Rbac::$ESP_TECNICO:
                $query->andWhere(['dt_specialist_assigned'=>User::userLogged()->id]);
                break;

            case Rbac::$COMITE:
                $query->andWhere(['buy_request_status_id'=>BuyRequestStatus::$EVALUANDO_OFERTAS]);
                break;

            default:
                throw  new ForbiddenHttpException("Esta vista no está preparada para usuario scon su rol.");
                break;
        }
        $query->andWhere(['buy_request_type_id'=>User::userLogged()->arrayCanView()]);
        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);




        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
           // 'created' => $this->created,
            'last_update' => $this->last_update,
            'created_by' => $this->created_by,
            'buy_request_status_id' => $this->buy_request_status_id,

            'buy_request_type_id' => $this->buy_request_type_id,
        ]);
        $daterange = $this->range();
        if($daterange){
            $query->andFilterWhere([
                'between', 'created', $daterange[0], $daterange[1]
            ]);
        }

        $query->andFilterWhere(['ilike', 'code', $this->code]);

        return $dataProvider;
    }
    private function range(){
        if(strlen($this->created)==23){
            $start = substr($this->created,0,10);
            $end = substr($this->created,13,23);
            return [$start,$end];
        }
        return false;
    }
}
