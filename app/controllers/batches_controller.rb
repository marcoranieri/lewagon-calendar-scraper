class BatchesController < ApplicationController
  before_action :set_batch, except: [:index]
  before_action :set_days , except: [:index]

  def index
    @batches = Batch.my_batches(current_user)
  end

  def show

    render_action_with( action: :show, value: @days )
  end

  def teacher
    teacher_days = @days.select{ |day| teacher?(day) }

    render_action_with( action: :show, value: teacher_days )
  end

  def assistant
    assistant_days = @days.reject{ |day| teacher?(day) }

    render_action_with( action: :show, value: assistant_days )
  end


private

  def set_batch
    @batch = Batch.find(params[:id])
  end

  def set_days
    @days = @batch.days.where("? = ANY(colleagues)", current_user.username )
  end

  def render_action_with(**args)
    render action: args[:action], locals: { days: args[:value]}
  end

  def teacher?(day)
    day.colleagues.first == current_user.username
  end
end
