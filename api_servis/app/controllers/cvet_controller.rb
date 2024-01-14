# app/controllers/cvet_controller.rb

class CvetController < ApplicationController
  # before_action :auth_admin_token, only: [:create, :update, :destroy]

  # GET /cvets
  def index
    begin
      @cvetovi = Cvet.all
      render json: @cvetovi
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  # GET /cvets/:id
  def show
    begin
      @cvet = Cvet.find(params[:id])
      render json: @cvet
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: :not_found
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  # POST /cvets
  def create
    if validate_cvet_params
      begin
        @novi = Cvet.create(cvet_params)
        render json: @novi, status: :created
      rescue StandardError => e
        puts e
        render json: { error: 'Internal error', data: e }, status: :internal_server_error
      end
    else
      render json: { error: 'Invalid data' }, status: :bad_request
    end
  end

  # PUT /cvets/:id
  def update
    if validate_cvet_params
      begin
        @cvet = Cvet.find(params[:id])
        @cvet.update(cvet_params)
        render json: @cvet
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Record not found' }, status: :not_found
      rescue StandardError => e
        puts e
        render json: { error: 'Internal error', data: e }, status: :internal_server_error
      end
    else
      render json: { error: 'Invalid data' }, status: :bad_request
    end
  end

  # DELETE /cvets/:id
  def destroy
    begin
      @cvet = Cvet.find(params[:id])
      @cvet.destroy
      render json: { id: @cvet.id }
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: :not_found
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  private

  def cvet_params
    params.require(:cvet).permit(:naziv)
  end

  def validate_cvet_params
    required_params = params.require(:cvet).permit(:naziv)
    return true if required_params.present?
  
    render json: { error: 'Invalid data' }, status: :bad_request
    false  
  end

  # Authentication logic for admin token
  def auth_admin_token
    true 
  end

end
