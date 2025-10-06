class PaymentsController < ApplicationController
  def new
    @client_token=Braintree::ClientToken.generate
  end

  def create
    nonce = params[:payment_method_nonce]
    amount = params[:amount] || "10.00"

    result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      options: {
        submit_for_settlement: true
      }
    )

    if result.success?
      redirect_to payment_success_path(transaction_id: result.transaction.id)
    else
      Rails.logger.error("Braintree error: #{result.errors.map(&:message).join(', ')}")
      redirect_to payment_failure_path
    end
  end

  def success
    @transaction_id = params[:transaction_id]
  end

  def failure
  end
end
