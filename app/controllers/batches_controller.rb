class BatchesController < ApplicationController
  before_action :set_batch, only: :show

  def index
    @batches = Batch.all
  end

  def show
    @days = @batch.days
  end

  private

  def set_batch
    @batch = Batch.find(params[:id])
  end
end
