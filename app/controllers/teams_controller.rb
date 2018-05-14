class TeamsController < ApplicationController
  def index
    respond_with(@teams = Team.all)
  end
end
