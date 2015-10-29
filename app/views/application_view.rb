##
# A custom class for this project's Mustache templates
#
# Each page-specific view class should sub-class this.
#
# Public methods added to this class will be available to all Mustache
# templates.
class ApplicationView < Europeana::Styleguide::View
  include MustacheHelper

  def initialize(*args)
    super
    @mustache = {}
  end
end
