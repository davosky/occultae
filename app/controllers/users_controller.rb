class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(last_name: :asc)
  end

  def show
    @groups = @user.groups.order(name: :asc)
    @nodes = @user.nodes.includes(features: :voices).order(:ancestry_depth, :name)

    group_node_ids = Node.joins(:groups).where(groups: { id: @user.group_ids }).pluck(:id)
    all_node_ids = (@user.node_ids + group_node_ids).uniq
    @all_accessible_nodes = Node.where(id: all_node_ids)
                                .includes(features: { voices: [ :groups, :users ] })
                                .order(:ancestry_depth, :name)
    @user_group_ids = @user.group_ids
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def confirm_delete
    @user = User.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      permitted = params.expect(user: [ :username, :email, :password, :password_confirmation, :first_name, :last_name, :gender, :birth_date, :birth_place, :fiscal_code, :category, :region, :province, :institute, :office, group_ids: [], node_ids: [] ])
      # Don't overwrite password on update if the field was left blank
      permitted.delete(:password) if permitted[:password].blank?
      permitted.delete(:password_confirmation) if permitted[:password_confirmation].blank?
      permitted
    end
end
