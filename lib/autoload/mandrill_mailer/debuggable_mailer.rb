require 'mandrill_mailer/template_mailer'

module MandrillMailer
  class DebuggableMailer < MandrillMailer::TemplateMailer
    def deliver
      MandrillMailer.config.letter_opener ? deliver_via_letter_opener : super
    end

    def deliver_now
      MandrillMailer.config.letter_opener ? deliver_via_letter_opener : super
    end

    protected

    def letter_template
      File.read(File.join(Rails.root, 'app/views/letter_opener', 'mandrill.erb'));
    end

    private

    def deliver_via_letter_opener
      temp_file = Tempfile.new([SecureRandom.hex, '.html'])
      temp_file.write ERB.new(letter_template).result(binding)
      temp_file.close
      Launchy.open(temp_file.path)
    end
  end
end
