module Users
  module SignupWizard
    class Step1 < Base
      validates_presence_of :username

      def current_step
        :step1
      end

      def next_step
        :step2
      end
    end
  end
end
