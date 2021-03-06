<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\Adjudicator */

$this->title = $model->user->name;
$this->params['breadcrumbs'][] = ['label' => $model->tournament->fullname, 'url' => ['tournament/view', "id" => $model->tournament->id]];
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Adjudicators'), 'url' => ['index', "tournament_id" => $model->tournament->id]];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="adjudicator-view">

	<h1><?= Html::encode($this->title) ?></h1>

	<p>
		<?= Html::a(Yii::t('app', 'Update'), ['update', 'id' => $model->id, "tournament_id" => $model->tournament->id], ['class' => 'btn btn-primary']) ?>
		<?=
		Html::a(Yii::t('app', 'Delete'), ['delete', 'id' => $model->id, "tournament_id" => $model->tournament->id], [
			'class' => 'btn btn-danger',
			'data' => [
				'confirm' => Yii::t('app', 'Are you sure you want to delete this item?'),
				'method' => 'post',
			],
		])
		?>
	</p>

	<?=
	DetailView::widget([
		'model' => $model,
		'attributes' => [
			'societyName',
			'user.email',
			'user.gender',
			[
				'label' => 'Strength',
				'value' => $model->getStrengthOutput(),
			],
			'can_chair',
			'are_watched'
		],
	])
	?>

</div>
