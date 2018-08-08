class Payment < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :loan
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :payment_is_greater_than_loan

  private

  def payment_is_greater_than_loan
    loan = Loan.find(self.loan_id)
    if self.amount.to_f > loan.funded_amount
      self.errors.add(:amount, message: "payment cannot exceed loan.funded_amount", status: :unprocessable_entity)
    end
  end

end
