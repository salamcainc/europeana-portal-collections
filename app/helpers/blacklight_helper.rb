module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior

  def render_document_show_field_value(*args)
    options = args.extract_options!
    document = args.shift || options[:document]

    fields = args.shift || options[:field]
    [fields].flatten.each do |field|
      value = presenter(document).render_document_show_field_value field, options.except(:document, :field)
      return value unless value.blank?
    end
    nil
  end

  def render_index_field_value(*args)
    options = args.extract_options!
    document = args.shift || options[:document]

    fields = args.shift || options[:field]
    [fields].flatten.each do |field|
      value = presenter(document).render_index_field_value field, options.except(:document, :field)
      return value unless value.blank?
    end
    nil
  end
end