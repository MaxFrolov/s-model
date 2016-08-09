module BaseControllerMethods
  extend ActiveSupport::Concern

  private

  def render_resource_or_errors(resource, options = {})
    if resource.errors.empty?
      render_resource_data(resource, options)
    else
      render_resource_errors(resource)
    end
  end

  def render_resource_data(resource, options = {})
    render options.merge({json: resource, root: :resource})
  end

  def render_resource_errors(resource)
    render json: {errors: resource.errors}, status: :unprocessable_entity
  end

  def render_resources(resources, options = {})
    options[:pagination] = true if options[:pagination].nil?
    pagination = options.delete(:pagination)
    ransack_query = options.delete(:ransack_query) || {}
    ransack_sort = options.delete(:ransack_sort) || params[:sort]

    resources = resources.ransack(ransack_query.to_hash.merge(s: ransack_sort)).result if ransack_sort || ransack_query.any?

    total = resources.respond_to?(:total_count) ? resources.total_count : resources.length
    default = {root: :resources, meta: {total: total}}
    results = pagination ? resources.page(params[:page]).per(params[:per_page]) : resources
    render({json: results}.merge(default).merge(options))
  end
end
