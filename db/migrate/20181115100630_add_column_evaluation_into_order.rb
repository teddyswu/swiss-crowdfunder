class AddColumnEvaluationIntoOrder < ActiveRecord::Migration[5.1]
  def change
  	add_column :orders, :evaluation, :text, :after => :remark
  end
end
