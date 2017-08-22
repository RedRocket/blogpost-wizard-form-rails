class WizardsController < ApplicationController
  before_action :load_wizard, except: :perform_step

  def perform_step
    store_wizard_params_in_session

    @wizard = load_wizard(params[:current_step])

    if @wizard.valid?
      unless @wizard.next_step
        create
        return
      end

      redirect_to action: @wizard.next_step
    else
      render @wizard.current_step
    end
  end

  def create
    if @wizard.submit
      clean_wizard_session
      redirect_to users_path
    else
      render @wizard.class.STEPS.first
    end
  end

  def step1; end
  def step2; end
  def step3; end

  private

  def clean_wizard_session
    session[session_name] = nil
  end

  def load_wizard(step_name = action_name, attributes = session[session_name])
    @wizard =
      "Users::SignupWizard::#{step_name.camelize}".constantize.new(attributes)
  end

  def session_name
    :user_sign_up_attributes
  end

  def store_wizard_params_in_session
    if session[session_name].nil?
      session[session_name] = user_wizard_params.to_h
    else
      session[session_name].merge!(user_wizard_params)
    end
  end

  def user_wizard_params
    params.require(:"users_signup_wizard_#{params[:current_step]}").permit(:email, :username, :address)
  end
end
