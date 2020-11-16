<?php

namespace app\models;

use app\models\Demand;

use yii\base\Model;
use yii\data\ActiveDataProvider;

/**
 * DemandSearch represents the model behind the search form of `app\models\Demand`.
 */
class DemandSearch extends Demand
{
    /**
     * {@inheritdoc}
     */
    public $client_name;
    public $ueb;

    public function rules()
    {
        return [
            [['id', 'client_id', 'payment_method_id', 'deployment_part_id', 'waranty_time_id', 'purchase_reason_id', 'validated_list_id', 'seller_requirement_id', 'demand_status_id', 'created_by','approved_by'], 'integer'],
            [['client_contract_number', 'other_execution', 'other_deploy', 'warranty_specification', 'replacement_part_details', 'post_warranty_details', 'technic_asistance_details', 'created_date', 'sending_date', 'rejected_reason', 'observation','client_name','ueb','demand_code'], 'safe'],
            [['require_replacement_part', 'require_post_warranty', 'require_technic_asistance'], 'boolean'],
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
        $query = Demand::find();

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
            'client_id' => $this->client_id,
            'payment_method_id' => $this->payment_method_id,
            'deployment_part_id' => $this->deployment_part_id,
            'waranty_time_id' => $this->waranty_time_id,
            'purchase_reason_id' => $this->purchase_reason_id,
            'require_replacement_part' => $this->require_replacement_part,
            'require_post_warranty' => $this->require_post_warranty,
            'require_technic_asistance' => $this->require_technic_asistance,
            'created_date' => $this->created_date,
            'sending_date' => $this->sending_date,
            'validated_list_id' => $this->validated_list_id,
            'seller_requirement_id' => $this->seller_requirement_id,
            'demand_status_id' => $this->demand_status_id,
            'created_by' => $this->created_by,
        ]);
        $daterange = $this->range();
        if($daterange){
            $query->andFilterWhere([
                'between', 'sending_date', $daterange[0], $daterange[1]
            ]);
        }

        $query->andFilterWhere(['ilike', 'client_contract_number', $this->client_contract_number])
            ->andFilterWhere(['ilike', 'other_execution', $this->other_execution])
            ->andFilterWhere(['ilike', 'other_deploy', $this->other_deploy])
            ->andFilterWhere(['ilike', 'warranty_specification', $this->warranty_specification])
            ->andFilterWhere(['ilike', 'replacement_part_details', $this->replacement_part_details])
            ->andFilterWhere(['ilike', 'post_warranty_details', $this->post_warranty_details])
            ->andFilterWhere(['ilike', 'technic_asistance_details', $this->technic_asistance_details])
            ->andFilterWhere(['ilike', 'rejected_reason', $this->rejected_reason])
            ->andFilterWhere(['ilike', 'observation', $this->observation]);

