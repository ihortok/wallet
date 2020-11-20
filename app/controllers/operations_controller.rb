class OperationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_operation, only: %i[show edit update destroy]
  before_action :set_operation_params, only: :create

  def index
    @operations = current_user.operations
  end

  def show; end

  def new
    @operation = Operation.new
  end

  def create
    @operation = Operation.new(operation_params.merge({ user_id: current_user.id }))

    if @operation.save
      case @type_cd
      when 0 then @debit_account.update(balance: @debit_account.balance + @sum)
      when 1 then @credit_account.update(balance: @credit_account.balance - @sum)
      when 2
        if @credit_account == @debit_account
          @credit_account.update(balance: @credit_account.balance - @fee)
        else
          currecies_check
          @credit_account.update(balance: @credit_account.balance - (@sum + @fee))
          @debit_account.update(balance: @debit_account.balance + (@converted_sum || @sum))
        end
      end

      redirect_to @operation, notice: 'Operation was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @operation.destroy
    respond_to do |format|
      format.html { redirect_to operations_url, notice: 'Operation was successfully destroyed.' }
    end
  end

  private

  def set_operation
    @operation = Operation.by_user(current_user.id).find(params[:id])
  end

  def operation_params
    params.require(:operation).permit(:type_cd, :debit_account_id, :credit_account_id, :sum, :fee, :note)
  end

  def set_operation_params
    @type_cd = operation_params[:type_cd].to_i
    @debit_account = Account.find_by(id: operation_params[:debit_account_id])
    @credit_account = Account.find_by(id: operation_params[:credit_account_id])
    @sum = operation_params[:sum].to_i
    @fee = operation_params[:fee].to_i
  end

  def currecies_check
    credit_account_rate = @credit_account.currency&.rate
    debit_account_rate = @debit_account.currency&.rate

    return unless credit_account_rate && debit_account_rate

    return if credit_account_rate == debit_account_rate

    @converted_sum = (@sum / credit_account_rate * debit_account_rate).to_i
  end
end
