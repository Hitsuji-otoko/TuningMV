class HomeController < ApplicationController
  before_action :authenticate_user!, only: :test
  def index
  end

  def test
  end

  def movie
  end
end
