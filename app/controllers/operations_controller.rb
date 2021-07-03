# frozen_string_literal: true

# OperationsController
class OperationsController < ApplicationController
  include Pagy::Backend

  before_action :set_operation, only: %i[show edit update destroy]

  def index
    @pagy, @operations = pagy(current_user.operations)
  end

  def show; end

  def new
    @operation = Operation.new
  end

  def create
    @operation = Operation.new(operation_params.merge({ user_id: current_user.id }))

    if @operation.valid?
      result = AppServices::CreateOperationAndModifyAccounts.new(@operation).call

      redirect_to @operation, notice: 'Operation was successfully created.' and return if result.success?

      redirect_to operations_path, alert: result.error
    else
      render :new
    end
  end

  def destroy
    @operation.destroy

    redirect_to operations_url, notice: 'Operation was successfully destroyed.'
  end

  private

  def set_operation
    @operation = Operation.by_user(current_user.id).find(params[:id])
  end

  def operation_params
    params.require(:operation).permit(:type_cd, :debit_account_id, :credit_account_id, :sum, :fee, :note)
  end
end
