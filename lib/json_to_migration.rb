require "json_to_migration/version"
require "json_to_migration/migration_generator"

module JsonToMigration
  # Entry point for using the MigrationGenerator from the outside
  # Generates a migration file based on the provided payload
  #
  # @param payload [Hash] The payload containing the data to generate the migration
  #   @option payload [String] :table_name The name of the table to create
  #   @option payload [Array<Hash>] :columns An array of hashes representing the columns to create
  #
  # @return [String] The path to the generated migration file
  def self.generate_migration(payload)
    MigrationGenerator::MigrationGenerator.generate(payload)
  end
end
