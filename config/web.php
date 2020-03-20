<?php

$params = require __DIR__ . '/params.php';
$db = require __DIR__ . '/db.php';
$mail =  require __DIR__ . '/email.php';
$config = [
    'id' => 'basic',
    'language'=>'es',
    'sourceLanguage' => 'es-ES',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'aliases' => [
        '@bower' => '@vendor/bower-asset',
        '@npm'   => '@vendor/npm-asset',
    ],
    'components' => [
        'request' => [
            // !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
            'cookieValidationKey' => '123',
        ],
        'assetManager' => [
            'bundles' => [
                'rce\material\Assets' => [
                    'siteTitle' => 'SEISA',
                    'sidebarColor' => 'azure',
                    'sidebarBackgroundColor' => 'white',
                    'sidebarBackgroundImage' => 'img url'
                ],
                'yii\bootstrap\BootstrapAsset' => [
                    'css' => [],
                    'js'=>[]
                ],
                'yii\bootstrap\Bootstrap4Asset' => [
                    'css' => [],
                    'js'=>[]
                ],
            ],
        ],

        'formatter' => [
            'class' => 'yii\i18n\Formatter',
            'locale' => 'es-ES', //ej. 'es-ES'
            'language'=>'es-ES',
            'thousandSeparator' => '.',
            'decimalSeparator' => ',',
            'dateFormat' => 'dd/MM/Y',
            'datetimeFormat' => 'd/M/Y hh:i:ss a',
            'currencyCode' => '$',

        ],
        'traza'=>[
            'class' => 'app\components\TrazaComponent',
        ],
        'xlsModels'=>[
            'class' => 'app\components\XlsModelsComponent',
        ],
        'authManager' => [
            'class' => 'yii\rbac\DbManager',
        ],
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
        'user' => [
            'identityClass' => 'app\models\User',

            'authTimeout' => 86400,
            'enableAutoLogin' => true,
        ],

        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        'mailer' =>$mail,
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'db' => $db,

        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
            'rules' => [
            ],
        ],

    ],
    'params' => $params,
];

if (YII_ENV_DEV) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        'allowedIPs' => ['192.168.0.4', '::1'],
    ];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        // uncomment the following to add your IP if you are not connecting from localhost.
        'allowedIPs' => ['192.168.0.4', '::1'],
    ];
}

return $config;
