class Api::V1::MorphsController < ApplicationController
  def index
    @morphs = Morph.all

    render json: @morphs
  end
end
