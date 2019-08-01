# frozen_string_literal: true

namespace :migrate_data do
  desc "Migrate old padawans to many mentors"
  task padawans_to_many_mentors: :environment do
    old_padawans = User.where.not(mentor_id: [nil, false])
    old_padawans.each do |padawan|
      mentor = User.find(padawan.mentor_id)
      mentor.padawans << padawan
    end
    old_padawans.update_all(mentor_id: nil)
  end
end
