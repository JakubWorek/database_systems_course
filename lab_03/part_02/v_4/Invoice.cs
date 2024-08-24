using System.ComponentModel.DataAnnotations;
using System.Text;

namespace lab{
  internal class Invoice{
    [Key]
    public int InvoiceNumber { get; set; }
    public virtual ICollection<InvoiceItem> InvoiceItems { get; set; }
    public override string ToString(){
      StringBuilder sn = new($"Invoice {InvoiceNumber}:");
      foreach (InvoiceItem item in InvoiceItems){
        sn.Append($"\t- {item}");
      }
      return sn.ToString();
    }
  }
}