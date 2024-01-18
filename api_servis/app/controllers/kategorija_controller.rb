# app/controllers/kategorija_controller.rb

class KategorijaController < ApplicationController
  before_action :auth_admin_token, only: [:create, :update, :destroy]

  # GET /kategorijas
  def index
    begin
      @kategorije = Kategorija.all
      render json: @kategorije
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  # GET /kategorijas/:id
  def show
    begin
      @kat = Kategorija.find(params[:id])
      render json: @kat
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: :not_found
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  # POST /kategorijas
  def create
    if validate_kategorija_params
      begin
        @novi = Kategorija.create(kategorija_params)
        render json: @novi, status: :created
      rescue StandardError => e
        puts e
        render json: { error: 'Internal error', data: e }, status: :internal_server_error
      end
    else
      render json: { error: 'Invalid data' }, status: :bad_request
    end
  end

  # PUT /kategorijas/:id
  def update
    if validate_kategorija_params
      begin
        @kat = Kategorija.find(params[:id])
        @kat.update(kategorija_params)
        render json: @kat
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

  # DELETE /kategorijas/:id
  def destroy
    begin
      @kat = Kategorija.find(params[:id])
      @kat.destroy
      render json: { id: @kat.id }
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: :not_found
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  private

  # Authentication logic for admin token
  def auth_admin_token
    token = request.headers['Authorization']&.split(' ')&.last
    unless TokenAuthService.new(token).authenticate_admin
      render json: { error: 'Not Authorized' }, status: :unauthorized
      false
    end
  end

  def kategorija_params
    params.require(:kategorija).permit(:naziv)
  end

  def validate_kategorija_params
    schema = { naziv: { type: :string, presence: true } }
    validator = JsonSchemaValidator.new(schema)
    validator.validate(params[:kategorija])
  end

  def validate_kategorija_params
    required_params = params.require(:kategorija).permit(:naziv)
    return true if required_params.present?

    render json: { error: 'Invalid data' }, status: :bad_request
    false
  end
  
end
