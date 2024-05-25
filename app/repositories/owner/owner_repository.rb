class OwnerRepository
  def all
    Owner.includes(:pets).all
  end

  def find(id)
    Owner.includes(:pets).find(id)
  end

  def create(params)
    Owner.new(params)
  end

  def update(owner, params)
    owner.update(params)
  end
  def destroy(owner)
    owner.destroy(params)
  end
end
