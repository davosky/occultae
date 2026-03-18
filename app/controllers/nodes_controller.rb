class NodesController < ApplicationController
  before_action :set_node, only: %i[ show edit update destroy ]

  def index
    @q = Node.ransack(params[:q])
    @nodes = @q.result(distinct: true).order(:ancestry_depth, :name)

    @tree = Node.arrange(order: :name)
    @branch_ids = []
  end

  def show
    @tree = @node.root.subtree.arrange(order: :name)
    @branch_ids = (@node.ancestor_ids + [ @node.id ])
  end

  def new
    @node = Node.new
  end

  def edit
  end

  def create
    @node = Node.new(node_params)

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
    @node = Node.find(params[:id])
  end

  private
    def set_node
      @node = Node.find(params.expect(:id))
    end

    def node_params
      params.expect(node: [ :name, :ancestry, :ancestry_depth, :parent_id ])
    end
end
