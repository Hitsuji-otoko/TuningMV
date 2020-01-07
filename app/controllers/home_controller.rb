class HomeController < ApplicationController
  before_action :authenticate_user!, only: :movie
  
  def index
  end

  def test
    binding.pry
  end

  def movie
  end
end
