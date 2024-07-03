require "json_to_migration/version"
require "json_to_migration/migration_generator"

module JsonToMigration
  # Entry point for using the MigrationGenerator from the outside
  def self.generate_migration(payload)
    MigrationGenerator::MigrationGenerator.generate(payload)
  end
end
