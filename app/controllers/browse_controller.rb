class BrowseController < ApplicationController
  def configs
    @configs = AmandaConfig.find(:all, :include => [:tapes, :dles])
  end

  def dle
    @dle = Dle.find(params[:id])
  end

  def tape
    @tape = Tape.find(params[:id])
  end

  def run
    @run = Run.find(params[:id])
  end

end
