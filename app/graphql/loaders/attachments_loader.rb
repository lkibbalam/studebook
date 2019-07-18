# frozen_string_literal: true

module Loaders
  module AttachmentsLoader
    module_function

    ATTACHED_NAMES = %w[video poster avatar].freeze

    def load_many(object, ast_node, includes = nil)
      fields = collect_fields(ast_node)
      children_name = ast_node.name
      children = object ? object.public_send(children_name) : to_class(children_name)
      children = children.includes(includes) if includes
      build_reply(fields, children).all
    end

    def build_reply(fields, children)
      mutual_names = ATTACHED_NAMES & fields
      return children if mutual_names.empty?

      mutual_names.map { |name| "with_attached_#{name}" }.inject(children, :public_send)
    end

    def collect_fields(ast_node)
      return ast_node.selections.map(&:name) if ast_node.selections.first.name != "edges"

      ast_node.selections.first.selections.first.selections.map(&:name)
    end

    def to_class(string)
      string.singularize.titleize.delete(" ").constantize
    end
  end
end
