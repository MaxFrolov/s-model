class UserMailer < BaseMailer

  def welcome(record, opts={})
    mandrill_mail(
        template: 'user-welcome',
        subject: 'Welcome to S-model!',
        to: opts[:to] || record.email,
        vars: {
            full_name: record.full_name
        }
    )
  end

  def reset_password_instructions(record, token, opts={})
    set_new_password_url = frontend_url('/change-password')

    mandrill_mail(
        template: 'reset-password-instructions',
        subject: 'Reset password instructions',
        to: opts[:to] || record.email,
        vars: {
            reset_url: backend_url('/api/auth/password/edit', reset_password_token: token, redirect_url: set_new_password_url)
        }
    )
  end
end
