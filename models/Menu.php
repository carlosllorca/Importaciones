<?php


namespace app\models;

use Yii;
use rce\material\widgets\Menu as RCEmenu;
class Menu
{
    static function getMenu() {
        $menu = RCEmenu::widget(
            [
                'items' => [
                    ['label' => 'Dashboard', 'icon' => 'dashboard', 'url' => ['/site/index']],
                    [
                        'label' => 'Multi Level Collapse',
                        'icon' => 'swap_vertical_circle',
                        'url' => '#',
                        'items' => [
                            ['label' => 'Level One', 'url' => '#',],
                            [
                                'label' => 'Level Two',
                                'icon' => 'swap_vertical_circle',
                                'url' => '#',
                                'items' => [
                                    ['label' => 'Level Three', 'url' => '#',],
                                    ['label' => 'Level Three', 'url' => '#',],
                                ],
                            ],
                        ],
                    ],
                    [
                        'label' => 'Some tools',
                        'icon' => 'build',
                        'url' => '#',
                        'items' => [
                            ['label' => 'Gii', 'icon' => 'settings_input_composite', 'url' => ['/gii'],],
                            ['label' => 'Debug', 'icon' => 'bug_report', 'url' => ['/debug'],],
                        ],
                    ],
                ],
            ]
        );
        return $menu;
    }
}