module MigrationGenerator
    # This class generates a migration file based on a provided payload
    class MigrationGenerator
      # Generates a migration file based on the provided payload
      #
      # @param payload [Hash] The payload containing the data to generate the migration
      #   @option payload [String] :table_name The name of the table to create
      #   @option payload [Array<Hash>] :columns An array of hashes representing the columns to create
      #
      # @return [String] The path to the generated migration file
      def self.generate(payload)
        migration_name = "create_#{payload[:table_name]}"
        migration_content = generate_migration_content(migration_name, payload[:columns])
        create_migration_file(migration_name, migration_content)
      end

      # Generates the content for a migration file based on the provided payload
      #
      # @param migration_name [String] The name of the migration
      # @param columns [Array<Hash>] An array of hashes representing the columns to create
      #
      # @return [String] The content of the migration file
      def self.generate_migration_content(migration_name, columns)
        content = "class #{migration_name.camelize} < ActiveRecord::Migration[6.0]\n  def change\n    create_table :#{migration_name} do |t|\n"

        columns.each do |column|
          content += "      t.#{column[:type]} :#{column[:name]}\n"
        end

        content += "    end\n  end\nend\n"
        content
      end

      # Creates a migration file based on the provided migration name and content
      #
      # @param migration_name [String] The name of the migration
      # @param migration_content [String] The content of the migration file
      #
      # @return [String] The path to the generated migration file
      def self.create_migration_file(migration_name, migration_content)
        timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
        file_name = "#{timestamp}_#{migration_name.underscore}.rb"
        File.open(Rails.root.join('db', 'migrate', file_name), 'w') do |file|
          file.write(migration_content)
        end
        Rails.root.join('db', 'migrate', file_name)
      end
    end
  end
  