class AddWordCountToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :word_count, :integer

  end
end
