class SupportMailer < ApplicationMailer
    def user_support_request_email
        @support= params[:support]
        mail(to: @email, subject: "Ваше обращение в поддержку принято")
    end

    def admin_support_request_email
        @email = params[:support][:email]
        @body = params[:support][:body]
        mail(to: "admin@test.com", subject: "Новое обращение в поддержку")
    end
end
