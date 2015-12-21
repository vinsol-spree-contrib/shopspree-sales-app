module RespondWithResourceErrors
  extend ActiveSupport::Concern

  def respond_with(object=nil, options={})
    render json: object, meta: meta_for(object), status: options[:status]
  end

  def invalid_resource!(resource)
    respond_with(resource, status: 422)
  end
end
