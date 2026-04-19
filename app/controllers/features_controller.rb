class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[ show edit update destroy confirm_delete ]

  def index
    @q = Feature.ransack(params[:q])
    @features = @q.result(distinct: true).order(:grouping, :name)
  end

  def show
    @voices = @feature.voices.order(grouping: :asc, name: :asc)
  end

  def new
    @feature = Feature.new(node_id: params[:node_id])
    @feature.voices.build
  end

  def edit
    @feature.voices.build if @feature.voices.empty?
  end

  def create
    @feature = Feature.new(feature_params)

    respond_to do |format|
      if @feature.save
        format.html { redirect_to features_path, notice: "Feature was successfully created." }
        format.json { render :show, status: :created, location: @feature }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    normalize_group_ids
    respond_to do |format|
      if @feature.update(feature_params)
        format.html { redirect_to features_path, notice: "Feature was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @feature }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feature.destroy!

    respond_to do |format|
      format.html { redirect_to features_path, notice: "Feature was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def confirm_delete
  end

  private

  def normalize_group_ids
    params[:feature][:voices_attributes]&.each do |_k, voice|
      voice[:group_ids] = voice[:group_ids].split(",") if voice[:group_ids].is_a?(String)
      voice[:user_ids] = voice[:user_ids].split(",") if voice[:user_ids].is_a?(String)
    end
  end
    def set_feature
      @feature = Feature.find(params.expect(:id))
    end

    def feature_params
      # params.expect(feature: [ :name, :grouping, :node_id ])
      params.require(:feature).permit(:name, :grouping, :node_id, voices_attributes: [ :id, :name, :grouping, :value_option, :value_type, :_destroy, group_ids: [], user_ids: [] ])
    end
end
