# app/controllers/narudzbina_controller.rb

require_relative 'validators/narudzbina_validator'

class NarudzbinaController < ApplicationController
    # before_action :auth_admin_token, only: [:index, :show, :destroy, :promeni_status]
    # before_action :auth_user_token, only: [:create, :update]
  
    # GET /narudzbines
    def index
      begin
        @narudzbine = Narudzbina.all
        render json: @narudzbine
      rescue StandardError => e
        puts e
        render json: { error: 'Internal error', data: e }, status: :internal_server_error
      end
    end
  
    # GET /narudzbines/:id
    def show
      begin
        @narudzbina = Narudzbina.find(params[:id])
        render json: narudzbina_with_associations(@narudzbina)
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Record not found' }, status: :not_found
      rescue StandardError => e
        puts e
        render json: { error: 'Internal error', data: e }, status: :internal_server_error
      end
    end
  
    # POST /narudzbines
    def create
      narudzbina_data = {
        zakazano_vreme: params[:zakazano_vreme],
        adresa: params[:adresa],
        telefon: params[:telefon],
        email: params[:email],
        ime_prezime: params[:ime_prezime],
        korisnik_id: params[:korisnik_id],
        sadrzaj: params[:sadrzaj],
      }
  
      # Validate Narudzbina data
      validation_result = NarudzbinaValidator.call(narudzbina_data)
      if !validation_result.success?
        return render json: { error: 'Invalid data' }, status: :bad_request
      end
  
      begin
        narudzbina = Narudzbina.create(
          zakazano_vreme: narudzbina_data[:zakazano_vreme],
          status_narudzbine: 'Nova',
          adresa: narudzbina_data[:adresa],
          telefon: narudzbina_data[:telefon],
          email: narudzbina_data[:email],
          ime_prezime: narudzbina_data[:ime_prezime],
          korisnik_id: narudzbina_data[:korisnik_id]
        )
  
        # Fetch existing Proizvod entries
        proizvodi = Proizvod.all
  
        # Add products to the order (StavkaNarudzbine)
        narudzbina_data[:sadrzaj].each do |proizvod_id, kolicina|
          proizvod = proizvodi.find_by(id: proizvod_id)
          jedinicna_cena = proizvod.cena * kolicina.to_i
  
          StavkaNarudzbine.create(
            narudzbina_id: narudzbina.id,
            proizvod_id: proizvod_id,
            kolicina: kolicina,
            jedinicna_cena: jedinicna_cena
          )
        end
  
        render json: narudzbina, status: :created
      rescue StandardError => e
        puts e
        render json: { error: 'Internal error', data: e }, status: :internal_server_error
      end
    end
  
    # PUT /narudzbines/:id
    def update
      narudzbina_id = params[:id]
      narudzbina_data = {
        zakazano_vreme: params[:zakazano_vreme],
        adresa: params[:adresa],
        telefon: params[:telefon],
        email: params[:email],
        ime_prezime: params[:ime_prezime],
        sadrzaj: params[:sadrzaj],
      }
  
      # Validate Narudzbina data
      validation_result = NarudzbinaValidator.call(narudzbina_data)
      if !validation_result.success?
        return render json: { error: 'Invalid data' }, status: :bad_request
      end
  
      begin
        narudzbina = Narudzbina.find(narudzbina_id)
  
        narudzbina.update(
          zakazano_vreme: narudzbina_data[:zakazano_vreme],
          adresa: narudzbina_data[:adresa],
          telefon: narudzbina_data[:telefon],
          email: narudzbina_data[:email],
          ime_prezime: narudzbina_data[:ime_prezime]
        )
  
        # Fetch existing StavkaNarudzbine entries for the Narudzbina
        existing_entries = StavkaNarudzbine.where(narudzbina_id: narudzbina_id)
    
        # Delete all entries with the naruudzbina_id
        existing_entries.each do |entry|
          entry.destroy
        end
  
        # Fetch existing Proizvod entries
        proizvodi = Proizvod.all
  
        # Create in table StavkaNarudzbine
        narudzbina_data[:sadrzaj].each do |proizvod_id, kolicina|
          proizvod, _ = Proizvod.find_by(id: proizvod_id)
          jedinicna_cena = proizvod.cena * kolicina.to_i
  
          StavkaNarudzbine.create(
            narudzbina_id: narudzbina.id,
            proizvod_id: proizvod_id,
            kolicina: kolicina,
            jedinicna_cena: jedinicna_cena
          )
        end
  
        render json: narudzbina
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Record not found' }, status: :not_found
      rescue StandardError => e
        puts e
        render json: { error: 'Internal error', data: e }, status: :internal_server_error
      end
    end
  
    # DELETE /narudzbines/:id
    def destroy
      begin
        narudzbina = Narudzbina.find(params[:id])
        StavkaNarudzbine.where(narudzbina_id: params[:id]).destroy_all
        narudzbina.destroy
        render json: { id: narudzbina.id }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Record not found' }, status: :not_found
      rescue StandardError => e
        puts e
        render json: { error: 'Internal error', data: e }, status: :internal_server_error
      end
    end
  
    # PUT /narudzbines/promeni-status/:id
    def promeni_status
      begin
        narudzbina = Narudzbina.find(params[:id])
        narudzbina.update(status_narudzbine: params[:status_narudzbine])
        render json: narudzbina
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Record not found' }, status: :not_found
      rescue StandardError => e
        puts e
        render json: { error: 'Internal error', data: e }, status: :internal_server_error
      end
    end
  
    private

    # additional narudzbina info
    def narudzbina_with_associations(narudzbina)
      narudzbina.as_json(include: {
        stavke_narudzbine: {
          only: [:id, :kolicina, :jedinicna_cena, :proizvod_id],
          include: { proizvod: { only: [:id, :naziv] } }
        }
      })
    end    
  
    # Authentication logic for admin token
    def auth_admin_token
        true 
      end
  end
  