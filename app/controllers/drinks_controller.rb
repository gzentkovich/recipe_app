class DrinksController < ApiController
  def index
    @drinks = Drink.select("id, title").all
    render json: @drinks.to_json

    # an alternative way to write the above
    # --------------------------------------
    # render json: Drink.select("id, title").all
  end

  def show
    @drink = Drink.find(params[:id])
    render json: @drink.to_json(:include => { :ingredients => { :only => [ :id, :description ] }} )
  end

  def create
    drink = Drink.create(drink_params)
    render json: drink
  end

  def destroy
    Drink.destroy(params[:id])
  end

  def update
    drink = Drink.find(params[:id])
    drink.update_attributes(drink_params)
    render json: drink
  end

  private

  def drink_params
    params.require(:fruit).permit(:title, :description, :steps, :source) 
  end
end
