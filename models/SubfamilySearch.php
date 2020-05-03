<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\Subfamily;

/**
 * SubfamilySearch represents the model behind the search form of `app\models\Subfamily`.
 */
class SubfamilySearch extends Subfamily
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'validated_list_id'], 'integer'],
            [['label'], 'safe'],
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
        $query = Subfamily::find();

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
            'validated_list_id' => $this->validated_list_id,
        ]);

        $query->andFilterWhere(['ilike', 'label', $this->label]);

        return $dataProvider;
    }
}
