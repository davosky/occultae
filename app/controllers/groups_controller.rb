class GroupsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Group.accessible_by(current_ability).ransack(params[:q])
    @groups = @q.result(distinct: true).order(name: :asc)
  end

  def show
    @users = @group.users.order(last_name: :asc)
    @nodes = @group.nodes.order(name: :ASC)
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_path, notice: "Group was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy!

    respond_to do |format|
      format.html { redirect_to groups_path, notice: "Group was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def confirm_delete
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [], node_ids: [], child_group_ids: [])
  end
end
