class StaticPagesController < ApplicationController

  def letsencrypt
    render text: ENV['CERT']
  end

  def home
  end

  def about
  end

  def contact
  end

end
