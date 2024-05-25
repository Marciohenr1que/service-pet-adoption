class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :update]

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
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  def update
    result = owner_service.update(@owner, owner_params)

    if result[:success]
      render json: result[:owner], serializer: OwnerSerializer
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end
  def destroy
    result = owner_service.update(@owner, owner_params)

    if result[:success]
      render json: result[:owner], serializer: OwnerSerializer
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
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
    @owner_service ||= Integrations::OwnersIntegration::OwnerService.new
  end
end