namespace lab{
  internal class Product{
    public int ProductID { get; set; }
    public string ProductName { get; set; }
    public int UnitsOnStock { get; set; }
    public Supplier? Supplier { get; set; } = null;
    public override string ToString(){
      return $"{ProductName} ({UnitsOnStock} szt.)";
    }
  }
}