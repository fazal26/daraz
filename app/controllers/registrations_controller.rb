class RegistrationsController < Devise::RegistrationsController
  def create
    super do
      resource.add_role(params[:role])
      resource.save
    end
  end
end