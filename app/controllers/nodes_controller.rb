class NodesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Node.accessible_by(current_ability).ransack(params[:q])
    @nodes = @q.result(distinct: true).order(:ancestry_depth, :name)

    @tree = Node.arrange(order: :name)
    @branch_ids = []
  end

  def show
    @tree = @node.root.subtree.arrange(order: :name)
    @branch_ids = (@node.ancestor_ids + [ @node.id ])
    @groups = @node.groups.includes(:users).order(name: :ASC)
    @users = @node.users.order(last_name: :ASC)
    @features = @node.features.includes(voices: [ :groups, :users ]).order(grouping: :ASC, name: :ASC)
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @node.save
        format.html { redirect_to nodes_path, notice: "Node was successfully created." }
        format.json { render :show, status: :created, location: @node }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to nodes_path, notice: "Node was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @node }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @node.destroy!

    respond_to do |format|
      format.html { redirect_to nodes_path, notice: "Node was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def confirm_delete
  end

  private

  def node_params
    params.expect(node: [ :name, :enabled, :enabled_login, :application_filters, :ancestry, :ancestry_depth, :parent_id, group_ids: [], user_ids: [] ])
  end
end
