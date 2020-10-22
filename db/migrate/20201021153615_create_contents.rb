class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.integer   :feed_id, index: true
      t.string    :title
      t.text      :description
      t.string    :author
      t.string    :category
      t.string    :url
      t.datetime  :pub_date
      t.boolean   :status
      t.timestamps
    end
  end
end
