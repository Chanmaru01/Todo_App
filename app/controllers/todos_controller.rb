class TodosController < ApplicationController
# before_actionで,アクション前に実行されるメソッドを定義しています。
before_action :autohenticate_user!
before_action :set_goal
before_action :set_todo, only: [:show, :edit, :update, :destroy, :sort]
# current_userは、サインインしているuserのこと
  # GET /todos/new
  def new
  #@goalに紐付いたtodosをnewしています
    @todo = @goal.todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  def sort
  end

  # POST /todos
  def create
    @todo = @goals.todo.new(todo_params)

    if @todo.save
#create, #update の結果を @status という変数に反映する。
      @status = true
    else
      @status = false
    end
  end

  # PATCH/PUT /todos/1
  def update
  # todo_paramsはこのクラスのprivate以下で定義しています。
    if @todo.update(todo_params)
      @status = true
    else
      @status = false
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  end

  private
    def set_goal
      @goal = current_user.goals.find_by(id: params[:goal_id])
      redirect_to(goal_url, alert: "ERROR!!") if @goal.blank?
    end

    def set_todo
      @todo = @goal.todo.find_by(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:content, :goal_id, :position, :done)
    end
end
