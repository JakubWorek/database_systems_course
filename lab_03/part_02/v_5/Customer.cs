using System.ComponentModel.DataAnnotations.Schema;

namespace lab{
  [Table("Customers")]
  internal class Customer : Company{
    public int CustomerID { get; set; }
    public int Discount { get; set; }
    public override string ToString(){
      return $"{base.ToString()} (klient)";
    }
  }
}