defmodule GeoDataStorage.StorageAPITest do
  use GeoDataStorage.RepoCase, async: true

  alias GeoDataStorage.Report.ImportReport
  alias GeoDataStorage.StorageAPI

  describe "#parse_csv_file" do
    setup do
      file_path = "#{File.cwd!()}/test/fixtures/export_data_example.csv"

      {:ok, file_path: file_path}
    end

    test "Parse jobs. Return errors if there are some", %{file_path: file_path} do
      assert {:ok, %ImportReport{failed: 3, success: 23}} = StorageAPI.parse_csv_file(file_path)
    end
  end
end
