# app/controllers/proizvod_controller.rb

require_relative 'validators/proizvod_validator'

class ProizvodController < ApplicationController
  before_action :auth_admin_token, only: [:create, :update, :destroy, :promeni_cenu]

  # GET /proizvod
  def index
    begin
      @proizvodi = Proizvod.includes(:kategorija).all
      render json: @proizvodi
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  # GET /proizvod/:id
  def show
    begin
      @proizvod = Proizvod.includes(:kategorija, cvetovi_u_proizvodu: [:cvet]).find(params[:id])

      render json: proizvod_with_associations(@proizvod)
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: :not_found
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end


  # POST /proizvod
  def create
    proizvod_data = {
    naziv: params[:naziv],
    opis: params[:opis],
    cena: params[:cena],
    kategorija: params[:kategorija],
    sadrzaj: params[:sadrzaj]
    }

    # Validate Proizvod data
    validation_result = ProizvodValidator.call(proizvod_data)
    if !validation_result.success?
      return render json: { error: 'Invalid data' }, status: :bad_request
    end

    begin
      proizvod = Proizvod.create(
        naziv: proizvod_data[:naziv],
        opis: proizvod_data[:opis],
        cena: proizvod_data[:cena],
        kategorija_id: proizvod_data[:kategorija]
      )

      # Add flowers to the product
      proizvod_data[:sadrzaj].each do |cvet_id, kolicina|
        cvet = Cvet.find_or_create_by(id: cvet_id)
        CvetUProizvodu.create(cvet_id: cvet.id, proizvod_id: proizvod.id, kolicina: kolicina)
      end

      render json: proizvod, status: :created
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  # PUT /proizvod/:id
  def update
    proizvod_id = params[:id]
    proizvod_data = {
      naziv: params[:naziv],
      opis: params[:opis],
      cena: params[:cena],
      kategorija: params[:kategorija],
      sadrzaj: params[:sadrzaj]
    }

    # Validate Proizvod data
    validation_result = ProizvodValidator.call(proizvod_data)
    if !validation_result.success?
      return render json: { error: 'Invalid data' }, status: :bad_request
    end

    begin
      proizvod = Proizvod.find(proizvod_id)

      proizvod.update(
        naziv: proizvod_data[:naziv],
        opis: proizvod_data[:opis],
        cena: proizvod_data[:cena],
        kategorija_id: proizvod_data[:kategorija]
      )

      existing_entries = CvetUProizvodu.where(proizvod_id: proizvod_id)

      updated_cvet_ids = proizvod_data[:sadrzaj].keys.map(&:to_i)

      # Delete all entries with the proizvod_id
      existing_entries.each do |entry|
        entry.destroy
      end

      # Create in table CvetUProizvodu
      proizvod_data[:sadrzaj].each do |cvet_id, kolicina|
        CvetUProizvodu.create({ cvet_id: cvet_id, proizvod_id: proizvod_id, kolicina: kolicina })
      end

      render json: proizvod
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: :not_found
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  # DELETE /proizvod/:id
  def destroy
    begin
      proizvod = Proizvod.find(params[:id])
      CvetUProizvodu.where(proizvod_id: params[:id]).destroy_all
      proizvod.destroy
      render json: { id: proizvod.id }
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: :not_found
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  # PUT /proizvod/promeni-cenu/:id
  def promeni_cenu
    begin
      proizvod = Proizvod.find(params[:id])
      proizvod.update(cena: params[:cena])
      render json: proizvod
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: :not_found
    rescue StandardError => e
      puts e
      render json: { error: 'Internal error', data: e }, status: :internal_server_error
    end
  end

  private

  # additional proizvod info
  def proizvod_with_associations(proizvod)
    proizvod.as_json(
      include: {
        kategorija: { only: [:id, :naziv] },
        cvetovi_u_proizvodu: {
          only: [:id, :kolicina, :cvet_id, :proizvod_id],
          include: { cvet: { only: [:id, :naziv] } }
        }
      },
      except: [:kategorija_id]
    )
  end

  # Authentication logic for admin token
  def auth_admin_token
    token = request.headers['Authorization']&.split(' ')&.last
    unless TokenAuthService.new(token).authenticate_admin
      render json: { error: 'Not Authorized' }, status: :unauthorized
      false
    end
  end

end

