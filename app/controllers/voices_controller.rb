class VoicesController < ApplicationController
  before_action :set_voice, only: %i[ show edit update destroy ]

  def index
    @voices = Voice.all
  end

  def show
  end

  def new
    @voice = Voice.new
  end

  def edit
  end

  def create
    @voice = Voice.new(voice_params)

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

  def set_voice
    @voice = Voice.find(params[:id])
  end

  def voice_params
    params.require(:voice).permit(:name, :grouping, :value_option, :value_type, :feature_id, group_ids: [], user_ids: [])
  end
end
