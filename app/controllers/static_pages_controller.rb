class StaticPagesController < ApplicationController

  def letsencrypt
    render plain: ENV[CERT]
  end

  def home
  end

  def about
  end

  def contact
  end

end
