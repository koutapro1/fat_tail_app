class Api::V1::MorphsController < ApplicationController
  def index
    morphs = Morph.all

    render json: morphs
  end

  def calculate
    result = Morph.calc_morph_result(params)

    render json: result
  end
end
