class BaseMailer < MandrillMailer::DebuggableMailer
  default from: ENV['EMAIL_SENDER_EMAIL'], from_name: ENV['EMAIL_SENDER_NAME']

  private

  def mandrill_mail(args)
    args[:vars] ||= {}
    args[:vars][:root_url] = frontend_url('')
    args[:merge_language] = 'handlebars'
    super(args)
  end

  def frontend_url(path, query_params = {})
    site_url (ENV['FRONTEND_PORT'] || 80).to_i, path, query_params
  end

  def backend_url(path, query_params = {})
    site_url (ENV['PORT'] || 80).to_i, path, query_params
  end

  def site_url(port, path, query_params = {})
    uri_params = {scheme: ENV['PROTOCOL'], port: port, host: ENV['HOST'], path: path}
    uri_params.merge!({query: query_params.to_query}) if query_params.present?
    uri = URI::HTTP.build uri_params
    uri.to_s
  end
end
