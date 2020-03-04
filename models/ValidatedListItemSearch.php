<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\ValidatedListItem;

/**
 * ValidatedListItemSearch represents the model behind the search form of `app\models\ValidatedListItem`.
 */
class ValidatedListItemSearch extends ValidatedListItem
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'um_id', 'validated_list_id'], 'integer'],
            [['seisa_code', 'product_name', 'tecnic_description'], 'safe'],
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
    public function search($params,$vl)
    {
        $query = ValidatedListItem::find();
        $query->andWhere(['validated_list_id'=>$vl]);
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
            'price' => $this->price,

            'um_id' => $this->um_id,
            'subfamily_id' => $this->validated_list_id,
        ]);

        $query->andFilterWhere(['ilike', 'seisa_code', $this->seisa_code])
            ->andFilterWhere(['ilike', 'product_name', $this->product_name])
            ->andFilterWhere(['ilike', 'tecnic_description', $this->tecnic_description]);

        return $dataProvider;
    }
}
