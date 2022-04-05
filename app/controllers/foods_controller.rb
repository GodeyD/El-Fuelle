class FoodsController < ApplicationController
  before_action :set_food, only:[:show, :update, :edit, :destroy]

  def index
    # @foods = Food.all
    @foods = policy_scope(food).order(created_at: :desc)
  end

  def show
    authorize @food
  end

  def new
    @food = Food.new
    authorize @food
  end

  def create
    @food = Food.new(food_params)
    authorize @food
    @food.save
    redirect_to food_path(@food)
  end

  def edit
  end

  def update
    @food.update(food_params)
    redirect_to food_path(@food)
  end

  def destroy
    @food.destroy
    authorize @food
    redirect_to foods_path
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :description, :price)
  end

end
