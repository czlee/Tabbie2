<?php

use yii\db\Schema;
use yii\db\Migration;

class m151119_155725_api extends Migration
{
    public function up()
    {
        $this->execute("
          CREATE SEQUENCE IF NOT EXISTS \"api_user_id_seq\" ;
          CREATE TABLE IF NOT EXISTS \"api_user\" (
             \"id\" integer DEFAULT nextval('\"api_user_id_seq\"') NOT NULL,
             \"user_id\"   INT CHECK (\"user_id\" >= 0) NOT NULL,
             \"access_token\"   VARCHAR(45) NULL DEFAULT NULL,
             \"rl_timestamp\"   TIMESTAMP NOT NULL DEFAULT NOW(),
             \"rl_remaining\"   INT NOT NULL DEFAULT '0',
             primary key (\"id\")
          );
          CREATE INDEX \"api_user_user_id asc_idx\" ON \"api_user\" USING btree (\"user_id\");
          ALTER TABLE \"api_user\" ADD FOREIGN KEY (\"user_id\") REFERENCES \"user\" (\"id\");
        ");
    }

    public function down()
    {
        $this->dropTable("api_user");
    }

}
