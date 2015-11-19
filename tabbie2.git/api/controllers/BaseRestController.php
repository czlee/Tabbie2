<?php
/**
 * BaseRestController.php File
 *
 * @package  Tabbie2
 * @author   jareiter
 * @version
 */

namespace api\controllers;

use yii\filters\auth\CompositeAuth;
use yii\filters\auth\HttpBasicAuth;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\filters\RateLimiter;
use yii\filters\VerbFilter;
use yii\rest\ActiveController as Controller;
use yii\web\Response;
use Yii;

class BaseRestController extends Controller
{

	public function init() {
		Yii::$app->user->enableSession = false;
		Yii::$app->user->loginUrl = null;
		Yii::$app->user->enableAutoLogin = false;
	}
	public function behaviors()
	{
		return [
			'contentNegotiator' => [
				'class' => ContentNegotiator::className(),
				'formats' => [
					'application/json' => Response::FORMAT_JSON,
					//'application/xml' => Response::FORMAT_XML,
				],
			],
			'verbFilter' => [
				'class' => VerbFilter::className(),
				'actions' => $this->verbs(),
			],
			'authenticator' => [
				'class' => CompositeAuth::className(),
				'authMethods' => [
					//HttpBasicAuth::className(),
					//HttpBearerAuth::className(),
					QueryParamAuth::className(),
				],
			],
			/*'rateLimiter' => [
				'class' => RateLimiter::className(),
				'enableRateLimitHeaders' => false, //Do not spoil
			],*/
		];
	}
}