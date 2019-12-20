<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\DemandItem;

/**
 * DemandItemSearch represents the model behind the search form of `app\models\DemandItem`.
 */
class DemandItemSearch extends DemandItem
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'demand_id', 'validated_list_item_id', 'quantity', 'buy_request_id'], 'integer'],
            [['price'], 'number'],
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
        $query = DemandItem::find();

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
            'demand_id' => $this->demand_id,
            'validated_list_item_id' => $this->validated_list_item_id,
            'price' => $this->price,
            'quantity' => $this->quantity,
            'buy_request_id' => $this->buy_request_id,
        ]);

        return $dataProvider;
    }
}
