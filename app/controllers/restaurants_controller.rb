class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @restaurants = Restaurant.all.order('name DESC')
  end

  def show
    @reviews = Review.where(restaurant_id: @restaurant.id).order("created_at DESC")
    if @reviews.blank?
      @avg_overall = 0
      @avg_quality = 0
      @avg_price = 0
      @avg_environment= 0
    else
      @avg_quality = @reviews.average(:quality).round(2)
      @avg_price = @reviews.average(:price).round(2)
      @avg_environment= @reviews.average(:environment).round(2)
    end
  end

  def new
    @restaurant = current_user.restaurants.build
  end

  def edit
  end

  def create
    @restaurant = current_user.restaurants.build(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :description, :quality, :price, :environment, :overall, :image)
    end
end
