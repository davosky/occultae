class VoicesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Voice.accessible_by(current_ability).ransack(params[:q])
    @voices = @q.result(distinct: true).order(:grouping, :name)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @voice.save
        format.html { redirect_to @voice, notice: "Voice was successfully created." }
        format.json { render :show, status: :created, location: @voice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @voice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @voice.update(voice_params)
        format.html { redirect_to @voice, notice: "Voice was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @voice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @voice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @voice.destroy!

    respond_to do |format|
      format.html { redirect_to voices_path, notice: "Voice was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def voice_params
    params.require(:voice).permit(:name, :grouping, :value_option, :value_type, :feature_id, group_ids: [], user_ids: [])
  end
end
