<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\BuyRequest711;

/**
 * BuyRequest711Search represents the model behind the search form of `app\models\BuyRequest711`.
 */
class BuyRequest711Search extends BuyRequest711
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'buy_request_id', 'final_destiny_id', 'plan'], 'integer'],
            [['general_description', 'deployment_place'], 'safe'],
            [['other_operation'], 'number'],
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
        $query = BuyRequest711::find();

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
            'buy_request_id' => $this->buy_request_id,
            'final_destiny_id' => $this->final_destiny_id,
            'plan' => $this->plan,
            'other_operation' => $this->other_operation,
        ]);

        $query->andFilterWhere(['ilike', 'general_description', $this->general_description])
            ->andFilterWhere(['ilike', 'deployment_place', $this->deployment_place]);

        return $dataProvider;
    }
}
