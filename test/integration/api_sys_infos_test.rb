require "test_helper"

class ApiSysInfosTest < ActionDispatch::IntegrationTest
  setup do
    @sys_info = SysInfo.create!(
      name: "Existing Server",
      system_model: "PowerEdge R6525",
      max_memory: 512,
      logical_cpu: 32,
      rack: "Rack A",
      u_position: "12",
      slot: "1",
      notes: "Existing note"
    )
  end

  test "GET returns one sys info" do
    get api_sys_info_path(@sys_info), as: :json

    assert_response :success

    response_data = JSON.parse(response.body)

    assert_equal @sys_info.id, response_data["id"]
    assert_equal "Existing Server", response_data["name"]
    assert_equal "PowerEdge R6525", response_data["system_model"]
    assert_equal "32", response_data["logical_cpu"]
  end

  test "POST creates sys info and imported json" do
    redfish_data = {
      "Model" => "PowerEdge R750",
      "MemorySummary" => {
        "TotalSystemMemoryGiB" => 256
      },
      "ProcessorSummary" => {
        "LogicalProcessorCount" => 64
      }
    }

    assert_difference("SysInfo.count", 1) do
      assert_difference("ImportedJson.count", 1) do
        post api_sys_infos_path,
             params: {
               name: "API Server",
               rack: "Rack B",
               u_position: "24",
               slot: "2",
               notes: "Created through API test",
               raw_json: redfish_data.to_json
             },
             as: :json
      end
    end

    assert_response :created

    created_sys_info = SysInfo.last

    assert_equal "API Server", created_sys_info.name
    assert_equal "PowerEdge R750", created_sys_info.system_model
    assert_equal 256, created_sys_info.max_memory.to_i
    assert_equal "64", created_sys_info.logical_cpu
    assert_equal 1, created_sys_info.imported_jsons.count
  end

  test "PATCH updates an existing sys info" do
    patch api_sys_info_path(@sys_info),
          params: {
            sys_info: {
              name: "Updated Server",
              rack: "Rack C",
              notes: "Updated through API test"
            }
          },
          as: :json

    assert_response :success

    @sys_info.reload

    assert_equal "Updated Server", @sys_info.name
    assert_equal "Rack C", @sys_info.rack
    assert_equal "Updated through API test", @sys_info.notes
  end

  test "DELETE deletes an existing sys info" do
    assert_difference("SysInfo.count", -1) do
    delete api_sys_info_path(@sys_info), as: :json
    end

    assert_response :no_content
  end

end