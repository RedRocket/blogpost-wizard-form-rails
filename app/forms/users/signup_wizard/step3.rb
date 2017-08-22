module Users
  module SignupWizard
    class Step3 < Step2
      validates :address, presence: true

      def current_step
        :step3
      end

      def next_step
        nil
      end
    end
  end
end
