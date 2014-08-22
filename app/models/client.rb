class Client < ActiveRecord::Base

  has_many :projects, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :payments, dependent: :destroy

  default_scope {order(:name)}

  validates :name, presence: true, length: {minimum: 5}

  def invoice_open_entries(user, period = Time.now)

    entries = []

    self.projects.each do |project|
      project.tasks.each do |task|
        task.entries.each do |entry|
          if entry.done_at < period && entry.invoice.blank?
            entries << entry
          end
        end
      end
    end

    if entries.any?
      total = 0
      invoice = Invoice.create(user_id: user.id, client_id: self.id, starts_at: period - 30.days, ends_at: period)
      entries.each do |entry|
        total += entry.qty * entry.rate
        entry.invoice_id = invoice.id
        entry.save
      end
      invoice.total = total
      invoice.save
    end

  end

  def invoiced

    invoiced = 0.0

    self.projects.each do |project|
      project.tasks.each do |task|
        task.entries.each do |entry|
          invoiced += entry.qty * entry.rate
        end
      end
    end

    invoiced

  end

  def paid

    paid = 0.0

    self.payments.each do |payment|
      paid += payment.total.to_f
    end

    paid

  end

  def owed
    self.invoiced - self.paid
  end

  def to_s
    name
  end

end