        return $dataProvider;
    }
    public function searchUeb($params)
    {
        $query = Demand::find();
        $query->innerJoinWith('client')->where(['client.province_ueb'=>\Yii::$app->user->identity->province_ueb]);


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
            'client_id' => $this->client_id,
            'payment_method_id' => $this->payment_method_id,
            'deployment_part_id' => $this->deployment_part_id,
            'waranty_time_id' => $this->waranty_time_id,
            'purchase_reason_id' => $this->purchase_reason_id,
            'require_replacement_part' => $this->require_replacement_part,
            'require_post_warranty' => $this->require_post_warranty,
            'require_technic_asistance' => $this->require_technic_asistance,
            'created_date' => $this->created_date,
           // 'sending_date' => $this->sending_date,
            'validated_list_id' => $this->validated_list_id,
            'seller_requirement_id' => $this->seller_requirement_id,
            'demand_status_id' => $this->demand_status_id,
            'created_by' => $this->created_by,
        ]);
        $daterange = $this->range();
        if($daterange){
            $query->andFilterWhere([
                'between', 'sending_date', $daterange[0], $daterange[1]
            ]);
        }

        $query->andFilterWhere(['ilike', 'client_contract_number', $this->client_contract_number])
            ->andFilterWhere(['ilike', 'other_execution', $this->other_execution])
            ->andFilterWhere(['ilike', 'other_deploy', $this->other_deploy])
            ->andFilterWhere(['ilike', 'warranty_specification', $this->warranty_specification])
            ->andFilterWhere(['ilike', 'replacement_part_details', $this->replacement_part_details])
            ->andFilterWhere(['ilike', 'post_warranty_details', $this->post_warranty_details])
            ->andFilterWhere(['ilike', 'technic_asistance_details', $this->technic_asistance_details])
            ->andFilterWhere(['ilike', 'rejected_reason', $this->rejected_reason])
            ->andFilterWhere(['ilike', 'observation', $this->observation]);

        return $dataProvider;
    }
    public function searchDT($params)
    {
        $query = Demand::find();
        $query->innerJoinWith('client.provinceUeb');
        $query->innerJoinWith('validatedList');

        $query->innerJoinWith('demandStatus');

        $query->where(['not',['demand_status_id'=>DemandStatus::BORRADOR_ID]]);


        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);
        $dataProvider->sort->attributes['ueb'] = [
            // The tables are the ones our relation are configured to
            // in my case they are prefixed with "tbl_"
            'asc' => ['province_ueb.label' => SORT_ASC],
            'desc' => ['province_ueb.label' => SORT_DESC],
        ];
        $dataProvider->sort->attributes['validated_list_id'] = [
            // The tables are the ones our relation are configured to
            // in my case they are prefixed with "tbl_"
            'asc' => ['validated_list.label' => SORT_ASC],
            'desc' => ['validated_list.label' => SORT_DESC],
        ];

        $dataProvider->sort->attributes['demand_status_id'] = [
            // The tables are the ones our relation are configured to
            // in my case they are prefixed with "tbl_"
            'asc' => ['demand_status.label' => SORT_ASC],
            'desc' => ['demand_status.label' => SORT_DESC],
        ];
        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'client_id' => $this->client_id,
            'payment_method_id' => $this->payment_method_id,
            'deployment_part_id' => $this->deployment_part_id,
            'waranty_time_id' => $this->waranty_time_id,
            'purchase_reason_id' => $this->purchase_reason_id,
            'require_replacement_part' => $this->require_replacement_part,
            'require_post_warranty' => $this->require_post_warranty,
            'require_technic_asistance' => $this->require_technic_asistance,
            'client.province_ueb'=>$this->ueb,
            'created_date' => $this->created_date,
            'approved_by' => $this->approved_by,

            'validated_list_id' => $this->validated_list_id,
            'seller_requirement_id' => $this->seller_requirement_id,
            'demand_status_id' => $this->demand_status_id,
            'created_by' => $this->created_by,
        ]);
        $daterange = $this->range();
        if($daterange){
            $query->andFilterWhere([
                'between', 'sending_date', $daterange[0], $daterange[1]
            ]);
        }

        $query->andFilterWhere(['ilike', 'client_contract_number', $this->client_contract_number])
            ->andFilterWhere(['ilike', 'other_execution', $this->other_execution])
            ->andFilterWhere(['ilike', 'other_deploy', $this->other_deploy])
            ->andFilterWhere(['ilike', 'warranty_specification', $this->warranty_specification])
            ->andFilterWhere(['ilike', 'replacement_part_details', $this->replacement_part_details])
            ->andFilterWhere(['ilike', 'post_warranty_details', $this->post_warranty_details])
            ->andFilterWhere(['ilike', 'technic_asistance_details', $this->technic_asistance_details])
            ->andFilterWhere(['ilike', 'rejected_reason', $this->rejected_reason])
            ->andFilterWhere(['ilike', 'observation', $this->observation])
            ->andFilterWhere(['ilike', 'client.name', $this->client_name])
            ->andFilterWhere(['ilike', 'demand.demand_code', $this->demand_code]);

        return $dataProvider;
    }
    private function range(){
        if(strlen($this->sending_date)==23){
            $start = substr($this->sending_date,0,10);
            $end = substr($this->sending_date,13,23);
            return [$start,$end];
        }
        return false;
    }
}
