class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.string :type, null: false
      t.string :title, null: false
      t.text :description
      t.string :origin
      t.string :tags, array: true, default: []

      t.timestamps
    end

    reversible do |direction|
      direction.up do
        execute <<-SQL
          ALTER TABLE alerts
          ADD CONSTRAINT check_alert_type
          CHECK (type IN ('portal_opened', 'portal_closed'))
        SQL
      end
    end

    add_index :alerts, :type
    add_index :alerts, :tags, using: "gin"
  end
end
