<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\DocumentType;

/**
 * DocumentTypeSearch represents the model behind the search form of `app\models\DocumentType`.
 */
class DocumentTypeSearch extends DocumentType
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id','order_doc'], 'integer'],
            [['label','responsable','buy_request_type_id'], 'safe'],
            [['required','active'], 'boolean'],
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
        $query = DocumentType::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);
        if(!isset($params['sort'])){
            $query->orderBy('buy_request_type_id, order_doc');
        }

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'required' => $this->required,
            'order_doc' => $this->order_doc,
            'active' => $this->active,
            'buy_request_type_id'=>$this->buy_request_type_id
        ]);

        $query->andFilterWhere(['ilike', 'label', $this->label]);
        $query->andFilterWhere(['ilike', 'responsable', $this->label]);

        return $dataProvider;
    }
}
