class OperationsController < ApplicationController
  before_action :set_operation, only: %i[show edit update destroy]
  before_action :set_accounts_for_select, only: :new

  def index
    @operations = current_user.operations
  end

  def show; end

  def new
    @operation = Operation.new
  end

  def edit; end

  def create
    @operation = Operation.new(operation_params)

    if @operation.save
      redirect_to @operation, notice: 'Operation was successfully created.'
    else
      render :new
    end
  end

  def update; end

  def destroy; end

  private

  def set_operation
    @operation = Operation.by_user(current_user.id).find(params[:id])
  end

  def set_accounts_for_select
    @accounts_for_select = current_user.accounts.collect { |a| [a.name, a.id] }
  end

  def operation_params
    params.require(:operation).permit(:note, :account_id, :type_cd)
  end
end
