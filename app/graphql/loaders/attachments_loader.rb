# frozen_string_literal: true

module Loaders
  module AttachmentsLoader
    extend self
    
    ATTACHED_NAMES = %w[video poster avatar].freeze

    def load_many(object, ast_node)
      fields = ast_node.selections.map(&:name)
      children_name = ast_node.name
      children = object.public_send(children_name)
      build_reply(fields, children)
    end

    private

    def build_reply(fields, children)
      mutual_names = ATTACHED_NAMES & fields
      return children if mutual_names.empty?
      methods = mutual_names.map { |name| "with_attached_#{name}" }
      methods.reduce(children) { |child, method| child.public_send(method) }
    end
  end
end
