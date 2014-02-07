class AddAgreeingColumnsToPostingResponses < ActiveRecord::Migration
  def change
    add_column :posting_responses, :poster_agreed, :boolean
    add_column :posting_responses, :responder_agreed, :boolean
  end
end
