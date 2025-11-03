class GraphqlController < ApplicationController
  protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user
    }
    result = BankingDashboardSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  def current_user
    auth = request.headers['Authorization']
    return nil unless auth&.start_with?('Bearer ')
    token = auth.split(' ').last
    payload = JwtService.decode(token)
    return nil unless payload && payload['user_id']
    User.find_by(id: payload['user_id'])
  rescue
    nil
  end

  def prepare_variables(variables_param)
    case variables_param
    when String
      variables_param.present? ? JSON.parse(variables_param) : {}
    when Hash, ActionController::Parameters
      variables_param
    else
      {}
    end
  end
end
