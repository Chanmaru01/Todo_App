class GoalsController < ApplicationController
# Devise でログインしていないとこのコントローラのアクションを呼び出せないようにします。
# authenticate_user!というメソッドはdevise によって追加されたメソッドで
# ログインが済んでないユーザは root ページにリダイレクトされます。
  before_action :authenticate_user!
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # GET /goals
  def index
# 定義したインスタンス変数はビューの中で使用できる
# current_userは自分が「持っている」Goal のみ表示されるようになる
    @goals = current_user.goals.all
  end

  # GET /goals/new
  def new
    @goal = current_user.goals.new
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      @status = true
    else
      @status = false
    end
  end

  # PATCH/PUT /goals/1
  def update
    if @goal.update(goal_params)
      @status = true
    else
      @status = false
    end
  end

  # DELETE /goals/1
  def destroy
    @goal.destroy
  end

  private
    def set_goal
      @goal = current_user.goals.find_by(id: params[:id])
      redirect_to(goals_url, alert: "ERROR!!") if @goal.blank?
    end

    def goal_params
      params.require(:goal).permit(:title, :user_id)
    end
end
