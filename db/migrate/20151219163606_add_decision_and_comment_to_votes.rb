class AddDecisionAndCommentToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :decision, :string
    add_column :votes, :comment, :string
  end
end
