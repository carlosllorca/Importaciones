<?php

namespace app\models;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\User;

/**
 * UserSearch represents the model behind the search form of `app\models\User`.
 */
class UserSearch extends User
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'province_ueb'], 'integer'],
            [['username', 'full_name', 'email','created_at', 'password', 'created_at', 'last_login','rol'], 'safe'],
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
        $query = User::find();
        //$query->innerJoinWith('authAssignament');
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

        $daterangeCreated = $this->rangeCreated();
        if($daterangeCreated){
            $query->andFilterWhere([
                'between', 'created_at', $daterangeCreated[0], $daterangeCreated[1]
            ]);
        }
        $daterangeLasAccess = $this->rangeLastAccess();
        if($daterangeLasAccess){
            $query->andFilterWhere([
                'between', 'last_login', $daterangeLasAccess[0], $daterangeLasAccess[1]
            ]);
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'province_ueb' => $this->province_ueb,
            'item_name' => $this->rol,
        ]);

        $query->andFilterWhere(['ilike', 'username', $this->username])
            ->andFilterWhere(['ilike', 'full_name', $this->full_name])
            ->andFilterWhere(['ilike', 'email', $this->email])
            ->andFilterWhere(['ilike', 'password', $this->password]);

        return $dataProvider;
    }
    private function rangeCreated(){
        if(strlen($this->created_at)==23){
            $start = substr($this->created_at,0,10);
            $end = substr($this->created_at,13,23);
            return [$start,$end];
        }

        return false;
    }
    private function rangeLastAccess(){
        if(strlen($this->last_login)==23){
            $start = substr($this->last_login,0,10);
            $end = substr($this->last_login,13,23);
            return [$start,$end];
        }

        return false;
    }
}
