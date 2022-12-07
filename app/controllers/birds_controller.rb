class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  def update 
    bird = Bird.find_by(id: params[:id])
    if bird 
      bird.update(bird_params)
      render json: bird
    else 
      render json: {error: "Birb not found"}, status: :not_found 
    end
  end
  # custom routes break RESTful onventions. to keep RESTful- create new controller, such as Birds::LikesController, and add an update action in this controller
  # whenever I have the inclination that I want to add a method on a controller that’s not part of the default five or whatever REST actions that we have by default, make a new controller! And just call it that.
  def increment_likes 
    bird = Bird.find_by(id: params[:id])
    if bird 
      bird.update(likes: bird.likes +1)
      render json: bird 
    else 
      render json: {error: "Bird not found"}, status: :not_found 
    end
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

end
