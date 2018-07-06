# frozen_string_literal: true

class GraphqlController < ApplicationController # rubocop:disable Documentation

  def execute # rubocop:disable MethodLength
    variables = cast(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      session:      session,
      current_user: current_user
    }
    result = GraphqlTutorialSchema.execute(
      query,
      variables:      variables,
      context:        context,
      operation_name: operation_name
    )

    render json: result
  end

  private

    # gets current user from token stored in session
    def current_user
      # if we want to change the sign-in strategy, this is the place todo it
      return unless session[:token]

      encryptor = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
      token = encryptor.decrypt_and_verify(session[:token])
      user_id = token.gsub('user-id:', '').to_i

      User.find_by(id: user_id)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil
    end

    # Handle form data, JSON body, or a blank value
    def cast(input) # rubocop:disable MethodLength
      case input
      when String
        if input.present?
          cast(JSON.parse(input))
        else
          {}
        end
      when Hash, ActionController::Parameters
        input
      when nil
        {}
      else
        raise ArgumentError, "Unexpected parameter: #{input}"
      end
    end

end
