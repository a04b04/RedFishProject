require "json"

class SysInfosController < ApplicationController
  before_action :set_sys_info, only: %i[show edit update destroy upload_import]

  def index
    @sys_infos = SysInfo.all
  end

  def show
    @imported_jsons = @sys_info.imported_jsons.order(created_at: :asc)

    if params[:import_id]
      @current_import = @imported_jsons.find(params[:import_id])
    else
      @current_import = @imported_jsons.last
    end

    if @current_import
      @json_data = JSON.parse(@current_import.raw_json) if @current_import
    end
  end

  def new
    @sys_info = SysInfo.new
  end

  def create
    uploaded_file = params[:data]

    if uploaded_file.nil?
      redirect_to new_sys_info_path, alert: "Please select a JSON file"
      return
    end

    raw_json = uploaded_file.read
    json_data = JSON.parse(raw_json)

    @sys_info = SysInfo.new(
      name: params[:name],
      u_position: params[:u_position],
      rack: params[:rack],
      slot: params[:slot],
      notes: params[:notes],
      system_model: json_data["Model"],
      max_memory: json_data["MemorySummary"]["TotalSystemMemoryGiB"]
    )

    if @sys_info.save
      @sys_info.imported_jsons.create!(
        raw_json: raw_json
      )

      redirect_to @sys_info
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def upload_import
    uploaded_file = params[:data]

    if uploaded_file.nil?
      redirect_to @sys_info, alert: "Please select a JSON file"
      return
    end

    raw_json = uploaded_file.read

    @sys_info.imported_jsons.create!(
      raw_json: raw_json
    )

    redirect_to @sys_info
  end

  def update
    if @sys_info.update(sys_info_params)
      redirect_to @sys_info
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sys_info.destroy
    redirect_to sys_infos_path
  end

  private

  def set_sys_info
    @sys_info = SysInfo.find(params[:id])
  end

  def sys_info_params
    params.expect(sys_info: [:name, :rack, :u_position, :slot, :notes])
  end
end