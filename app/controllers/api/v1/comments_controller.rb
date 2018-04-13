module Api
  module V1
    class CommentsController < ApplicationController
      include Commentable
    end
  end
end
