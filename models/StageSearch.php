<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Stage;

/**
 * StageSearch represents the model behind the search form of `app\models\Stage`.
 */
class StageSearch extends Stage
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'order', 'buy_request_type_id'], 'integer'],
            [['label'], 'safe'],
            [['active'], 'boolean'],
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
        $query = Stage::find();

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
        if(!isset($params['sort'])){
            $query->orderBy('buy_request_type_id, order');
        }


        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'order' => $this->order,
            'buy_request_type_id' => $this->buy_request_type_id,
            'active' => $this->active,
        ]);

        $query->andFilterWhere(['ilike', 'label', $this->label]);

        return $dataProvider;
    }
}
