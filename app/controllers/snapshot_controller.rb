class SnapshotController < ApplicationController
  def new
    @snapshot = Snapshot.new
  end

  def create
    @snapshot = Snapshot.create(snapshot_params)
    @snapshot.crawl
    if @snapshot.save
      flash[:success] = 'Snapshot created'
      redirect_to @snapshot
    else
      flash[:error] = @snapshot.errors.full_messages.to_sentence
      render :new
    end
  end

  def index
  end

  def delete
  end

  def show
  end

private

  def snapshot_params
    params.require(:snapshot).permit(:content)
  end
end
