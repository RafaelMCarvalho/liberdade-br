class ChangeDataTypeForPostEvaluationsApprove < ActiveRecord::Migration
  def change
    change_column :post_evaluations, :approve, :integer,
      :defaut => PostEvaluation::OPTIONS[:abstention]
  end
end
