<?php

namespace app\controllers;

use app\models\ContactForm;
use app\models\LoginForm;
use app\models\Rbac;
use app\models\User;
use Yii;
use yii\filters\AccessControl;
use yii\filters\VerbFilter;
use yii\web\Controller;
use yii\web\Response;

class SiteController extends Controller
{
    /**
     * {@inheritdoc}
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
        if (Yii::$app->user->isGuest)
            return $this->redirect('/site/login');
        switch (Rbac::getRole()) {
            case Rbac::$UEB:
                return $this->indexUEB();
                break;
            case Rbac::$JEFE_LOGÍSTICA:
            case Rbac::$LOGISTICA_ID:
                return $this->actionIndexLogistica();
                break;
            case Rbac::$JEFE_TECNCIO:
                return $this->render('indexJDOPBS');
                break;
            case Rbac::$ESP_TECNICO:
                return $this->render('indexDOPBS');
                break;
            case Rbac::$JEFE_COMPRAS:
                return $this->render('indexJCompras');
            case Rbac::$COMPRADOR:

                return $this->render('indexComprador');
                break;

                break;
            case Rbac::$COMITE:
                return $this->render('indexComite');
                break;

        }

        return $this->render('index');
    }

    /**
     * Gráficas aplicables a las UEB
     * @return string
     * @throws \yii\db\Exception
     */
    public function indexUEB()
    {
        $max = date('Y-m-d');
        $min = date('Y-m-d',strtotime ( '-1 year' , strtotime ( $max ) ));
        $connection = Yii::$app->getDb();
        //Demandas por estados;
        $query1 = $connection->createCommand("SELECT
\"public\".demand_status.label,
\"public\".demand_status.color,
count(\"public\".demand_status.label)
FROM
\"public\".demand
INNER JOIN \"public\".demand_status ON \"public\".demand.demand_status_id = \"public\".demand_status.\"id\"
INNER JOIN \"public\".client ON \"public\".demand.client_id = \"public\".client.\"id\"
INNER JOIN \"public\".province_ueb ON \"public\".client.province_ueb = \"public\".province_ueb.\"id\"
WHERE client.province_ueb= " . User::userLogged()->province_ueb . "
GROUP BY \"public\".demand_status.label, color")->queryAll();
        $query2 = $connection->createCommand("SELECT
 to_char(date(sending_date), 'MM-YY') as fecha, count( to_char(date(sending_date), 'Mon-YY')) as total
FROM
	\"public\".demand
	INNER JOIN \"public\".client ON \"public\".demand.client_id = \"public\".client.\"id\"
	INNER JOIN \"public\".province_ueb ON \"public\".client.province_ueb = \"public\".province_ueb.\"id\"
	where sending_date BETWEEN   '".$min."' and '".$max."'
	and province_ueb.id=".User::userLogged()->province_ueb."
	GROUP BY fecha
	ORDER BY fecha ASC")->queryAll();

        return $this->render('indexUEB', ['query1' => $query1,'query2'=>$query2]);
    }

    /**
     * Gráficas aplicables al Rol Logística
     */
    public function actionIndexLogistica(){

        return $this->render('indexLogistica');

    }
    /**
     * Login action.
     *
     * @return Response|string
     */
    public function actionLogin()
    {
        $this->layout = 'primary';
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {
            $user = Yii::$app->user->identity;
            $user->last_login = date('Y-m-d H:i:s');
            $user->save(false);

            Yii::$app->traza->saveLog('Usuario autenticado', 'Se ha autenticado el usuario ' . $user->username);
            Yii::$app->session->setFlash('success','Bienvenido '.$user->full_name);
            return $this->goBack();
        }

        $model->password = '';
        return $this->render('login', [
            'model' => $model,
        ]);
    }

    public function actionMail()
    {
        Yii::$app->mailer->compose('demandArrived', [])
            ->setFrom([Yii::$app->params['senderEmail'] => Yii::$app->params['senderName']])
            ->setTo('carlosllorca89@gmail.com')
            // ->setBcc('inmaj@codeberrysolutions.com')
            ->setSubject("Se ha registrado una nueva demanda.")
            ->send();
    }

    /**
     * Logout action.
     *
     * @return Response
     */
    public function actionLogout()
    {
        Yii::$app->traza->saveLog('Usuario sale del sistema', 'El usuario  ' . Yii::$app->user->id . ' ha salido del sistema');
        Yii::$app->user->logout();
        Yii::$app->session->setFlash('success', 'Su usuario ha sido desconectado satisfactoriamente.');


        return $this->goHome();
    }

    /**
     * Displays contact page.
     *
     * @return Response|string
     */
    public function actionContact()
    {
        $model = new ContactForm(
            [
                'name' => User::userLogged()->full_name,
                'email' => User::userLogged()->email
            ]
        );

        if ($model->load(Yii::$app->request->post()) && $model->contact(Yii::$app->params['adminEmail'])) {
            Yii::$app->session->setFlash('contactFormSubmitted');

            return $this->refresh();
        }
        return $this->render('contact', [
            'model' => $model,
        ]);
    }

    /**
     * Displays about page.
     *
     * @return string
     */
    public function actionAbout()
    {
        return $this->render('about');
    }
}
