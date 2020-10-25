class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.integer   :feed_id, index: true
      t.string    :document_feed_id, index: true
      t.string    :title
      t.text      :description
      t.string    :url
      t.datetime  :pub_date
      t.boolean   :readed, default: false
      t.timestamps
    end
  end
end
