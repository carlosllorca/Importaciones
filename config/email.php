<?php
return [
    'class' => 'yii\swiftmailer\Mailer',
    'useFileTransport' => true, //todo: OJO: Poner en false para que se envien los correos!!!
    'htmlLayout' => 'layouts/html',
    'transport' => [
        'class' => 'Swift_SmtpTransport',
        'host' => 'gator3252.hostgator.com',  // ej. smtp.mandrillapp.com o smtp.gmail.com
        'username' => 'inmaj@codeberrysolutions.com',

        'password' => 'codeberry19',
        'port' => '25', // El puerto 25 es un puerto común también
       // 'encryption' => 'tls', // Es usado también a menudo, revise la configuración del servidor
    ]];