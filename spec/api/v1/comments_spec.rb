# frozen_string_literal: true

require "rails_helper"

describe "comment" do
  let!(:subject) { create(:comment, commentable: create(:comment, commentable: create(:course))) }
  let!(:user) { create(:user) }

  describe "GET #comments" do
    context "when non authenticate" do
      # TODO
    end

    context "when authenticate" do
      it_behaves_like "Commentable_comment"
    end
  end

  describe "POST #create_comment" do
    context "when non authenticate" do
      # TODO
    end

    context "when authenticate" do
      it_behaves_like "Commentable_create"
    end
  end

  describe "PATCH #update_comment" do
    context "when non authenticate" do
      # TODO
    end

    context "when authenticate" do
      it_behaves_like "Commentable_update"
    end
  end

  describe "DELETE #destroy_comment" do
    context "when non authenticate" do
      # TODO
    end

    context "when authenticate" do
      it_behaves_like "Commentable_destroy"
    end
  end
end
