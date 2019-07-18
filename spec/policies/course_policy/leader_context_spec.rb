# frozen_string_literal: true

require "rails_helper"

describe CoursePolicy do
  subject { described_class.new(leader, course) }

  let(:resolved_scope) do
    described_class::Scope.new(leader, Course.all).resolve
  end

  context "leader with active status accessing" do
    context "a published" do
      let(:leader) { create(:user, :leader) }
      let(:course) { create(:course, :published) }

      context "not own team course" do
        it "includes in resolved scope" do
          expect(resolved_scope).to include(course)
        end

        it { is_expected.to permit_actions(%i[show]) }
        it { is_expected.to forbid_actions(%i[create update destroy]) }
      end

      context "own team course" do
        let(:leader) { create(:user, :leader, team: course.team) }

        it "includes in resolved scope" do
          expect(resolved_scope).to include(course)
        end

        it { is_expected.to permit_actions(%i[show update create destroy]) }
      end
    end

    context "an unpublished" do
      let(:course) { create(:course, :unpublished) }

      context "own team course" do
        let(:leader) { create(:user, :leader, team: course.team) }

        it "includes in resolved scope" do
          expect(resolved_scope).to include(course)
        end

        it { is_expected.to permit_actions(%i[show update create destroy]) }
      end

      context "not own team course" do
        let(:leader) { create(:user, :leader) }

        it "excludes in resolved scope" do
          expect(resolved_scope).not_to include(course)
        end

        it { is_expected.to forbid_actions(%i[show update create destroy]) }
      end
    end
  end

  context "leader with inactive status" do
    let(:leader) { create(:user, :leader, status: :inactive) }
    let(:course) { create(:course, :published) }

    context "accessing a course" do
      it { is_expected.to forbid_actions(%i[show create update destroy]) }
    end
  end
end
