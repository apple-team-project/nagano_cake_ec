class Admin::GenresController < Admin::ApplicationsController

  def index
    @genres=Genre.all 
    @genre=Genre.new
  end 
  
  def create
    genre=Genre.new(genre_params)
    genre.save
    redirect_to request.referer
  end 
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    genre = Genre.find(params[:id])
    genre.update(genre_params)
    redirect_to admin_genres_path
  end 
  
  private
   def genre_params
    params.require(:genre).permit(:name)
   end 
    
end
