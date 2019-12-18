<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\DocumentTypePermission;

/**
 * DocumentTypePermissionSearch represents the model behind the search form of `app\models\DocumentTypePermission`.
 */
class DocumentTypePermissionSearch extends DocumentTypePermission
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'document_type_id'], 'integer'],
            [['role'], 'safe'],
            [['allow_view', 'allow_update'], 'boolean'],
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
        $query = DocumentTypePermission::find();

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
            'document_type_id' => $this->document_type_id,
            'allow_view' => $this->allow_view,
            'allow_update' => $this->allow_update,
        ]);

        $query->andFilterWhere(['ilike', 'role', $this->role]);

        return $dataProvider;
    }
}
