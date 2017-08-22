module Users
  module SignupWizard
    class Step2 < Step1
      # Apenas veja se o email possui um @.
      validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }

      def current_step
        :step2
      end

      def next_step
        :step3
      end
    end
  end
end
