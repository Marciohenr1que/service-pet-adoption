class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :update]

  def index
    @owners = owner_repository.all
    render json: @owners
  end

  def show
    render json: @owner
  end

  def create
    @owner = owner_repository.create(owner_params)

    if @owner.save
      render json: @owner, status: :created
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  def update
    if owner_repository.update(@owner, owner_params)
      render json: @owner
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  private

  def set_owner
    @owner = owner_repository.find(params[:id])
  end

  def owner_params
    params.require(:owner).permit(:name, :email, :phone)
  end

  def owner_repository
    @owner_repository ||= OwnerRepository.new
  end
end