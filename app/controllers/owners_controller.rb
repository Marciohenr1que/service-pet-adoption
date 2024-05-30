class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :update, :destroy]

  def index
    owners = owner_service.fetch_all
    render json: owners, each_serializer: OwnerSerializer
  end

  def show
    render json: @owner, serializer: OwnerSerializer
  end

  def create
    result = owner_service.create(owner_params)

    if result[:success]
      render json: result[:owner], serializer: OwnerSerializer, status: :created
    else
      render json: { errors: result[:errors], message: I18n.t('owners.errors.creation_failed') }, status: :unprocessable_entity
    end
  end

  def update
    result = owner_service.update(@owner, owner_params)

    if result[:success]
      render json: result[:owner], serializer: OwnerSerializer
    else
      render json: { errors: result[:errors], message: I18n.t('owners.errors.update_failed') }, status: :unprocessable_entity
    end
  end

  def destroy
    result = owner_service.destroy(@owner)

    if result[:success]
      render json: { message: I18n.t('owners.messages.owner_deleted') }, status: :ok
    else
      render json: { errors: result[:errors], message: I18n.t('owners.errors.deletion_failed') }, status: :unprocessable_entity
    end
  end

  private

  def set_owner
    @owner = owner_service.find(params[:id])
  end

  def owner_params
    params.require(:owner).permit(:name, :email, :phone)
  end

  def owner_service
    @owner_service ||= Integrations::Owners::OwnerService.new
  end
end
