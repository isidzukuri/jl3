class SetMysqlConfig < ActiveRecord::Migration[6.1]
  def change
    ActiveRecord::Base.connection
                      .exec_query("SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));")
  end
end
