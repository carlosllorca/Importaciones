<?php
/**
 * Created by PhpStorm.
 * User: carlos
 * Date: 14/04/16
 * Time: 14:52
 */

namespace app\controllers;
use app\models\Rbac;
use app\models\User;
use app\models\UserAccount;
use yii\base\Exception;
use yii\web\Controller;
use yii\web\ForbiddenHttpException;
use yii\web\NotFoundHttpException;
use Yii;


class MainController extends Controller
{
    /**
     * @var array Rutas a las que se puede acceder sin autenticarse(Se incluye el site controller completo)
     */
    private $gestRoute=[

        'site/contact',
        'site/login',

        'user/create'
    ];

    public function beforeAction($action)
    {



        $route=str_replace('-','',Yii::$app->controller->getRoute());
        if(Yii::$app->user->isGuest&&!in_array($route,$this->gestRoute)){
            Yii::$app->session->setFlash('danger','Lo sentimos debes estar autenticado.');
            header("Location: /site/login");
            die();

        }
        if(Yii::$app->user->isGuest&&in_array($route,$this->gestRoute)){

            return parent::beforeAction($action); // TODO: Change the autogenerated stub
        }



        $perms=\Yii::$app->user->can($route);

        if($perms){
            return parent::beforeAction($action); // TODO: Change the autogenerated stub
        }else{
          //  return parent::beforeAction($action);//remove this
            throw new ForbiddenHttpException('¡Usted no está autorizado a visitar esta página!');
        }


    }

    private function arrayController()
    {
        $controllerlist = [];
        if ($handle = opendir('../controllers')) {
            while (false !== ($file = readdir($handle))) {
                if ($file != "." && $file != ".." && substr($file, strrpos($file, '.') - 10) == 'Controller.php') {
                    $controllerlist[] = $file;
                }
            }
            closedir($handle);
        }
        asort($controllerlist);
        $fulllist = [];
        foreach ($controllerlist as $controller):
            $handle = fopen('../controllers/' . $controller, "r");
            if ($handle) {
                while (($line = fgets($handle)) !== false) {
                    if (preg_match('/public function action(.*?)\(/', $line, $display)):
                        if (strlen($display[1]) > 2):
                            $fulllist[substr($controller, 0, -4)][] = strtolower($display[1]);
                        endif;
                    endif;
                }
            }
            fclose($handle);
        endforeach;
        return $fulllist;
    }
    public function getAllRoutes(){
        $arr=$this->arrayController();
        $key=array_keys($arr);
        $routes=[];


        for($i=0;$i<count($key);$i++){//Recorriendo Controladores
            $controller=substr($key[$i],0,-10);
            array_push($routes,$controller.'/*');
            for($a=0;$a<count($arr[$key[$i]]);$a++)
            array_push($routes,$controller.'/'.$arr[$key[$i]][$a]);
        }
        return $routes;
    }

    public static function determineActive($section,$except=[]){

        if(Yii::$app->controller->id == $section&&array_search( Yii::$app->controller->action->id,$except)===false){
            return  "active";
        }
       return "";
    }

    public static function determineActiveAction($section, $action){
        return Yii::$app->controller->id == $section &&
        Yii::$app->controller->action->id == $action? "active" : "";
    }


    public static function determineExpand($group)
    {
        $groupsBackend = ["nomencaladores" => ["thematic-area", "payment-method", "gender", "identification-type", "modality", "payment-status", "professional-category", "promocion-type", "status", "study-type", "template"],
                          "user"=>["user"]];
        $open = false;
        $section = Yii::$app->controller->id;

        if ($groupsBackend[$group]) {
            $currentGroup = $groupsBackend[$group];
            foreach ($currentGroup as $item) {
                if ($item == $section) $open = true;
            }
        }
        return $open ? "show" : "";
    }

    public static function getRouteNavigation(){
        $currentRoute = [];
        $queryParams = array_merge(array(),Yii::$app->request->getQueryParams());
        if(Yii::$app->controller->id === 'user'){
            if(Yii::$app->controller->action->id === 'profile'
                || Yii::$app->controller->action->id ==='update-my-profile'){
                $currentRoute[0] = Yii::$app->controller->action->id === 'profile' ? 'Mi Perfil' : 'Modificar Perfil';
                $currentRoute[1] = [Yii::$app->controller->id.'/'.Yii::$app->controller->action->id];
            }
            else if( Yii::$app->controller->action->id === 'pay'){
                $currentRoute[0] = 'Pago de Inscripción';
                $currentRoute[1] = ['/user/pay'];
            }else if( Yii::$app->controller->action->id === 'certificados'){
                $currentRoute[0] = 'Certificados';
                $currentRoute[1] = ['/user/certificados'];
            }
        }
        if(Yii::$app->controller->id === 'user-payout'){
            if( Yii::$app->controller->action->id === 'pay'){
                $currentRoute[0] = 'Pago de Inscripción';
                $currentRoute[1] = ['/user/pay'];
            }
            else if(Yii::$app->controller->action->id === 'create'){
                $currentRoute[0] = 'Pagar Inscripción';
                $route = $_GET;
                $route[0]=Yii::$app->controller->id.'/'.Yii::$app->controller->action->id;
                $currentRoute[1] = $route;
            }
            else if(Yii::$app->controller->action->id === 'view'){
                $currentRoute[0] = 'Información del Pago';
                $route = $_GET;
                $route[0]=Yii::$app->controller->id.'/'.Yii::$app->controller->action->id;
                $currentRoute[1] = $route;
            }
        }
        if(Yii::$app->controller->id === 'poster-video'){
            if( Yii::$app->controller->action->id === 'my-poster-videos'){
                $currentRoute[0] = 'Mis Pósters/Videos';
                $currentRoute[1] = ['/poster-video/my-poster-videos'];
            }

        }
        if(Yii::$app->controller->id === 'site'){
            if( Yii::$app->controller->action->id === 'normativa'){
                $currentRoute[0] = 'Normativa';
                $currentRoute[1] = ['/site/normativa'];
            }elseif( Yii::$app->controller->action->id === 'congreso'){
                $currentRoute[0] = 'III Congreso';
                $currentRoute[1] = ['/site/congreso'];
            }

        }
        if(Yii::$app->controller->id === 'communication'){
            if(Yii::$app->controller->action->id === 'update'
                || Yii::$app->controller->action->id === 'create'){
                $currentRoute[0] = 'Nueva Comunicación';
                $route = $_GET;
                $route[0]=Yii::$app->controller->id.'/'.Yii::$app->controller->action->id;
                $currentRoute[1] = $route;
            }
            elseif (Yii::$app->controller->action->id ==='my-communications'){
                $currentRoute[0] = 'Comunicaciones';
                $currentRoute[1] = [ Yii::$app->controller->id.'/'.Yii::$app->controller->action->id];
            }
        }
        if(sizeof($currentRoute) === 0) $currentRoute = null;
        return $currentRoute;
    }
}