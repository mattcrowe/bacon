class InvoiceMailer < ActionMailer::Base

  def invoice_email(invoice, to, subj, msg)
    delivery_options = {
        user_name: Settings.get('smtp_email'),
        password: Settings.get('smtp_pass'),
        address: 'smtp.gmail.com',
        port: 587
    }

    attachments['invoice.pdf'] = File.read('%s/invoices/%s/%s.pdf' % [Rails.root, invoice.client.id, invoice.id])

    mail(
        from: Settings.get('smtp_email'),
        to: to,
        subject: subj,
        body: msg,
        delivery_method_options: delivery_options,
    )
  end

  # def notify
  #
  #   @invoice = Invoice.find(params[:id])
  #
  #   require 'net/smtp'
  #   msg = "Subject: %s\n\n%s" % [request[:subject], request[:body]]
  #   smtp = Net::SMTP.new 'smtp.gmail.com', 587
  #   smtp.enable_starttls
  #   smtp.start('gmail.com', Settings.get('smtp_email'), Settings.get('smtp_pass'), :login) do
  #     smtp.send_message(msg, Settings.get('smtp_email'), request[:email])
  #   end
  #
  #   flash[:success] = "success! invoice has been sent"
  #   redirect_to invoice_path(params[:id])
  #
  # end

end