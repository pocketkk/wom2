class Api::V1::WorkordersController < ApiController
  def show
    @workorder = Workorder.find(params[:id])
  end

  def create
    @workorder = Workorder.new(workorder_params)

    if @workorder.save
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @workorder.errors.full_messages
      }, status: 422
    end
  end

  def update
    @workorder = Workorder.find(params[:id])
    
    if @workorder.update_attributes(workorder_params)
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @workorder.errors.full_messages
      }, status: 422
    end

  end

  private

    def workorder_params
      {
        customer: params[:customer],
        address: params[:address],
        phone: params[:phone],
        user: user
      }
    end

    def user
      User.find_or_create_by(device_token: device_token)
    end

    def device_token
      params[:user].try(:[], :device_token)
    end
      
end
