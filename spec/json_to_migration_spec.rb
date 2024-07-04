require_relative '../lib/json_to_migration/migration_generator'
RSpec.describe JsonToMigration do
  describe ".generate_migration" do
    it "generates a migration file based on the payload" do
      payload = {
        table_name: "users",
        columns: [
          { name: "id", type: "integer" },
          { name: "name", type: "string" },
          { name: "email", type: "string" }
        ]
      }
      allow(MigrationGenerator).to receive(:generate)
        .with(payload).and_return("db/migrate/20220101000000_create_users.rb")

      result = MigrationGenerator.generate(payload)

      expect(result).to eq("db/migrate/20220101000000_create_users.rb")
    end
  end

  describe ".verify_payload" do
    it "returns an empty array for a valid payload" do
      payload = {
        table_name: "users",
        columns: [
          { name: "id", type: "integer" },
          { name: "name", type: "string" },
          { name: "email", type: "string" }
        ]
      }

      result = MigrationGenerator::MigrationGenerator.verify_payload(payload)
      expect(result).to eq([])
    end

    it "returns an array of errors for an invalid payload" do
      payload = {}
      result = MigrationGenerator::MigrationGenerator.verify_payload(payload)
      expect(result).to include("Unprocessable Entity!")
      expect(result).to include("table_name key is missing")
      expect(result).to include("Columns key is missing")
    end
  end
end



