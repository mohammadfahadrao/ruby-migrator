module MigrationGenerator
    class MigrationGenerator
      def self.generate(payload)
        # Here you will process the payload
        # For example, let's say the payload is a hash that describes columns
        migration_name = "create_#{payload[:table_name]}"
        migration_content = "class #{migration_name.camelize} < ActiveRecord::Migration[6.0]\n  def change\n    create_table :#{payload[:table_name]} do |t|\n"
  
        payload[:columns].each do |column|
          migration_content += "      t.#{column[:type]} :#{column[:name]}\n"
        end
  
        migration_content += "    end\n  end\nend\n"
        create_migration_file(migration_name, migration_content)
      end
  
      def self.create_migration_file(migration_name, migration_content)
        timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
        file_name = "#{timestamp}_#{migration_name.underscore}.rb"
        File.open(Rails.root.join('db', 'migrate', file_name), 'w') do |file|
          file.write(migration_content)
        end
      end
    end
  end
  