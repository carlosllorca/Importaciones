<?php
return [
    'class' => 'yii\swiftmailer\Mailer',
    'useFileTransport' => false, //todo: OJO: Poner en false para que se envien los correos!!!
    'htmlLayout' => 'layouts/html',
    'transport' => [
        'class' => 'Swift_SmtpTransport',
        'host' => 'smtp.gmail.com',  // ej. smtp.mandrillapp.com o smtp.gmail.com
        'username' => 'carlosllorcasantana@gmail.com',
        'password' => 'micuent@',
        'port' => '587', // El puerto 25 es un puerto común también
        'encryption' => 'tls', // Es usado también a menudo, revise la configuración del servidor
    ]];