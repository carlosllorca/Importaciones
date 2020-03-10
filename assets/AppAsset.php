<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace app\assets;

use yii\web\AssetBundle;

/**
 * Main application asset bundle.
 *
 * @author Qiang Xue <qiang.xue@gmail.com>
 * @since 2.0
 */
class AppAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web';
    public $css = [
        'css/site.css',
        'css/fontawesome.min.css',
        'sA/sweetalert.css',
        'css/material-dashboard.min.css',
        'css/plantilla.css',
        'css/seisa.css',
        'css/MaterialIcons.css',
    ];
    public $js = [
        'sA/sweetalert.min.js',
        'js/yii_overrides.js',
        'js/axios.min.js',
    ];
    public $depends = [
       // 'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapAsset',
    ];
}
