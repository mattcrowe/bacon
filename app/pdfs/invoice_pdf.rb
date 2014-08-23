class InvoicePdf < Prawn::Document

  def initialize(invoice)
    super()
    @invoice = invoice
    header
    font 'Helvetica'
    entry_table
    total
    footer
  end

  def precision(num)
    sprintf( "%0.02f", num)
  end

  def header

    move_cursor_to 710

    text "Invoice prepared for:", :style => :bold
    move_down 15
    text @invoice.client.name.capitalize
    text @invoice.client.address1
    text '%s, %s %s' % [@invoice.client.city, @invoice.client.state, @invoice.client.zip]

    move_cursor_to 700

    text "Invoice: #" + @invoice.id.to_s, :align => :right
    text "   From: " + @invoice.starts_at.strftime("%m/%d/%Y"), :align => :right
    text "     To: " + @invoice.ends_at.strftime("%m/%d/%Y"), :align => :right

  end

  def entry_table

    move_cursor_to 600

    table entries, :width => 535 do
      row(0).font_style = :bold
      self.header = true
      self.column_widths = {0 => 50, 1 => 65, 2 => 275, 3 => 70, 4 => 75}
    end
  end

  def entries
    [["Qty", "Date", "Description", "Rate", "Amount"]] +
        @invoice.entries.map do |entry|
          [
              precision(entry.qty),
              entry.done_at.strftime("%m/%d/%y"),
              "#{entry.task.project.name} > #{entry.task.name}",
              '$' + precision(entry.rate),
              '$' + precision(entry.qty * entry.rate)
          ]
        end
  end

  def total
    table ([["Total", '$' + precision(@invoice.total)]]), :width => 535 do
      columns(0).align = :right
      columns(1).align = :left
      self.header = true
      self.column_widths = {0 => 460, 1 => 75}
      columns(0).font_style = :bold
    end
  end

  def footer
    move_down 25
    text "Make Checks Payable To:", style: :bold
    text Settings.get('invoice_name')
    text Settings.get('invoice_address1')
    text '%s, %s %s' % [Settings.get('invoice_city'), Settings.get('invoice_state'), Settings.get('invoice_zip')]
  end

end