class DaysController < ApplicationController
  before_action :set_day, only: :show

  def index
    @batch = Batch.find(params[:batch_id])
    @days = @batch.days
  end

  def show
  end

  private

  def set_day
    @batch = Batch.find(params[:batch_id])
    @day = Day.find(params[:id])
  end
end
