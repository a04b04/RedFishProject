class Api::SysInfosController < ApplicationController
  skip_forgery_protection

  def show
    @sys_info = SysInfo.find(params[:id])

    render json: @sys_info
  end

  def create
    raw_json = params.require(:raw_json)
    json_data = JSON.parse(raw_json)

    @sys_info = SysInfo.new(
      name: params[:name],
      rack: params[:rack],
      u_position: params[:u_position],
      slot: params[:slot],
      notes: params[:notes],
      system_model: json_data["Model"],
      max_memory: json_data.dig(
        "MemorySummary",
        "TotalSystemMemoryGiB"
      ),
      logical_cpu: json_data.dig(
        "ProcessorSummary",
        "LogicalProcessorCount"
      )
    )

    if @sys_info.save
      @sys_info.imported_jsons.create!(
        raw_json: raw_json
      )

      render json: @sys_info, status: :created
    else
      render json: {
        errors: @sys_info.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    @sys_info = SysInfo.find(params[:id])

    if @sys_info.update(sys_info_params)
      render json: @sys_info, status: :ok
    else
      render json: {
        errors: @sys_info.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def sys_info_params
    params.require(:sys_info).permit(
      :name,
      :system_model,
      :max_memory,
      :logical_cpu,
      :rack,
      :u_position,
      :slot,
      :notes
    )
  end
end