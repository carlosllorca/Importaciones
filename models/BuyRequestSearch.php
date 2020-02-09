<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\BuyRequest;

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
