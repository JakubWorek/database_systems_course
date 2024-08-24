using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace lab{
  class InvoiceItem{
    [Key, Column(Order = 0)]
    public int InvoiceNumber { get; set; }
    [Key, Column(Order = 1)]
    public int ProductID { get; set; }
    public virtual Invoice Invoice { get; set; }
    public virtual Product Product { get; set; }
    public int Quantity { get; set; }
    public override string ToString()
    {
      return $"{Product} ({Quantity} szt.)";
    }
  }
}