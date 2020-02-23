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
            [['code', 'created', 'last_update', 'bidding_start', 'bidding_end'], 'safe'],
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
                break;
            case Rbac::$JEFE_TECNCIO:
            case Rbac::$JEFE_COMPRAS:
                $query->andWhere(['gol_approved'=>true]);
                break;
            case Rbac::$COMPRADOR_INTERNACIONAL:
            case Rbac::$COMPRADOR_NACIONAL:
                $query->andWhere(['gol_approved'=>true]);
                $query->andWhere(['buyer_assigned'=>User::userLogged()->id]);
                break;
            case Rbac::$ESP_TECNICO:
                $query->andWhere(['gol_approved'=>true]);
                $query->andWhere(['dt_specialist_asigned'=>User::userLogged()->id]);
            case Rbac::$GOL:
                $query->andWhere(['not',['buy_request_status_id'=>BuyRequestStatus::$BORRADOR_ID]]);
                break;
            default:
                throw  new ForbiddenHttpException("Esta vista no está preparada para usuario scon su rol.");
                break;
        }
        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        /**
         * solo puede ver las ordenes asociadas a él que fueron aprobadas
         */
        if(Rbac::getRole()==Rbac::$COMPRADOR_INTERNACIONAL||Rbac::getRole()==Rbac::$COMPRADOR_NACIONAL){
            $query->where(['buyer_assigned'=>User::userLogged()->id]);
            $query->andWhere(['gol_approved'=>true]);
        }


        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'created' => $this->created,
            'last_update' => $this->last_update,
            'created_by' => $this->created_by,
            'buy_request_status_id' => $this->buy_request_status_id,
            'bidding_start' => $this->bidding_start,
            'bidding_end' => $this->bidding_end,
            'buy_request_type_id' => $this->buy_request_type_id,
        ]);

        $query->andFilterWhere(['ilike', 'code', $this->code]);

        return $dataProvider;
    }
}
