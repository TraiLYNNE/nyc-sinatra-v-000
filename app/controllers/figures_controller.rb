class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all

    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])

    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'figures/edit'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    @figure.titles << Title.create(params[:title]) if !params["title"]["name"].empty?

    @figure.landmarks << Landmark.create(params[:landmark]) if !params["landmark"]["name"].empty?

    @figure.save

    redirect to "/figures/#{@figure.id}"
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])

    @figure.update(params["figure"])

    @figure.titles << Title.create(params[:title]) if !params["title"]["name"].empty?

    @figure.landmarks << Landmark.create(params[:landmark]) if !params["landmark"]["name"].empty?

    @figure.save

    redirect to "/figures/#{@figure.id}"

  end
end
