class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :entries, -> { order "done_at" }

  def to_s
    'Invoice#' + id.to_s
  end

  def genpdf
    pdf = InvoicePdf.new(self)
    FileUtils.mkpath 'invoices/%s' % [self.client.id]
    File.open('invoices/%s/%s.pdf' % [self.client.id, self.id], 'wb') do |f|
      f.write(pdf.render)
    end
  end

end
