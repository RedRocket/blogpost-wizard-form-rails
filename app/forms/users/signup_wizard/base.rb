module Users
  module SignupWizard
    STEPS = %w[step1 step2 step3].freeze

    class Base
      include ActiveModel::Model

      attr_accessor :user

      delegate *User.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :user
      delegate :errors, to: :user

      def initialize(user_attributes = {})
        @user = User.new(user_attributes)
      end

      def submit
        user.save
      end

      def steps
        STEPS
      end

      def current_step
        raise NotImplementedError
      end

      def next_step
        raise NotImplementedError
      end
    end
  end
end
