class Api::V1::MorphsController < ApplicationController
  def index
    morphs = Morph.all

    render json: morphs
  end

  def calculate
    calculation = CalcResultInteractor.call(params)
    result = calculation.result

    render json: result if calculation.success?
  end
end
